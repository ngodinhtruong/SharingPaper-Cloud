from app import create_app, socketio
import os
import logging

# Cấu hình logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Đảm bảo thư mục instance tồn tại trước khi tạo app
os.makedirs('instance', exist_ok=True)

app = create_app()

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))  # Đọc từ biến môi trường
    print(f"Starting server on port {port}")
    socketio.run(app, host='0.0.0.0', port=8080, debug=False)

