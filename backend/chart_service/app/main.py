from fastapi import FastAPI, HTTPException
from fastapi.responses import StreamingResponse
from io import BytesIO
import vl_convert as vlc

from app.models import ChartRequest
from app.charts import generate_chart

app = FastAPI()

@app.post("/chart", summary="Render a chart and return it as PNG")
async def create_chart(req: ChartRequest):
    try:
        chart = generate_chart(req)
        png_data = vlc.vegalite_to_png(chart.to_dict())
        return StreamingResponse(BytesIO(png_data), media_type="image/png")
    except ValueError as ve:
        # Validation errors or chart generation issues
        raise HTTPException(status_code=400, detail=str(ve))
    except Exception as e:
        # Unexpected errors - better not return broken PNG
        raise HTTPException(status_code=500, detail="Internal Server Error")

@app.get("/schema/chart_request", summary="Get JSON schema for ChartRequest", response_model=dict)
def get_chart_request_schema():
    return ChartRequest.model_json_schema()