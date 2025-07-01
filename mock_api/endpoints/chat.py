from fastapi import APIRouter, WebSocket, WebSocketDisconnect, Query, HTTPException, Depends
from typing import Optional, List, Dict
from datetime import datetime, timedelta
import random
import json
import asyncio

from models import (
    ChatMessage, Conversation, BaseResponse, PaginatedResponse
)
from utils import paginate_data, search_data, sort_data
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_conversations = []
mock_messages = []
active_connections: Dict[int, WebSocket] = {}

# Initialize some mock conversations
def init_mock_data():
    users = [
        {"id": 1, "name": "John Doe", "avatar": "/images/avatars/1.png", "status": "online"},
        {"id": 2, "name": "Jane Smith", "avatar": "/images/avatars/2.png", "status": "offline"},
        {"id": 3, "name": "Mike Johnson", "avatar": "/images/avatars/3.png", "status": "online"},
        {"id": 4, "name": "Sarah Williams", "avatar": "/images/avatars/4.png", "status": "away"},
        {"id": 5, "name": "Tom Brown", "avatar": "/images/avatars/5.png", "status": "offline"}
    ]
    
    # Create some conversations
    for i in range(1, 11):
        participants = random.sample(users, k=random.randint(2, 4))
        conversation = {
            "id": i,
            "participants": participants,
            "created_at": datetime.now() - timedelta(days=random.randint(1, 30)),
            "updated_at": datetime.now() - timedelta(hours=random.randint(1, 48))
        }
        mock_conversations.append(conversation)
        
        # Add some messages to each conversation
        for j in range(random.randint(5, 20)):
            sender = random.choice(participants)
            message = {
                "id": len(mock_messages) + 1,
                "conversation_id": i,
                "sender_id": sender["id"],
                "sender_name": sender["name"],
                "sender_avatar": sender["avatar"],
                "message": f"This is message {j+1} in conversation {i}",
                "timestamp": datetime.now() - timedelta(hours=random.randint(0, 48), minutes=random.randint(0, 59)),
                "is_read": random.random() > 0.3
            }
            mock_messages.append(message)

init_mock_data()

