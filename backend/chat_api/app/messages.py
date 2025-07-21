from typing import Optional
from pydantic import BaseModel

class IncomingMessage(BaseModel):
    chapterId: int                      # required: chapter id context
    text: Optional[str] = None          # user free-text input
    freechat: bool = False              # if True, 'text' is a freechat message
    topicKey: Optional[str] = None      # the selected topic key (if any)
    
class OutgoingMessage(BaseModel):
    reply: str                          # Outgoing reply
    chart_url: Optional[str] = None     # Optional URL to chart image