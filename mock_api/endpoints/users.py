from fastapi import APIRouter, Query, HTTPException, Depends, UploadFile, File
from typing import Optional, List
from datetime import datetime, timedelta
import random

from models import BaseResponse, PaginatedResponse
from utils import paginate_data, search_data, sort_data, get_password_hash
from .auth import get_current_user, mock_users

router = APIRouter()

# Mock additional user data
mock_user_profiles = {}
mock_user_settings = {}
mock_user_permissions = {}

# Initialize mock data
def init_mock_data():
    roles = ["admin", "user", "editor", "viewer", "moderator"]
    departments = ["Engineering", "Sales", "Marketing", "HR", "Finance", "Operations"]
    
    for user in mock_users:
        # Profile data
        mock_user_profiles[user["id"]] = {
            "user_id": user["id"],
            "bio": f"Professional working in technology. Passionate about innovation and collaboration.",
            "phone": f"+1-555-{random.randint(1000, 9999)}",
            "department": random.choice(departments),
            "position": random.choice(["Manager", "Senior Developer", "Developer", "Analyst", "Coordinator"]),
            "location": random.choice(["New York", "San Francisco", "London", "Tokyo", "Sydney"]),
            "timezone": random.choice(["America/New_York", "America/Los_Angeles", "Europe/London", "Asia/Tokyo"]),
            "language": random.choice(["en", "es", "fr", "de", "ja"]),
            "joined_date": (datetime.now() - timedelta(days=random.randint(30, 730))).isoformat(),
            "last_login": (datetime.now() - timedelta(hours=random.randint(0, 72))).isoformat(),
            "is_online": random.random() > 0.7,
            "social_links": {
                "twitter": f"@user{user['id']}",
                "linkedin": f"linkedin.com/in/user{user['id']}",
                "github": f"github.com/user{user['id']}"
            }
        }
        
        # Settings
        mock_user_settings[user["id"]] = {
            "user_id": user["id"],
            "notifications": {
                "email": True,
                "push": random.random() > 0.3,
                "sms": random.random() > 0.7,
                "desktop": True
            },
            "privacy": {
                "profile_visibility": random.choice(["public", "private", "friends"]),
                "show_email": random.random() > 0.5,
                "show_phone": False,
                "allow_messages": True
            },
            "preferences": {
                "theme": random.choice(["light", "dark", "auto"]),
                "language": "en",
                "date_format": random.choice(["MM/DD/YYYY", "DD/MM/YYYY", "YYYY-MM-DD"]),
                "time_format": random.choice(["12h", "24h"]),
                "first_day_of_week": random.choice(["sunday", "monday"])
            },
            "security": {
                "two_factor_enabled": random.random() > 0.6,
                "login_alerts": True,
                "session_timeout": random.choice([15, 30, 60, 120])  # minutes
            }
        }
        
        # Permissions
        mock_user_permissions[user["id"]] = {
            "user_id": user["id"],
            "role": user["role"],
            "permissions": generate_permissions_for_role(user["role"])
        }

def generate_permissions_for_role(role: str) -> dict:
    """Generate permissions based on role"""
    base_permissions = {
        "users": {"read": True, "write": False, "delete": False},
        "courses": {"read": True, "write": False, "delete": False},
        "products": {"read": True, "write": False, "delete": False},
        "orders": {"read": True, "write": False, "delete": False},
        "invoices": {"read": True, "write": False, "delete": False},
        "reports": {"read": True, "write": False, "delete": False}
    }
    
    if role == "admin":
        # Admin has all permissions
        for module in base_permissions:
            base_permissions[module] = {"read": True, "write": True, "delete": True}
    elif role == "editor":
        # Editor can read and write
        for module in base_permissions:
            base_permissions[module]["write"] = True
    elif role == "moderator":
        # Moderator has specific permissions
        base_permissions["users"]["write"] = True
        base_permissions["courses"]["write"] = True
        base_permissions["products"]["write"] = True
    
    return base_permissions

init_mock_data()

@router.get("/profile", response_model=dict)
async def get_profile(current_user: dict = Depends(get_current_user)):
    """Get current user's profile"""
    profile = mock_user_profiles.get(current_user["id"], {})
    
    return {
        **{k: v for k, v in current_user.items() if k != "password"},
        **profile
    }

