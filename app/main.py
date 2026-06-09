"""Flask REST API starter.

Exposes a WSGI ``app`` callable for Gunicorn (``app.main:app``).
"""

import time

from flask import Flask, jsonify, request

# Captured once at import time; /health reports seconds elapsed since this.
START_TIME = time.monotonic()

NAME = "docker-flask-api"
VERSION = "1.0.0"

app = Flask(__name__)


@app.get("/")
def index():
    """Service metadata and the list of available endpoints."""
    return jsonify(
        {
            "name": NAME,
            "version": VERSION,
            "endpoints": ["/", "/health", "/api/hello"],
        }
    )


@app.get("/health")
def health():
    """Liveness probe with process uptime in seconds."""
    return jsonify(
        {
            "status": "ok",
            "uptime": time.monotonic() - START_TIME,
        }
    )


@app.get("/api/hello")
def hello():
    """Greet the caller; ``name`` defaults to ``world``."""
    name = request.args.get("name", "world")
    return jsonify({"message": f"Hello, {name}!"})


if __name__ == "__main__":
    import os

    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", "8000")))
