# syntax=docker/dockerfile:1
FROM python:3.12-slim AS builder
WORKDIR /app
ENV PIP_NO_CACHE_DIR=1
COPY requirements.txt .
RUN python -m venv /opt/venv && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt
FROM python:3.12-slim AS runtime
ENV PATH="/opt/venv/bin:$PATH" PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 PORT=8000
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv
COPY app ./app
RUN useradd -r -u 10001 appuser
USER appuser
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request,os,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:'+os.environ.get('PORT','8000')+'/health').status==200 else 1)"
CMD ["sh","-c","gunicorn --bind 0.0.0.0:${PORT:-8000} --workers 2 --threads 4 --access-logfile - app.main:app"]
