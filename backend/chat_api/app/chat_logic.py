import re
from google import genai
from google.genai.types import Content, Part
import os
import json

from .data_api import getTopicData, getTopics
from .messages import IncomingMessage, OutgoingMessage

genai_client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

def serialize_content(content: Content) -> str:
    return json.dumps({
        "role": content.role,
        "parts": [part.text for part in content.parts]
    })

def deserialize_content(data: str) -> Content:
    obj = json.loads(data)
    return Content(role=obj["role"], parts=[Part(text=p) for p in obj["parts"]])

# Generate an answer based on the best matching topic to the user question
def generate_free_chat_reply(message: IncomingMessage) -> OutgoingMessage:
    print("Detecting...", flush=True)
    topic_key = detect_topic(message.text, message.chapterId)
    print(f"Detected key: {topic_key}", flush=True)
    
    if (topic_key is None):
        return OutgoingMessage(reply="Non sono in grado di rispondere.")

    topic_data = getTopicData(message.chapterId, topic_key)
    
    prompt = f"""
        You are a helpful assistant. You received this message from the user
        [{message.text}] and the following topic was automatically selected as the best match:
        
        Topic:
        {topic_data}
        
        Explain the following topic in italian.
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
        You are a helpful assistant. Explain the following topic in italian.

        Topic:
        {topic_data}
        """
    
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt
    )

    return OutgoingMessage(reply=response.candidates[0].content.parts[0].text.strip())

# Matches user free questions to a given topic key via LLM.
def detect_topic(user_text, chapter_id):
    topics = getTopics(chapter_id)

    print(topics, flush=True)
    
    prompt = f"""
        You are an assistant that matches questions to a known topic key.
        Given the user's message and a list of available topics, choose the best matching topic key.
        If no match is suitable, return "null".

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
        contents=prompt
    )

    try:
        raw = response.candidates[0].content.parts[0].text.strip()
        print("Raw response:", raw, flush=True)

        if raw.startswith("```"):
            raw = re.sub(r"^```[a-zA-Z]*\n?", "", raw)
            raw = re.sub(r"\n?```$", "", raw)

        result = json.loads(raw)
        topic_key = result.get("topic_key")
        return topic_key
    except Exception as e:
        print("Topic detection error:", e)
        return None
