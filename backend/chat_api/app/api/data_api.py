import os
import requests

BASE_URL = os.getenv("DATA_API_URL")

# Returns the all the details of a given topic belonging to a given chapter.
def get_topic_data(chapterId: int, topicKey: str):
    response = requests.get(f"{BASE_URL}/{chapterId}/topics/{topicKey}")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()

# Returns all the topics with just metadata of a given chapter.
def get_topics(chapterId: int):
    response = requests.get(f"{BASE_URL}/{chapterId}/topics")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()
