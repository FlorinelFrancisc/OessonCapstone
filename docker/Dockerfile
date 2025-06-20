FROM python:3.11-slim

WORKDIR /app

# Create a non-root user
RUN useradd -m appuser

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

USER appuser

EXPOSE 8080

CMD ["python", "app.py"]
