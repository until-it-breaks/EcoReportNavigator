import logging
import os
import json
from google import genai
from google.genai.types import GenerateContentConfig

from .chart_api import get_chart, get_chart_schema, save_chart_image
from .data_api import get_topic_data, get_topics
from .messages import IncomingMessage, OutgoingMessage

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')
logger = logging.getLogger(__name__)

genai_client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

# Generate an answer based on the best matching topic to the user question
def generate_free_chat_reply(message: IncomingMessage) -> OutgoingMessage:
    logging.info("Detecting topic...")
    topic_key = detect_topic(message.text, message.chapterId)
    logging.info(f"Detected topic key: {topic_key}")
    
    if (topic_key is None):
        return OutgoingMessage(reply="Non sono in grado di rispondere.")

    topic_data = get_topic_data(message.chapterId, topic_key)
    
    chart_schema = get_chart_schema()
    
    prompt = f"""
        You are a helpful assistant. You received this message from the user:
        "{message.text}"

        The following topic was found as most relevant:
        {topic_data}

        Your task is to:

        1. Contextualize and explain the topic in **Italian** in a natural way.
        2. Then, generate a JSON payload that can be used to create a chart about the topic, if appropriate. If the data is difficult to create, you are allowed to simplify it.

        The JSON must strictly follow this schema:
        {json.dumps(chart_schema, indent=2)}

        Your response must be a JSON object with the following structure:
        {{
        "reply": "<natural language response in Italian>",
        "chart_request": <chart_request_json>
        }}
        """
    
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
        config=GenerateContentConfig(response_mime_type="application/json")
    )
    
    try: 
        raw = response.candidates[0].content.parts[0].text
        logging.info(f"LLM raw response: {raw}")
        parsed = json.loads(raw)
        reply_text = parsed["reply"]
        chart_request = parsed.get("chart_request")
        
        chart_url = None
        if chart_request:
            try:
                image = get_chart(chart_request)
                chart_url = save_chart_image(image)
            except Exception as chart_err:
                logging.error(f"Chart generation failed: {chart_err}")

        return OutgoingMessage(reply=reply_text, chart_url=chart_url)

    except Exception as e:
        logging.error(f"Failed to parse LLM response: {e}")
        return OutgoingMessage(reply="La risposta non è stata generata correttamente.")

# Generate an answer to a set topic
def generate_strict_topic_reply(message: IncomingMessage) -> OutgoingMessage:
    topic_data = get_topic_data(message.chapterId, message.topicKey)
    chart_schema = get_chart_schema()
    
    prompt = f"""
        You are a helpful assistant. Contextualize the following topic in italian.

        Topic:
        {topic_data}
        
        Your task is to:

        1. Contextualize and explain the topic in **Italian** in a natural way.
        2. Then, generate a JSON payload that can be used to create a chart about the topic, if appropriate. If the data is difficult to create, you are allowed to simplify it.

        The JSON must strictly follow this schema:
        {json.dumps(chart_schema, indent=2)}

        Your response must be a JSON object with the following structure:
        {{
        "reply": "<natural language response in Italian>",
        "chart_request": <chart_request_json>
        }}
        """
    
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
        config=GenerateContentConfig(response_mime_type="application/json")
    )
    
    try: 
        raw = response.candidates[0].content.parts[0].text
        logging.info(f"LLM raw response: {raw}")
        parsed = json.loads(raw)
        reply_text = parsed["reply"]
        chart_request = parsed.get("chart_request")
        
        chart_url = None
        if chart_request:
            try:
                image = get_chart(chart_request)
                chart_url = save_chart_image(image)
            except Exception as chart_err:
                logging.error(f"Chart generation failed: {chart_err}")

        return OutgoingMessage(reply=reply_text, chart_url=chart_url)

    except Exception as e:
        logging.error(f"Failed to parse LLM response: {e}")
        return OutgoingMessage(reply="La risposta non è stata generata correttamente.")

# Matches user free questions to a given topic key via LLM.
def detect_topic(user_text, chapter_id) -> str:
    topics = get_topics(chapter_id)

    logging.info(f"Topics to search from: {topics}")
    
    prompt = f"""
        You are an assistant that matches questions to a known topic key.
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

    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
        config=GenerateContentConfig(
            response_mime_type="application/json",
        ),
    )

    try:
        raw = response.candidates[0].content.parts[0].text
        logging.info(f"LLM detection: {raw}")
        result = json.loads(raw)
        topic_key = result.get("topic_key")
        return topic_key
    except Exception as e:
        logging.info(f"Topic detection error: {e}")
        return None
