from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import uvicorn
import random
import asyncio
from datetime import datetime

# Import endpoints
from endpoints import (
    academy, ecommerce, chat, email, calendar,
    invoice, kanban, logistics, auth, users
)

# Create FastAPI app
app = FastAPI(
    title="Flutter Demo Mock API",
    description="Mock API server for Flutter demo application",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Configure CORS for Flutter web development
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Middleware for realistic delays and error simulation
@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    # Add realistic delay (100-500ms)
    delay = random.uniform(0.1, 0.5)
    await asyncio.sleep(delay)
    
    # Simulate random errors (5% chance)
    if random.random() < 0.05 and request.url.path != "/docs" and request.url.path != "/openapi.json":
        return JSONResponse(
            status_code=500,
            content={"error": "Internal server error (simulated)"}
        )
    
    response = await call_next(request)
    response.headers["X-Process-Time"] = str(delay)
    return response

# Root endpoint
@app.get("/")
async def root():
    return {
        "message": "Flutter Demo Mock API Server",
        "version": "1.0.0",
        "timestamp": datetime.now().isoformat(),
        "endpoints": {
            "docs": "/docs",
            "auth": "/api/auth",
            "academy": "/api/academy",
            "ecommerce": "/api/ecommerce",
            "email": "/api/email",
            "chat": "/api/chat",
            "calendar": "/api/calendar",
            "invoice": "/api/invoice",
            "kanban": "/api/kanban",
            "logistics": "/api/logistics",
            "users": "/api/users",
            "analytics": "/api/analytics"
        }
    }

# Health check endpoint
@app.get("/health")
async def health_check():
    return {"status": "healthy", "timestamp": datetime.now().isoformat()}

# Include routers
app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(academy.router, prefix="/api/academy", tags=["Academy"])
app.include_router(ecommerce.router, prefix="/api/ecommerce", tags=["E-commerce"])
app.include_router(email.router, prefix="/api/email", tags=["Email"])
app.include_router(chat.router, prefix="/api/chat", tags=["Chat"])
app.include_router(calendar.router, prefix="/api/calendar", tags=["Calendar"])
app.include_router(invoice.router, prefix="/api/invoice", tags=["Invoice"])
app.include_router(kanban.router, prefix="/api/kanban", tags=["Kanban"])
app.include_router(logistics.router, prefix="/api/logistics", tags=["Logistics"])
app.include_router(users.router, prefix="/api/users", tags=["Users"])

# Analytics endpoint (simple dashboard data)
@app.get("/api/analytics/dashboard")
async def get_analytics_dashboard():
    return {
        "revenue": {
            "total": 125430,
            "growth": 12.5,
            "chart": [
                {"month": "Jan", "value": 8500},
                {"month": "Feb", "value": 9200},
                {"month": "Mar", "value": 10100},
                {"month": "Apr", "value": 10800},
                {"month": "May", "value": 11500},
                {"month": "Jun", "value": 12430}
            ]
        },
        "users": {
            "total": 8257,
            "growth": 8.3,
            "active": 6842,
            "new": 423
        },
        "orders": {
            "total": 3247,
            "pending": 142,
            "completed": 2983,
            "cancelled": 122
        },
        "performance": {
            "cpu": 67,
            "memory": 82,
            "disk": 45,
            "network": 23
        }
    }

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )