import redis
from .chat_logic import serialize_content, deserialize_content
from google.genai.types import Content

SESSION_TTL_SECONDS = 1800 # 30 minutes

redis_client = redis.Redis(host="redis", port=6379, decode_responses=True)

def store_message(session_id: str, content: Content):
    redis_client.rpush(session_id, serialize_content(content))
    redis_client.expire(session_id, SESSION_TTL_SECONDS)

def load_history(session_id: str) -> list[Content]:
    data = redis_client.lrange(session_id, 0, -1)
    return [deserialize_content(msg) for msg in data]