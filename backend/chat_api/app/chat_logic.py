import logging
import os
import json
from google import genai
from google.genai.types import GenerateContentConfig

from .data_api import getTopicData, getTopics
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

    topic_data = getTopicData(message.chapterId, topic_key)
    
    prompt = f"""
        You are a helpful assistant. You received this message from the user
        [{message.text}] and the following topic was automatically selected as the best match:
        
        Topic:
        {topic_data}
        
        Contextualize the following topic in italian.
        """
    
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt
    )

    return OutgoingMessage(reply=response.candidates[0].content.parts[0].text.strip())

# Generate an answer to a set topic
def generate_strict_topic_reply(message: IncomingMessage) -> OutgoingMessage:
    topic_data = getTopicData(message.chapterId, message.topicKey)
    
    prompt = f"""
        You are a helpful assistant. Contextualize the following topic in italian.

        Topic:
        {topic_data}
        """
    
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt
    )

    return OutgoingMessage(reply=response.candidates[0].content.parts[0].text.strip())

# Matches user free questions to a given topic key via LLM.
def detect_topic(user_text, chapter_id) -> str:
    topics = getTopics(chapter_id)

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
