@echo off
REM Docker 镜像构建脚本 (Windows)

set IMAGE_NAME=volcano-api
set IMAGE_TAG=latest

echo Starting Docker image build...
docker build -t %IMAGE_NAME%:%IMAGE_TAG% .

if %errorlevel% equ 0 (
    echo Build successful!
    echo Image name: %IMAGE_NAME%:%IMAGE_TAG%
) else (
    echo Build failed!
    exit /b 1
)
