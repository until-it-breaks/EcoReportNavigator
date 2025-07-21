from io import BytesIO
import os
import uuid
import requests

CHART_API_URL = os.getenv("CHART_API_URL")

# Retrieves the general schema of a chart definition payload.
def get_chart_schema():
    response = requests.get(f"{CHART_API_URL}/schema/chart_request")
    if response.status_code == 200:
        return response.json()
    else:
        response.raise_for_status()

# Generates a chart with a remote backend service given a proper payload.
def generate_chart(body: dict) -> BytesIO:
    headers = {"Content-Type": "application/json"}
    response = requests.post(f"{CHART_API_URL}/chart", json=body, headers=headers)
    if response.status_code == 200:
        return BytesIO(response.content)
    else:
        response.raise_for_status()

# Saves the image and returns a relative url.
def save_chart_image(image_bytes_io: BytesIO) -> str:
    filename = f"{uuid.uuid4()}.png"
    charts_dir = "/app/charts"
    os.makedirs(charts_dir, exist_ok=True)
    path = os.path.join(charts_dir, filename)
    
    with open(path, "wb") as f:
        f.write(image_bytes_io.getbuffer())
        
    return f"/charts/{filename}"
