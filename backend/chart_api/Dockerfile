FROM python:3.13-slim

WORKDIR /usr/src/app

COPY requirements.txt app/ ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]