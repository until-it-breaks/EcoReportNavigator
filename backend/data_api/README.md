# Chapter Data API 🚀📚

> ⚠️ **Important:**   
> This service is **one component of a larger application ecosystem** 🌐.  
> It serves chapter-related data via REST endpoints and is intended to be **built and run exclusively within Docker** 🐳.  
> It does **not** include frontend or other system parts, and is designed to integrate into a broader architecture 🏗️.

This Node.js + TypeScript API runs entirely inside Docker using `tsx` to execute TypeScript files directly.

## ✅ Requirements 

- Docker installed on your system.

## 🏗️ Build the Docker image

```bash
docker build -t chapter-data-api .
```

## ▶️ Run the container

```bash
docker run -p 8080:8080 chapter-data-api
```

## 📡 Access the API

The service listens on port `8080` inside the container.
From your host machine, connect to:

```bash
http://localhost:8080/data
```

All API methods are `HTTP GET` requests.

## 📝 Example Requests

- Get all chapters
  
```bash
curl http://localhost:8080/data/
```

- Get a specific chapter by ID
  
```bash
curl http://localhost:8080/data/1
```

- Get chapter data keys for a chapter
  
```bash
curl http://localhost:8080/data/1/keys
```

- Get a specific data chunk by key for a chapter
  
```bash
curl http://localhost:8080/data/1/keys/someKey
```