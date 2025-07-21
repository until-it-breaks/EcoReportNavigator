import json
import logging
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from pydantic import ValidationError

from .messages import IncomingMessage
from .chat_logic import generate_free_chat_reply, generate_strict_topic_reply

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')
logger = logging.getLogger(__name__)

app = FastAPI()

@app.websocket("/ws/chat/{session_id}")
async def websocket_chat(websocket: WebSocket, session_id: str):
    await websocket.accept()
    logger.info(f"Session started: {session_id}")
    try:
        while True:
            raw = await websocket.receive_text()
            try:
                incoming_message = IncomingMessage.model_validate_json(raw)
            except ValidationError as e:
                await websocket.send_text(json.dumps({"error": "Invalid message format", "details": e.errors()}))
                continue
            
            if incoming_message.freechat == True:
                reply = generate_free_chat_reply(incoming_message)
            else:
                reply = generate_strict_topic_reply(incoming_message)

            await websocket.send_text(reply.model_dump_json())
    except WebSocketDisconnect:
        logger.info(f"Disconnecting session: {session_id}")