@router.get("/conversations", response_model=PaginatedResponse)
async def get_conversations(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    search: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Get user's conversations"""
    # Filter conversations where user is a participant
    user_conversations = []
    
    for conv in mock_conversations:
        # Check if user is a participant
        is_participant = any(p["id"] == current_user["id"] for p in conv["participants"])
        if is_participant:
            # Get last message
            conv_messages = [m for m in mock_messages if m["conversation_id"] == conv["id"]]
            conv_messages.sort(key=lambda x: x["timestamp"], reverse=True)
            last_message = conv_messages[0] if conv_messages else None
            
            # Count unread messages
            unread_count = sum(1 for m in conv_messages if not m["is_read"] and m["sender_id"] != current_user["id"])
            
            conversation_data = {
                **conv,
                "last_message": last_message,
                "unread_count": unread_count
            }
            user_conversations.append(conversation_data)
    
    # Apply search
    if search:
        search_lower = search.lower()
        filtered_conversations = []
        for conv in user_conversations:
            # Search in participant names
            if any(search_lower in p["name"].lower() for p in conv["participants"]):
                filtered_conversations.append(conv)
                continue
            # Search in last message
            if conv["last_message"] and search_lower in conv["last_message"]["message"].lower():
                filtered_conversations.append(conv)
        user_conversations = filtered_conversations
    
    # Sort by last message timestamp
    user_conversations.sort(
        key=lambda x: x["last_message"]["timestamp"] if x["last_message"] else x["created_at"],
        reverse=True
    )
    
    # Apply pagination
    result = paginate_data(user_conversations, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/conversations/{conversation_id}", response_model=Conversation)
async def get_conversation(
    conversation_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific conversation"""
    conversation = next((c for c in mock_conversations if c["id"] == conversation_id), None)
    if not conversation:
        raise HTTPException(status_code=404, detail="Conversation not found")
    
    # Check if user is a participant
    is_participant = any(p["id"] == current_user["id"] for p in conversation["participants"])
    if not is_participant:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Get conversation details
    conv_messages = [m for m in mock_messages if m["conversation_id"] == conversation_id]
    conv_messages.sort(key=lambda x: x["timestamp"], reverse=True)
    last_message = conv_messages[0] if conv_messages else None
    unread_count = sum(1 for m in conv_messages if not m["is_read"] and m["sender_id"] != current_user["id"])
    
    return Conversation(
        **conversation,
        last_message=last_message,
        unread_count=unread_count
    )

@router.get("/conversations/{conversation_id}/messages", response_model=PaginatedResponse)
async def get_messages(
    conversation_id: int,
    limit: int = Query(20, ge=1, le=100),
    offset: int = Query(0, ge=0),
    current_user: dict = Depends(get_current_user)
):
    """Get messages in a conversation"""
    conversation = next((c for c in mock_conversations if c["id"] == conversation_id), None)
    if not conversation:
        raise HTTPException(status_code=404, detail="Conversation not found")
    
    # Check if user is a participant
    is_participant = any(p["id"] == current_user["id"] for p in conversation["participants"])
    if not is_participant:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Get messages
    conv_messages = [m for m in mock_messages if m["conversation_id"] == conversation_id]
    conv_messages.sort(key=lambda x: x["timestamp"], reverse=True)
    
    # Mark messages as read
    for message in conv_messages:
        if message["sender_id"] != current_user["id"]:
            message_index = next((i for i, m in enumerate(mock_messages) if m["id"] == message["id"]), None)
            if message_index is not None:
                mock_messages[message_index]["is_read"] = True
    
    # Apply pagination
    result = paginate_data(conv_messages, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.post("/conversations", response_model=Conversation)
async def create_conversation(
    participant_ids: List[int],
    initial_message: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Create a new conversation"""
    # Add current user to participants
    if current_user["id"] not in participant_ids:
        participant_ids.append(current_user["id"])
    
    # Check if conversation already exists with these participants
    for conv in mock_conversations:
        conv_participant_ids = [p["id"] for p in conv["participants"]]
        if set(conv_participant_ids) == set(participant_ids):
            # Return existing conversation
            return await get_conversation(conv["id"], current_user)
    
    # Create participants list
    all_users = [
        {"id": 1, "name": "John Doe", "avatar": "/images/avatars/1.png", "status": "online"},
        {"id": 2, "name": "Jane Smith", "avatar": "/images/avatars/2.png", "status": "offline"},
        {"id": 3, "name": "Mike Johnson", "avatar": "/images/avatars/3.png", "status": "online"},
        {"id": 4, "name": "Sarah Williams", "avatar": "/images/avatars/4.png", "status": "away"},
        {"id": 5, "name": "Tom Brown", "avatar": "/images/avatars/5.png", "status": "offline"}
    ]
    
    participants = [u for u in all_users if u["id"] in participant_ids]
    
    # Create new conversation
    new_conversation = {
        "id": len(mock_conversations) + 1,
        "participants": participants,
        "created_at": datetime.now(),
        "updated_at": datetime.now()
    }
    mock_conversations.append(new_conversation)
    
    # Add initial message if provided
    last_message = None
    if initial_message:
        new_message = {
            "id": len(mock_messages) + 1,
            "conversation_id": new_conversation["id"],
            "sender_id": current_user["id"],
            "sender_name": current_user["full_name"],
            "sender_avatar": current_user["avatar"],
            "message": initial_message,
            "timestamp": datetime.now(),
            "is_read": False
        }
        mock_messages.append(new_message)
        last_message = new_message
    
    return Conversation(
        **new_conversation,
        last_message=last_message,
        unread_count=0
    )

@router.post("/conversations/{conversation_id}/messages", response_model=ChatMessage)
async def send_message(
    conversation_id: int,
    message: str,
    current_user: dict = Depends(get_current_user)
):
    """Send a message in a conversation"""
    conversation = next((c for c in mock_conversations if c["id"] == conversation_id), None)
    if not conversation:
        raise HTTPException(status_code=404, detail="Conversation not found")
    
    # Check if user is a participant
    is_participant = any(p["id"] == current_user["id"] for p in conversation["participants"])
    if not is_participant:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Create new message
    new_message = {
        "id": len(mock_messages) + 1,
        "conversation_id": conversation_id,
        "sender_id": current_user["id"],
        "sender_name": current_user["full_name"],
        "sender_avatar": current_user["avatar"],
        "message": message,
        "timestamp": datetime.now(),
        "is_read": False
    }
    mock_messages.append(new_message)
    
    # Update conversation's updated_at
    conv_index = next((i for i, c in enumerate(mock_conversations) if c["id"] == conversation_id), None)
    if conv_index is not None:
        mock_conversations[conv_index]["updated_at"] = datetime.now()
    
    # Send to WebSocket connections
    await broadcast_message(conversation_id, new_message)
    
    return ChatMessage(**new_message)

@router.delete("/conversations/{conversation_id}", response_model=BaseResponse)
async def delete_conversation(
    conversation_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Delete a conversation (for current user only)"""
    conversation = next((c for c in mock_conversations if c["id"] == conversation_id), None)
    if not conversation:
        raise HTTPException(status_code=404, detail="Conversation not found")
    
    # Check if user is a participant
    is_participant = any(p["id"] == current_user["id"] for p in conversation["participants"])
    if not is_participant:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # In a real app, you'd mark it as deleted for this user only
    # For this mock, we'll just return success
    return BaseResponse(success=True, message="Conversation deleted")

@router.websocket("/ws/{user_id}")
async def websocket_endpoint(websocket: WebSocket, user_id: int):
    """WebSocket endpoint for real-time chat"""
    await websocket.accept()
    active_connections[user_id] = websocket
    
    try:
        while True:
            # Wait for messages from client
            data = await websocket.receive_text()
            message_data = json.loads(data)
            
            # Handle different message types
            if message_data.get("type") == "ping":
                await websocket.send_text(json.dumps({"type": "pong"}))
            elif message_data.get("type") == "typing":
                # Broadcast typing indicator
                await broadcast_typing(
                    message_data.get("conversation_id"),
                    user_id,
                    message_data.get("is_typing", False)
                )
    except WebSocketDisconnect:
        del active_connections[user_id]
    except Exception as e:
        print(f"WebSocket error: {e}")
        if user_id in active_connections:
            del active_connections[user_id]

async def broadcast_message(conversation_id: int, message: dict):
    """Broadcast message to all participants in a conversation"""
    conversation = next((c for c in mock_conversations if c["id"] == conversation_id), None)
    if not conversation:
        return
    
    message_json = json.dumps({
        "type": "new_message",
        "conversation_id": conversation_id,
        "message": message
    })
    
    for participant in conversation["participants"]:
        if participant["id"] in active_connections:
            try:
                await active_connections[participant["id"]].send_text(message_json)
            except:
                # Remove broken connections
                del active_connections[participant["id"]]

async def broadcast_typing(conversation_id: int, user_id: int, is_typing: bool):
    """Broadcast typing indicator"""
    conversation = next((c for c in mock_conversations if c["id"] == conversation_id), None)
    if not conversation:
        return
    
    typing_json = json.dumps({
        "type": "typing",
        "conversation_id": conversation_id,
        "user_id": user_id,
        "is_typing": is_typing
    })
    
    for participant in conversation["participants"]:
        if participant["id"] != user_id and participant["id"] in active_connections:
            try:
                await active_connections[participant["id"]].send_text(typing_json)
            except:
                # Remove broken connections
                del active_connections[participant["id"]]

@router.get("/users/online")
async def get_online_users(current_user: dict = Depends(get_current_user)):
    """Get list of online users"""
    all_users = [
        {"id": 1, "name": "John Doe", "avatar": "/images/avatars/1.png"},
        {"id": 2, "name": "Jane Smith", "avatar": "/images/avatars/2.png"},
        {"id": 3, "name": "Mike Johnson", "avatar": "/images/avatars/3.png"},
        {"id": 4, "name": "Sarah Williams", "avatar": "/images/avatars/4.png"},
        {"id": 5, "name": "Tom Brown", "avatar": "/images/avatars/5.png"}
    ]
    
    online_users = []
    for user in all_users:
        if user["id"] != current_user["id"]:
            user["is_online"] = user["id"] in active_connections
            user["last_seen"] = datetime.now().isoformat() if user["is_online"] else (datetime.now() - timedelta(minutes=random.randint(5, 120))).isoformat()
            online_users.append(user)
    
    return {
        "users": online_users,
        "online_count": len([u for u in online_users if u["is_online"]])
    }

@router.put("/messages/{message_id}/read", response_model=BaseResponse)
async def mark_message_read(
    message_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Mark a message as read"""
    message = next((m for m in mock_messages if m["id"] == message_id), None)
    if not message:
        raise HTTPException(status_code=404, detail="Message not found")
    
    # Check if user has access to this message
    conversation = next((c for c in mock_conversations if c["id"] == message["conversation_id"]), None)
    if not conversation:
        raise HTTPException(status_code=404, detail="Conversation not found")
    
    is_participant = any(p["id"] == current_user["id"] for p in conversation["participants"])
    if not is_participant:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Mark as read
    message_index = next((i for i, m in enumerate(mock_messages) if m["id"] == message_id), None)
    if message_index is not None:
        mock_messages[message_index]["is_read"] = True
    
    return BaseResponse(success=True, message="Message marked as read")