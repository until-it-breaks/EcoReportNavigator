import requests

BASE_URL = "http://data_api:8080/data"

def getTopicData(chapterId: int, topicKey: str):
    response = requests.get(f"{BASE_URL}/{chapterId}/topics/{topicKey}")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()

def getTopics(chapterId: int):
    response = requests.get(f"{BASE_URL}/{chapterId}/topics")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()
