import requests

BASE_URL = "http://data_api:8080/data"

def get_topic_data(chapterId: int, topicKey: str):
    response = requests.get(f"{BASE_URL}/{chapterId}/topics/{topicKey}")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()

def get_topics(chapterId: int):
    response = requests.get(f"{BASE_URL}/{chapterId}/topics")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()
