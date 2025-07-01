"""
Configuration settings for the Mock API Server
"""

import os
from typing import List

# Server settings
HOST = os.getenv("API_HOST", "0.0.0.0")
PORT = int(os.getenv("API_PORT", 8000))
RELOAD = os.getenv("API_RELOAD", "true").lower() == "true"

# CORS settings
CORS_ORIGINS: List[str] = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:8080",
    "http://localhost:8081",
    "http://localhost:5000",
    "http://localhost:5173",
    "*"  # Allow all origins in development
]

# Authentication settings
SECRET_KEY = os.getenv("SECRET_KEY", "your-secret-key-here-change-in-production")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_DAYS = 7

# Mock data settings
ENABLE_RANDOM_ERRORS = os.getenv("ENABLE_RANDOM_ERRORS", "true").lower() == "true"
ERROR_RATE = float(os.getenv("ERROR_RATE", "0.05"))  # 5% error rate
MIN_DELAY_MS = int(os.getenv("MIN_DELAY_MS", "100"))
MAX_DELAY_MS = int(os.getenv("MAX_DELAY_MS", "500"))

# File upload settings
MAX_UPLOAD_SIZE = 10 * 1024 * 1024  # 10MB
ALLOWED_IMAGE_TYPES = ["image/jpeg", "image/png", "image/gif", "image/webp"]
ALLOWED_DOCUMENT_TYPES = ["application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]

# Pagination defaults
DEFAULT_PAGE_SIZE = 10
MAX_PAGE_SIZE = 100

# WebSocket settings
WS_HEARTBEAT_INTERVAL = 30  # seconds
WS_CONNECTION_TIMEOUT = 300  # seconds

# Mock data generation settings
MOCK_USERS_COUNT = 50
MOCK_COURSES_COUNT = 20
MOCK_PRODUCTS_COUNT = 50
MOCK_EMAILS_COUNT = 100
MOCK_INVOICES_COUNT = 30
MOCK_TASKS_COUNT = 40
MOCK_DELIVERIES_COUNT = 100

# Feature flags
FEATURES = {
    "websocket_chat": True,
    "file_uploads": True,
    "email_attachments": True,
    "two_factor_auth": True,
    "export_data": True,
    "analytics": True
}

# API versioning
API_VERSION = "1.0.0"
API_TITLE = "Flutter Demo Mock API"
API_DESCRIPTION = "Mock API server for Flutter demo application"

# Database settings (for future use)
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./mock_api.db")

# Redis settings (for future use)
REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379")

# Logging settings
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"

# Email settings (for future use)
SMTP_HOST = os.getenv("SMTP_HOST", "localhost")
SMTP_PORT = int(os.getenv("SMTP_PORT", "1025"))
SMTP_USER = os.getenv("SMTP_USER", "")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "")
SMTP_FROM = os.getenv("SMTP_FROM", "noreply@example.com")

# Storage settings
UPLOAD_DIR = os.getenv("UPLOAD_DIR", "./uploads")
STATIC_DIR = os.getenv("STATIC_DIR", "./static")

# Create directories if they don't exist
os.makedirs(UPLOAD_DIR, exist_ok=True)
os.makedirs(STATIC_DIR, exist_ok=True)