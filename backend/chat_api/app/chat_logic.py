from google import genai
from google.genai.types import Content, Part
import os
import json

genai_client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

def serialize_content(content: Content) -> str:
    return json.dumps({
        "role": content.role,
        "parts": [part.text for part in content.parts]
    })

def deserialize_content(data: str) -> Content:
    obj = json.loads(data)
    return Content(role=obj["role"], parts=[Part(text=p) for p in obj["parts"]])

def generate_reply(history):
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=history
    )
    return response.candidates[0].content.parts[0].text