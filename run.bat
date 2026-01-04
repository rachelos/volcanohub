@echo off
REM Docker 容器运行脚本 (Windows)

set IMAGE_NAME=volcano-api
set IMAGE_TAG=latest
set CONTAINER_NAME=volcano-api-container
set HOST_PORT=8000

REM 检查容器是否已运行
for /f %%i in ('docker ps -q -f name=%CONTAINER_NAME%') do set CONTAINER_ID=%%i
if defined CONTAINER_ID (
    echo 容器 %CONTAINER_NAME% 已在运行，先停止并删除...
    docker stop %CONTAINER_NAME%
    docker rm %CONTAINER_NAME%
)

REM 检查容器是否存在但未运行
for /f %%i in ('docker ps -aq -f name=%CONTAINER_NAME%') do set CONTAINER_ID=%%i
if defined CONTAINER_ID (
    echo 删除已停止的容器 %CONTAINER_NAME%...
    docker rm %CONTAINER_NAME%
)

REM 启动容器
echo 启动容器 %CONTAINER_NAME%...
docker run -d --name %CONTAINER_NAME% -p %HOST_PORT%:8000 -e VOLCENGINE_AK=%VOLCENGINE_AK% -e VOLCENGINE_SK=%VOLCENGINE_SK% %IMAGE_NAME%:%IMAGE_TAG%

if %errorlevel% equ 0 (
    echo 容器启动成功！
    echo 访问地址: http://localhost:%HOST_PORT%
    echo 查看日志: docker logs -f %CONTAINER_NAME%
    echo 停止容器: docker stop %CONTAINER_NAME%
) else (
    echo 容器启动失败！
    exit /b 1
)
