# docker-flask-api

A production-grade **Python 3.12 + Flask 3 + Gunicorn** REST API starter image,
part of the `minhle202` family of Docker Hub starter images by **Lê Đức Minh**.

It ships a minimal, well-structured Flask application served by **Gunicorn**, the
production-grade WSGI server, behind a small JSON API. Use it as a template for
new services or as a reference for a slim, secure container setup.

## Pull

```bash
docker pull minhle202/flask-api
```

## Run

```bash
docker run --rm -p 8000:8000 minhle202/flask-api
```

The server listens on port **8000** by default. Override it with the `PORT`
environment variable:

```bash
docker run --rm -e PORT=9000 -p 9000:9000 minhle202/flask-api
```

## Try it

```bash
curl http://localhost:8000/
curl http://localhost:8000/health
curl "http://localhost:8000/api/hello?name=Minh"
```

Example responses:

```json
{ "name": "flask-api", "version": "1.0.0", "endpoints": ["/", "/health", "/api/hello"] }
{ "status": "ok", "uptime": 12.34 }
{ "message": "Hello, Minh!" }
```

## Endpoints

| Method | Path               | Description                                              |
| ------ | ------------------ | -------------------------------------------------------- |
| GET    | `/`                | Service metadata: name, version, and list of endpoints. |
| GET    | `/health`          | Health check: `{ "status": "ok", "uptime": <seconds> }`. |
| GET    | `/api/hello?name=` | Greeting; `name` defaults to `world`.                   |

## What's inside

- **Python 3.12-slim** base image — small footprint, current runtime.
- **Flask 3 + Gunicorn** — 2 workers, 4 threads per worker. Gunicorn is a
  battle-tested production WSGI server and handles `SIGTERM` with graceful
  worker shutdown, so in-flight requests drain cleanly on container stop.
- **Multi-stage build** — dependencies are installed into a virtualenv in a
  builder stage and copied into a clean runtime image, keeping the final layer
  lean and free of build tooling.
- **Non-root user** — runs as the unprivileged `appuser` (UID 10001).
- **HEALTHCHECK** — built-in container health probe against `/health`.

## Tags

- `latest` — the current stable build.
- Multi-arch: published for **linux/amd64** and **linux/arm64**.

## License

[MIT](LICENSE) © 2026 Lê Đức Minh
