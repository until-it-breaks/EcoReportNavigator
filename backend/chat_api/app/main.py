from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from .redis_store import store_message, load_history
from .chat_logic import generate_reply
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
            msg = await websocket.receive_text()
            user_msg = Content(role="user", parts=[Part(text=msg)])
            store_message(session_id, user_msg)

            history = load_history(session_id)
            reply = generate_reply(history)
            model_msg = Content(role="model", parts=[Part(text=reply)])
            store_message(session_id, model_msg)

            await websocket.send_text(reply)
    except WebSocketDisconnect:
        print(f"Disconnected: {session_id}")