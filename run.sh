#!/bin/bash
# Docker 容器运行脚本

IMAGE_NAME="volcano-api"
IMAGE_TAG="latest"
CONTAINER_NAME="volcano-api-container"
HOST_PORT=8000

# 检查容器是否已运行
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo "容器 ${CONTAINER_NAME} 已在运行，先停止并删除..."
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi

# 检查容器是否存在但未运行
if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
    echo "删除已停止的容器 ${CONTAINER_NAME}..."
    docker rm ${CONTAINER_NAME}
fi

# 启动容器
echo "启动容器 ${CONTAINER_NAME}..."
docker run -d \
  --name ${CONTAINER_NAME} \
  -p ${HOST_PORT}:8000 \
  -e VOLCENGINE_AK=${VOLCENGINE_AK} \
  -e VOLCENGINE_SK=${VOLCENGINE_SK} \
  ${IMAGE_NAME}:${IMAGE_TAG}

if [ $? -eq 0 ]; then
    echo "容器启动成功！"
    echo "访问地址: http://localhost:${HOST_PORT}"
    echo "查看日志: docker logs -f ${CONTAINER_NAME}"
    echo "停止容器: docker stop ${CONTAINER_NAME}"
else
    echo "容器启动失败！"
    exit 1
fi
