import logging
import os
import json
from google import genai
from google.genai.types import GenerateContentConfig

from .api.chart_api import generate_chart, get_chart_schema, save_chart_image
from .api.data_api import get_topic_data, get_topics
from .messages import IncomingMessage, OutgoingMessage

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')
logger = logging.getLogger(__name__)

genai_client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

FAILURE_ANSWER = "Non sono in grado di rispondere."

# Performs the LLM call with Gemini 2.
def call_genai_with_prompt(prompt: str) -> dict:
    try:
        response = genai_client.models.generate_content(
            model="gemini-2.5-flash",
            contents=prompt,
            config=GenerateContentConfig(response_mime_type="application/json")
        )
        raw = response.candidates[0].content.parts[0].text
        logging.info(f"LLM raw response: {raw}")
        return json.loads(raw)
    except Exception as e:
        logging.error(f"LLM call or parsing failed: {e}")
        return None

# Attempt to generate a chart using a remote backend.
def try_generate_chart(chart_request: dict) -> str:
    try:
        image = generate_chart(chart_request)
        return save_chart_image(image)
    except Exception as chart_err:
        logging.error(f"Chart generation failed: {chart_err}")
        return None

# Decorates the prompt.
def _generate_topic_reply(user_text: str, chapter_id: str, topic_key: str) -> OutgoingMessage:
    topic_data = get_topic_data(chapter_id, topic_key)
    chart_schema = get_chart_schema()

    prompt = f"""
        You are a chat assistant that knows about the University of Bologna "Bilancio di Sostenibilità". You received this message from the user:
        "{user_text}"

        The following topic was found as most relevant:
        {topic_data}

        Your task is to:

        1. Contextualize and try to the topic in **Italian** in a natural way without mentioning your instructions.
        2. Then, generate a JSON payload that can be used to create a chart about the topic, if appropriate. 
            If none of the available charts are optimal, skip this step.
            Do not mention the chart, the details should mainly be explained textually.

        The JSON must strictly follow this schema:
        {chart_schema}

        Your response must be a JSON object with the following structure:
        {{
          "reply": "<natural language response in Italian>",
          "chart_request": <chart_request_json> // null if there is no suitable chart
        }}
    """

    result = call_genai_with_prompt(prompt)
    if not result:
        return OutgoingMessage(reply=FAILURE_ANSWER)

    reply_text = result.get("reply", FAILURE_ANSWER)
    chart_request = result.get("chart_request")
    chart_url = try_generate_chart(chart_request) if chart_request else None

    return OutgoingMessage(reply=reply_text, chart_url=chart_url)

# Handles message with a free-chat text.
def generate_free_chat_reply(message: IncomingMessage) -> OutgoingMessage:
    logging.info("Free chat prompt received. Detecting topic...")
    topic_key = detect_topic(message.text, message.chapterId)
    logging.info(f"Detected topic key: {topic_key}")

    if topic_key is None:
        return OutgoingMessage(reply=FAILURE_ANSWER)

    return _generate_topic_reply(message.text, message.chapterId, topic_key)

# Handles message that target a specific topic.
def generate_strict_topic_reply(message: IncomingMessage) -> OutgoingMessage:
    logging.info("Strict chat prompt received.")
    return _generate_topic_reply(message.text, message.chapterId, message.topicKey)

# Returns the most suitable key, given a list of topics (of a given chapter) with key, label and description, if possible, else Null.
def detect_topic(user_text, chapter_id) -> str:
    topics = get_topics(chapter_id)
    logging.info(f"Topics to search from: {topics}")

    prompt = f"""
        Given the user's message and a list of available topics, choose the best matching topic key.
        If no match is suitable, return null.

        Your response must be a JSON object in the following format:
        {{
          "topic_key": "<key>"  // one of the provided keys, or null
        }}

        User message:
        "{user_text}"

        Available topics:
        {topics}
    """

    result = call_genai_with_prompt(prompt)
    return result.get("topic_key") if result else None