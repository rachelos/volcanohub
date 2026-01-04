# 火山引擎  API HUB

一个基于 FastAPI 的火山引擎 API 签名代理服务，用于调用火山引擎 IAM 及其他服务的 API 接口。

## 一键运行

```bash
docker run -d -p 8000:8000 \
  -e VOLCENGINE_AK="your_access_key" \
  -e VOLCENGINE_SK="your_secret_key" \
  ghcr.io/rachelos/volcanohub:latest
```
## 功能特性

- 自动计算和添加 HMAC-SHA256 签名
- 支持火山引擎 IAM 等多种服务
- 提供 HTTP 代理接口
- Docker 容器化部署
- 支持 AccessKey 和临时凭证（STS）

## 环境要求

- Python 3.11+
- Docker (可选)

## 快速开始

### 本地运行

1. 安装依赖：
```bash
pip install -r requirements.txt
```

2. 设置环境变量：
```bash
export VOLCENGINE_AK="your_access_key"
export VOLCENGINE_SK="your_secret_key"
```

Windows:
```cmd
set VOLCENGINE_AK=your_access_key
set VOLCENGINE_SK=your_secret_key
```

3. 启动服务：
```bash
python main.py
```

或使用运行脚本：
- Windows: `run.bat`
- Linux/Mac: `bash run.sh`

服务将在 `http://localhost:8000` 启动。

### Docker 部署

1. 构建镜像：
```bash
docker build -t volcano-api:latest .
```

或使用构建脚本：
- Windows: `build.bat`

2. 运行容器：
```bash
docker run -d -p 8000:8000 \
  -e VOLCENGINE_AK="your_access_key" \
  -e VOLCENGINE_SK="your_secret_key" \
  volcano-api:latest
```

## API 使用

### 基础接口

**POST /**

调用火山引擎 API 接口。

**请求参数：**

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| Action | string | "ListUsers" | API 操作名称 |
| body | dict | null | 请求体参数 |
| Version | string | "2018-01-01" | API 版本号 |
| Region | string | "cn-north-1" | 服务区域 |
| Service | string | "cv" | 服务名称 |
| Host | string | "open.volcengineapi.com" | API 主机地址 |
| isProxy | bool | true | 是否为代理模式 |

**请求示例：**

```bash
curl -X POST "http://localhost:8000/" \
  -H "Content-Type: application/json" \
  -d '{
    "Action": "ListUsers",
    "Version": "2018-01-01",
    "Service": "iam",
    "body": {"Limit": 10}
  }'
```

**响应示例：**

```json
{
  "ResponseMetadata": {
    "RequestId": "xxx",
    "Action": "ListUsers",
    "Version": "2018-01-01",
    "Service": "iam",
    "Region": "cn-north-1"
  },
  "Result": {
    "Users": []
  }
}
```

## 配置说明

### 服务参数

在 `main.py` 中可配置以下参数：

```python
Service = "cv"          # 服务名称 (cv/iam等)
Version = "2018-01-01"  # API 版本号
Region = "cn-north-1"   # 服务区域
Host = "open.volcengineapi.com"  # API 主机地址
```

### 临时凭证

如需使用临时凭证（STS），取消代码中以下注释：

```python
# SessionToken = ""
# 在 header 参数中添加 X-Security-Token 头
# header = {**header, **{"X-Security-Token": SessionToken}}
```

## 目录结构

```
.
├── main.py           # 主程序文件
├── requirements.txt  # Python 依赖
├── Dockerfile        # Docker 构建文件
├── build.bat         # Windows 镜像构建脚本
├── run.bat           # Windows 运行脚本
└── run.sh            # Linux/Mac 运行脚本
```

## 注意事项

1. 请妥善保管 AccessKey 和 SecretKey，不要泄露
2. 生产环境建议使用临时凭证（STS）
3. 签名算法遵循火山引擎 API 规范
4. 支持自定义服务、版本和区域参数

## 许可证

Apache License 2.0

Copyright (year) Beijing Volcano Engine Technology Ltd.
