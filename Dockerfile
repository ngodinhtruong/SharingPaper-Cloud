FROM python:3.9-slim

WORKDIR /app

# Cài đặt các dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# Copy toàn bộ code vào container
COPY . .
# COPY firebase-auth.json /app/firebase-auth/firebase-auth.json

# Tạo thư mục uploads
#docker
# RUN mkdir -p app/static/uploads

#cloud
RUN mkdir -p /tmp/uploads

ENV FLASK_APP=run.py

# Expose portL 5000 local - cloud 8080
# EXPOSE 5000

EXPOSE 8080

# Setup gunicorn config
RUN echo "worker_class = 'eventlet'" > gunicorn.conf.py
RUN echo "workers = 1" >> gunicorn.conf.py
RUN echo "bind = '0.0.0.0:8080'" >> gunicorn.conf.py
RUN echo "timeout = 120" >> gunicorn.conf.py
RUN echo "loglevel = 'info'" >> gunicorn.conf.py

# Chạy ứng dụng với gunicorn
CMD exec gunicorn --config gunicorn.conf.py --preload 'app:create_app()'

