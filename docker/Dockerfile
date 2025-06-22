FROM python:3.11-slim

WORKDIR /app

# Create a non-root user with a specific UID
RUN useradd -m -u 1001 appuser

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

USER 1001

EXPOSE 8080

CMD ["python", "app.py"]
