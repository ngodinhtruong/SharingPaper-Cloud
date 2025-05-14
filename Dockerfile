FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /tmp/uploads

EXPOSE 8080
ENV PORT 8080

CMD ["python", "run.py"]