@router.put("/profile", response_model=dict)
async def update_profile(
    bio: Optional[str] = None,
    phone: Optional[str] = None,
    department: Optional[str] = None,
    position: Optional[str] = None,
    location: Optional[str] = None,
    timezone: Optional[str] = None,
    language: Optional[str] = None,
    social_links: Optional[dict] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update current user's profile"""
    if current_user["id"] not in mock_user_profiles:
        mock_user_profiles[current_user["id"]] = {"user_id": current_user["id"]}
    
    profile = mock_user_profiles[current_user["id"]]
    
    # Update fields
    if bio is not None:
        profile["bio"] = bio
    if phone is not None:
        profile["phone"] = phone
    if department is not None:
        profile["department"] = department
    if position is not None:
        profile["position"] = position
    if location is not None:
        profile["location"] = location
    if timezone is not None:
        profile["timezone"] = timezone
    if language is not None:
        profile["language"] = language
    if social_links is not None:
        profile["social_links"] = social_links
    
    return {
        **{k: v for k, v in current_user.items() if k != "password"},
        **profile
    }

@router.post("/profile/avatar", response_model=BaseResponse)
async def upload_avatar(
    file: UploadFile = File(...),
    current_user: dict = Depends(get_current_user)
):
    """Upload user avatar"""
    # Validate file type
    allowed_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    if file.content_type not in allowed_types:
        raise HTTPException(status_code=400, detail="Invalid file type")
    
    # In a real app, you would save the file and update the user's avatar URL
    # For mock, we'll just update the avatar path
    user_index = next((i for i, u in enumerate(mock_users) if u["id"] == current_user["id"]), None)
    if user_index is not None:
        mock_users[user_index]["avatar"] = f"/images/avatars/custom_{current_user['id']}.png"
    
    return BaseResponse(success=True, message="Avatar uploaded successfully")

@router.get("/settings", response_model=dict)
async def get_settings(current_user: dict = Depends(get_current_user)):
    """Get user settings"""
    settings = mock_user_settings.get(current_user["id"], {
        "user_id": current_user["id"],
        "notifications": {"email": True, "push": True, "sms": False, "desktop": True},
        "privacy": {"profile_visibility": "public", "show_email": True, "show_phone": False, "allow_messages": True},
        "preferences": {"theme": "light", "language": "en", "date_format": "MM/DD/YYYY", "time_format": "12h", "first_day_of_week": "sunday"},
        "security": {"two_factor_enabled": False, "login_alerts": True, "session_timeout": 30}
    })
    
    return settings

@router.put("/settings", response_model=dict)
async def update_settings(
    notifications: Optional[dict] = None,
    privacy: Optional[dict] = None,
    preferences: Optional[dict] = None,
    security: Optional[dict] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update user settings"""
    if current_user["id"] not in mock_user_settings:
        mock_user_settings[current_user["id"]] = {
            "user_id": current_user["id"],
            "notifications": {},
            "privacy": {},
            "preferences": {},
            "security": {}
        }
    
    settings = mock_user_settings[current_user["id"]]
    
    # Update sections
    if notifications:
        settings["notifications"].update(notifications)
    if privacy:
        settings["privacy"].update(privacy)
    if preferences:
        settings["preferences"].update(preferences)
    if security:
        settings["security"].update(security)
    
    return settings

@router.get("/permissions", response_model=dict)
async def get_permissions(current_user: dict = Depends(get_current_user)):
    """Get user permissions"""
    permissions = mock_user_permissions.get(current_user["id"], {
        "user_id": current_user["id"],
        "role": current_user["role"],
        "permissions": generate_permissions_for_role(current_user["role"])
    })
    
    return permissions

@router.get("/list", response_model=PaginatedResponse)
async def get_users(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    role: Optional[str] = None,
    department: Optional[str] = None,
    is_online: Optional[bool] = None,
    search: Optional[str] = None,
    sort_by: Optional[str] = Query("created_at", regex="^(username|email|created_at|last_login)$"),
    order: Optional[str] = Query("desc", regex="^(asc|desc)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get list of users (admin only)"""
    if current_user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Build user list with profiles
    users_list = []
    for user in mock_users:
        profile = mock_user_profiles.get(user["id"], {})
        user_data = {
            **{k: v for k, v in user.items() if k != "password"},
            **profile
        }
        users_list.append(user_data)
    
    # Apply filters
    if role:
        users_list = [u for u in users_list if u["role"] == role]
    if department:
        users_list = [u for u in users_list if u.get("department") == department]
    if is_online is not None:
        users_list = [u for u in users_list if u.get("is_online") == is_online]
    
    # Apply search
    if search:
        users_list = search_data(users_list, search, ["username", "email", "full_name"])
    
    # Apply sorting
    if sort_by:
        users_list = sort_data(users_list, sort_by, order)
    
    # Apply pagination
    result = paginate_data(users_list, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/{user_id}", response_model=dict)
async def get_user(
    user_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific user's profile"""
    user = next((u for u in mock_users if u["id"] == user_id), None)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    profile = mock_user_profiles.get(user_id, {})
    settings = mock_user_settings.get(user_id, {})
    
    # Check privacy settings
    if user_id != current_user["id"] and settings.get("privacy", {}).get("profile_visibility") == "private":
        # Return limited info for private profiles
        return {
            "id": user["id"],
            "username": user["username"],
            "avatar": user["avatar"],
            "is_private": True
        }
    
    return {
        **{k: v for k, v in user.items() if k != "password"},
        **profile
    }

@router.put("/{user_id}/role", response_model=BaseResponse)
async def update_user_role(
    user_id: int,
    role: str,
    current_user: dict = Depends(get_current_user)
):
    """Update user role (admin only)"""
    if current_user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Access denied")
    
    user = next((u for u in mock_users if u["id"] == user_id), None)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    # Update role
    user_index = next((i for i, u in enumerate(mock_users) if u["id"] == user_id), None)
    if user_index is not None:
        mock_users[user_index]["role"] = role
        
        # Update permissions
        mock_user_permissions[user_id] = {
            "user_id": user_id,
            "role": role,
            "permissions": generate_permissions_for_role(role)
        }
        
        return BaseResponse(success=True, message="Role updated successfully")
    
    raise HTTPException(status_code=500, detail="Failed to update role")

@router.delete("/{user_id}", response_model=BaseResponse)
async def delete_user(
    user_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Delete a user (admin only)"""
    if current_user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Access denied")
    
    if user_id == current_user["id"]:
        raise HTTPException(status_code=400, detail="Cannot delete your own account")
    
    user = next((u for u in mock_users if u["id"] == user_id), None)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    # Remove user
    mock_users[:] = [u for u in mock_users if u["id"] != user_id]
    
    # Remove related data
    if user_id in mock_user_profiles:
        del mock_user_profiles[user_id]
    if user_id in mock_user_settings:
        del mock_user_settings[user_id]
    if user_id in mock_user_permissions:
        del mock_user_permissions[user_id]
    
    return BaseResponse(success=True, message="User deleted successfully")

@router.get("/activity/recent")
async def get_recent_activity(
    limit: int = Query(20, ge=1, le=100),
    current_user: dict = Depends(get_current_user)
):
    """Get recent user activity"""
    # Generate mock activity
    activities = []
    activity_types = [
        "logged_in", "updated_profile", "changed_settings",
        "viewed_course", "completed_lesson", "made_purchase",
        "sent_message", "created_task", "uploaded_file"
    ]
    
    for i in range(limit):
        activities.append({
            "id": i + 1,
            "type": random.choice(activity_types),
            "description": f"User {random.choice(['performed', 'completed', 'initiated'])} an action",
            "timestamp": (datetime.now() - timedelta(hours=random.randint(0, 168))).isoformat(),
            "ip_address": f"192.168.{random.randint(0, 255)}.{random.randint(1, 255)}",
            "user_agent": random.choice([
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
                "Mozilla/5.0 (X11; Linux x86_64)"
            ])
        })
    
    # Sort by timestamp
    activities.sort(key=lambda x: x["timestamp"], reverse=True)
    
    return {
        "activities": activities,
        "count": len(activities)
    }

@router.get("/stats")
async def get_user_stats(current_user: dict = Depends(get_current_user)):
    """Get user statistics"""
    # Generate mock stats
    return {
        "profile_completion": random.randint(60, 100),
        "total_logins": random.randint(50, 500),
        "last_login": (datetime.now() - timedelta(hours=random.randint(0, 48))).isoformat(),
        "account_age_days": random.randint(30, 730),
        "courses_enrolled": random.randint(0, 20),
        "courses_completed": random.randint(0, 10),
        "total_purchases": random.randint(0, 50),
        "total_spent": round(random.uniform(0, 5000), 2),
        "messages_sent": random.randint(10, 1000),
        "tasks_completed": random.randint(5, 200),
        "storage_used_mb": random.randint(10, 500),
        "api_calls_today": random.randint(0, 1000)
    }

@router.post("/export-data", response_model=dict)
async def export_user_data(
    format: str = Query("json", regex="^(json|csv)$"),
    current_user: dict = Depends(get_current_user)
):
    """Export user data (GDPR compliance)"""
    # Collect all user data
    user_data = {
        "profile": {k: v for k, v in current_user.items() if k != "password"},
        "extended_profile": mock_user_profiles.get(current_user["id"], {}),
        "settings": mock_user_settings.get(current_user["id"], {}),
        "permissions": mock_user_permissions.get(current_user["id"], {})
    }
    
    # In a real app, this would generate a file and return a download link
    return {
        "export_id": f"export_{current_user['id']}_{datetime.now().strftime('%Y%m%d%H%M%S')}",
        "format": format,
        "status": "ready",
        "download_url": f"/api/users/export/download/{current_user['id']}",
        "expires_at": (datetime.now() + timedelta(hours=24)).isoformat()
    }