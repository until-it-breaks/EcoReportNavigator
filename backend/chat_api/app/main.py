import json
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from jsonschema import ValidationError

from .messages import IncomingMessage
from .chat_logic import generate_free_chat_reply, generate_strict_topic_reply
from google.genai.types import Content, Part

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.websocket("/ws/chat/{session_id}")
async def websocket_chat(websocket: WebSocket, session_id: str):
    await websocket.accept()
    print(f"Client connected: {session_id}")
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
                
            #user_msg = Content(role="user", parts=[Part(text=user_text)])
            
            #store_message(session_id, user_msg)

            #history = load_history(session_id)
            
            #model_msg = Content(role="model", parts=[Part(text=reply)])
            #store_message(session_id, model_msg)

            await websocket.send_text(reply.model_dump_json())
    except WebSocketDisconnect:
        print(f"Disconnecting session: {session_id}")