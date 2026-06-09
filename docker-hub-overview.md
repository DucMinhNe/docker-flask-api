# minhle202/flask-api

A production-grade **Python 3.12 + Flask 3 + Gunicorn** REST API starter image.
Part of the `minhle202` family of Docker Hub starter images by **Lê Đức Minh**.
Spin up a clean, secure JSON API in seconds and use it as a template for your own
services.

## Tags

- `latest` — current stable build
- Multi-arch: **linux/amd64** and **linux/arm64**

## Quick start

```bash
docker run --rm -p 8000:8000 minhle202/flask-api
```

Listens on port **8000** by default; override with `-e PORT=9000`.

```bash
curl http://localhost:8000/
curl http://localhost:8000/health
curl "http://localhost:8000/api/hello?name=Minh"
```

## Endpoints

| Method | Path               | Description                              |
| ------ | ------------------ | ---------------------------------------- |
| GET    | `/`                | Name, version, and list of endpoints.    |
| GET    | `/health`          | `{ "status": "ok", "uptime": <seconds> }`. |
| GET    | `/api/hello?name=` | Greeting; `name` defaults to `world`.    |

## Features

- **Gunicorn production WSGI server** — 2 workers, 4 threads each, with graceful
  `SIGTERM` worker shutdown for clean rolling restarts.
- **Python 3.12-slim** base for a small, current runtime.
- **Multi-stage venv build** keeps the final image lean and free of build tools.
- **Non-root** execution as `appuser` (UID 10001).
- Built-in **HEALTHCHECK** probing `/health`.

## Source

https://github.com/DucMinhNe/docker-flask-api

Licensed under MIT © 2026 Lê Đức Minh.
