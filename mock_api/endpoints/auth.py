from fastapi import APIRouter, HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from typing import Optional
from datetime import datetime, timedelta
import random

from models import (
    LoginRequest, RegisterRequest, TokenResponse, UserResponse, BaseResponse
)
from utils import (
    verify_password, get_password_hash, create_access_token,
    create_refresh_token, verify_token
)

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/auth/login")

# Mock user database
mock_users = [
    {
        "id": 1,
        "email": "admin@example.com",
        "username": "admin",
        "password": get_password_hash("admin123"),
        "full_name": "Admin User",
        "avatar": "/images/avatars/1.png",
        "role": "admin",
        "created_at": datetime.now() - timedelta(days=365)
    },
    {
        "id": 2,
        "email": "user@example.com",
        "username": "user",
        "password": get_password_hash("user123"),
        "full_name": "Regular User",
        "avatar": "/images/avatars/2.png",
        "role": "user",
        "created_at": datetime.now() - timedelta(days=180)
    }
]

async def get_current_user(token: str = Depends(oauth2_scheme)) -> Optional[dict]:
    """Get current user from token"""
    payload = verify_token(token)
    if not payload:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    user_id = payload.get("sub")
    user = next((u for u in mock_users if u["id"] == int(user_id)), None)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not found",
        )
    
    return user

@router.post("/login", response_model=TokenResponse)
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    """Login with email/username and password"""
    # Find user by email or username
    user = next(
        (u for u in mock_users if u["email"] == form_data.username or u["username"] == form_data.username),
        None
    )
    
    if not user or not verify_password(form_data.password, user["password"]):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    # Create tokens
    access_token_expires = timedelta(minutes=30)
    access_token = create_access_token(
        data={"sub": str(user["id"])}, expires_delta=access_token_expires
    )
    refresh_token = create_refresh_token(data={"sub": str(user["id"])})
    
    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer",
        "expires_in": 1800  # 30 minutes
    }

@router.post("/register", response_model=UserResponse)
async def register(request: RegisterRequest):
    """Register a new user"""
    # Check if user already exists
    existing_user = next(
        (u for u in mock_users if u["email"] == request.email or u["username"] == request.username),
        None
    )
    
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User with this email or username already exists"
        )
    
    # Create new user
    new_user = {
        "id": len(mock_users) + 1,
        "email": request.email,
        "username": request.username,
        "password": get_password_hash(request.password),
        "full_name": request.full_name or request.username,
        "avatar": f"/images/avatars/{random.randint(1, 8)}.png",
        "role": "user",
        "created_at": datetime.now()
    }
    
    mock_users.append(new_user)
    
    # Return user without password
    return UserResponse(**{k: v for k, v in new_user.items() if k != "password"})

@router.post("/logout", response_model=BaseResponse)
async def logout(current_user: dict = Depends(get_current_user)):
    """Logout current user"""
    # In a real application, you would invalidate the token here
    return BaseResponse(success=True, message="Successfully logged out")

@router.post("/refresh", response_model=TokenResponse)
async def refresh_token(refresh_token: str):
    """Refresh access token using refresh token"""
    payload = verify_token(refresh_token, token_type="refresh")
    if not payload:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid refresh token"
        )
    
    user_id = payload.get("sub")
    user = next((u for u in mock_users if u["id"] == int(user_id)), None)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not found"
        )
    
    # Create new tokens
    access_token_expires = timedelta(minutes=30)
    new_access_token = create_access_token(
        data={"sub": str(user["id"])}, expires_delta=access_token_expires
    )
    new_refresh_token = create_refresh_token(data={"sub": str(user["id"])})
    
    return {
        "access_token": new_access_token,
        "refresh_token": new_refresh_token,
        "token_type": "bearer",
        "expires_in": 1800
    }

@router.get("/me", response_model=UserResponse)
async def get_current_user_info(current_user: dict = Depends(get_current_user)):
    """Get current user information"""
    return UserResponse(**{k: v for k, v in current_user.items() if k != "password"})

@router.put("/me", response_model=UserResponse)
async def update_current_user(
    updates: dict,
    current_user: dict = Depends(get_current_user)
):
    """Update current user information"""
    # Update user in mock database
    user_index = next((i for i, u in enumerate(mock_users) if u["id"] == current_user["id"]), None)
    if user_index is not None:
        # Only allow updating certain fields
        allowed_fields = ["full_name", "avatar"]
        for field in allowed_fields:
            if field in updates:
                mock_users[user_index][field] = updates[field]
        
        updated_user = mock_users[user_index]
        return UserResponse(**{k: v for k, v in updated_user.items() if k != "password"})
    
    raise HTTPException(status_code=404, detail="User not found")

@router.post("/change-password", response_model=BaseResponse)
async def change_password(
    old_password: str,
    new_password: str,
    current_user: dict = Depends(get_current_user)
):
    """Change user password"""
    # Verify old password
    if not verify_password(old_password, current_user["password"]):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Incorrect old password"
        )
    
    # Update password in mock database
    user_index = next((i for i, u in enumerate(mock_users) if u["id"] == current_user["id"]), None)
    if user_index is not None:
        mock_users[user_index]["password"] = get_password_hash(new_password)
        return BaseResponse(success=True, message="Password changed successfully")
    
    raise HTTPException(status_code=404, detail="User not found")