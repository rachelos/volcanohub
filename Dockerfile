FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 复制依赖文件（如果需要）
COPY requirements.txt .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt || \
    pip install --no-cache-dir fastapi uvicorn requests

# 复制应用文件
COPY main.py .

# 暴露端口
EXPOSE 8000

# 设置环境变量（可在运行时覆盖）
ENV VOLCENGINE_AK=""
ENV VOLCENGINE_SK=""

# 启动应用
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
