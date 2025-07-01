from fastapi import APIRouter, Query, HTTPException, Depends, UploadFile, File
from typing import Optional, List
from datetime import datetime, timedelta
import random

from models import (
    Email, EmailFolder, BaseResponse, PaginatedResponse
)
from utils import generate_mock_emails, paginate_data, search_data, sort_data
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_emails = generate_mock_emails()

@router.get("/messages", response_model=PaginatedResponse)
async def get_emails(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    folder: Optional[EmailFolder] = None,
    is_read: Optional[bool] = None,
    is_starred: Optional[bool] = None,
    has_attachments: Optional[bool] = None,
    search: Optional[str] = None,
    sort_by: Optional[str] = Query("created_at", regex="^(subject|from_name|created_at)$"),
    order: Optional[str] = Query("desc", regex="^(asc|desc)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get emails with filtering, sorting, and pagination"""
    # Filter emails for current user
    user_email = current_user["email"]
    emails = [e for e in mock_emails if user_email in e["to"] or e["from_email"] == user_email]
    
    # Apply folder filter
    if folder:
        if folder == EmailFolder.sent:
            emails = [e for e in emails if e["from_email"] == user_email]
        else:
            emails = [e for e in emails if e["folder"] == folder]
    
    # Apply other filters
    if is_read is not None:
        emails = [e for e in emails if e["is_read"] == is_read]
    if is_starred is not None:
        emails = [e for e in emails if e["is_starred"] == is_starred]
    if has_attachments is not None:
        emails = [e for e in emails if e["has_attachments"] == has_attachments]
    
    # Apply search
    if search:
        emails = search_data(emails, search, ["subject", "body", "from_name", "from_email"])
    
    # Apply sorting
    if sort_by:
        emails = sort_data(emails, sort_by, order)
    
    # Apply pagination
    result = paginate_data(emails, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/messages/{email_id}", response_model=Email)
async def get_email(
    email_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific email by ID"""
    email = next((e for e in mock_emails if e["id"] == email_id), None)
    if not email:
        raise HTTPException(status_code=404, detail="Email not found")
    
    # Check access
    user_email = current_user["email"]
    if user_email not in email["to"] and email["from_email"] != user_email:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Mark as read
    email_index = next((i for i, e in enumerate(mock_emails) if e["id"] == email_id), None)
    if email_index is not None:
        mock_emails[email_index]["is_read"] = True
    
    return email

@router.post("/compose", response_model=Email)
async def compose_email(
    to: List[str],
    subject: str,
    body: str,
    cc: Optional[List[str]] = None,
    bcc: Optional[List[str]] = None,
    save_as_draft: bool = False,
    current_user: dict = Depends(get_current_user)
):
    """Compose and send a new email"""
    new_email = {
        "id": len(mock_emails) + 1,
        "from_email": current_user["email"],
        "from_name": current_user["full_name"],
        "to": to,
        "cc": cc,
        "bcc": bcc,
        "subject": subject,
        "body": body,
        "folder": EmailFolder.draft if save_as_draft else EmailFolder.sent,
        "is_read": True,  # Sender has read their own email
        "is_starred": False,
        "has_attachments": False,
        "attachments": None,
        "created_at": datetime.now()
    }
    
    mock_emails.append(new_email)
    
    # If not a draft, create inbox copies for recipients
    if not save_as_draft:
        for recipient in to:
            recipient_email = new_email.copy()
            recipient_email.update({
                "id": len(mock_emails) + 1,
                "folder": EmailFolder.inbox,
                "is_read": False
            })
            mock_emails.append(recipient_email)
    
    return Email(**new_email)

@router.put("/messages/{email_id}", response_model=BaseResponse)
async def update_email(
    email_id: int,
    is_read: Optional[bool] = None,
    is_starred: Optional[bool] = None,
    folder: Optional[EmailFolder] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update email properties"""
    email = next((e for e in mock_emails if e["id"] == email_id), None)
    if not email:
        raise HTTPException(status_code=404, detail="Email not found")
    
    # Check access
    user_email = current_user["email"]
    if user_email not in email["to"] and email["from_email"] != user_email:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Update properties
    email_index = next((i for i, e in enumerate(mock_emails) if e["id"] == email_id), None)
    if email_index is not None:
        if is_read is not None:
            mock_emails[email_index]["is_read"] = is_read
        if is_starred is not None:
            mock_emails[email_index]["is_starred"] = is_starred
        if folder is not None:
            mock_emails[email_index]["folder"] = folder
    
    return BaseResponse(success=True, message="Email updated")

@router.delete("/messages/{email_id}", response_model=BaseResponse)
async def delete_email(
    email_id: int,
    permanent: bool = False,
    current_user: dict = Depends(get_current_user)
):
    """Delete an email (move to trash or permanent delete)"""
    email = next((e for e in mock_emails if e["id"] == email_id), None)
    if not email:
        raise HTTPException(status_code=404, detail="Email not found")
    
    # Check access
    user_email = current_user["email"]
    if user_email not in email["to"] and email["from_email"] != user_email:
        raise HTTPException(status_code=403, detail="Access denied")
    
    if permanent or email["folder"] == EmailFolder.trash:
        # Permanent delete
        mock_emails[:] = [e for e in mock_emails if e["id"] != email_id]
        message = "Email permanently deleted"
    else:
        # Move to trash
        email_index = next((i for i, e in enumerate(mock_emails) if e["id"] == email_id), None)
        if email_index is not None:
            mock_emails[email_index]["folder"] = EmailFolder.trash
        message = "Email moved to trash"
    
    return BaseResponse(success=True, message=message)

@router.post("/messages/bulk-action", response_model=BaseResponse)
async def bulk_action(
    email_ids: List[int],
    action: str = Query(..., regex="^(mark_read|mark_unread|star|unstar|move|delete)$"),
    folder: Optional[EmailFolder] = None,
    current_user: dict = Depends(get_current_user)
):
    """Perform bulk actions on multiple emails"""
    user_email = current_user["email"]
    updated_count = 0
    
    for email_id in email_ids:
        email = next((e for e in mock_emails if e["id"] == email_id), None)
        if not email:
            continue
        
        # Check access
        if user_email not in email["to"] and email["from_email"] != user_email:
            continue
        
        email_index = next((i for i, e in enumerate(mock_emails) if e["id"] == email_id), None)
        if email_index is None:
            continue
        
        if action == "mark_read":
            mock_emails[email_index]["is_read"] = True
        elif action == "mark_unread":
            mock_emails[email_index]["is_read"] = False
        elif action == "star":
            mock_emails[email_index]["is_starred"] = True
        elif action == "unstar":
            mock_emails[email_index]["is_starred"] = False
        elif action == "move" and folder:
            mock_emails[email_index]["folder"] = folder
        elif action == "delete":
            if email["folder"] == EmailFolder.trash:
                mock_emails[:] = [e for e in mock_emails if e["id"] != email_id]
            else:
                mock_emails[email_index]["folder"] = EmailFolder.trash
        
        updated_count += 1
    
    return BaseResponse(
        success=True,
        message=f"{updated_count} emails updated"
    )

@router.get("/folders")
async def get_folders(current_user: dict = Depends(get_current_user)):
    """Get email folders with counts"""
    user_email = current_user["email"]
    folders = {}
    
    # Initialize all folders
    for folder in EmailFolder:
        folders[folder.value] = {
            "name": folder.value.capitalize(),
            "type": folder.value,
            "count": 0,
            "unread_count": 0,
            "icon": f"tabler-{folder.value}"
        }
    
    # Count emails in each folder
    for email in mock_emails:
        if user_email in email["to"] or email["from_email"] == user_email:
            folder_type = email["folder"]
            if folder_type == EmailFolder.sent and email["from_email"] != user_email:
                continue
            
            folders[folder_type]["count"] += 1
            if not email["is_read"]:
                folders[folder_type]["unread_count"] += 1
    
    return {
        "folders": list(folders.values()),
        "total_emails": sum(f["count"] for f in folders.values()),
        "total_unread": sum(f["unread_count"] for f in folders.values())
    }

@router.post("/messages/{email_id}/reply", response_model=Email)
async def reply_to_email(
    email_id: int,
    body: str,
    reply_all: bool = False,
    current_user: dict = Depends(get_current_user)
):
    """Reply to an email"""
    original_email = next((e for e in mock_emails if e["id"] == email_id), None)
    if not original_email:
        raise HTTPException(status_code=404, detail="Email not found")
    
    # Determine recipients
    to = [original_email["from_email"]]
    cc = None
    
    if reply_all:
        # Add all original recipients except current user
        to.extend([r for r in original_email["to"] if r != current_user["email"]])
        if original_email["cc"]:
            cc = [r for r in original_email["cc"] if r != current_user["email"]]
    
    # Create reply
    reply_email = {
        "id": len(mock_emails) + 1,
        "from_email": current_user["email"],
        "from_name": current_user["full_name"],
        "to": to,
        "cc": cc,
        "bcc": None,
        "subject": f"Re: {original_email['subject']}",
        "body": f"{body}\n\n---\nOn {original_email['created_at']}, {original_email['from_name']} wrote:\n{original_email['body']}",
        "folder": EmailFolder.sent,
        "is_read": True,
        "is_starred": False,
        "has_attachments": False,
        "attachments": None,
        "created_at": datetime.now()
    }
    
    mock_emails.append(reply_email)
    
    # Create inbox copies for recipients
    for recipient in to:
        if recipient != current_user["email"]:
            recipient_email = reply_email.copy()
            recipient_email.update({
                "id": len(mock_emails) + 1,
                "folder": EmailFolder.inbox,
                "is_read": False
            })
            mock_emails.append(recipient_email)
    
    return Email(**reply_email)

@router.post("/messages/{email_id}/forward", response_model=Email)
async def forward_email(
    email_id: int,
    to: List[str],
    body: str = "",
    current_user: dict = Depends(get_current_user)
):
    """Forward an email"""
    original_email = next((e for e in mock_emails if e["id"] == email_id), None)
    if not original_email:
        raise HTTPException(status_code=404, detail="Email not found")
    
    # Create forwarded email
    forward_email = {
        "id": len(mock_emails) + 1,
        "from_email": current_user["email"],
        "from_name": current_user["full_name"],
        "to": to,
        "cc": None,
        "bcc": None,
        "subject": f"Fwd: {original_email['subject']}",
        "body": f"{body}\n\n--- Forwarded message ---\nFrom: {original_email['from_name']} <{original_email['from_email']}>\nDate: {original_email['created_at']}\nSubject: {original_email['subject']}\nTo: {', '.join(original_email['to'])}\n\n{original_email['body']}",
        "folder": EmailFolder.sent,
        "is_read": True,
        "is_starred": False,
        "has_attachments": original_email["has_attachments"],
        "attachments": original_email["attachments"],
        "created_at": datetime.now()
    }
    
    mock_emails.append(forward_email)
    
    # Create inbox copies for recipients
    for recipient in to:
        recipient_email = forward_email.copy()
        recipient_email.update({
            "id": len(mock_emails) + 1,
            "folder": EmailFolder.inbox,
            "is_read": False
        })
        mock_emails.append(recipient_email)
    
    return Email(**forward_email)

@router.post("/messages/{email_id}/attachment", response_model=BaseResponse)
async def upload_attachment(
    email_id: int,
    file: UploadFile = File(...),
    current_user: dict = Depends(get_current_user)
):
    """Upload an attachment to a draft email"""
    email = next((e for e in mock_emails if e["id"] == email_id), None)
    if not email:
        raise HTTPException(status_code=404, detail="Email not found")
    
    # Check if it's a draft
    if email["folder"] != EmailFolder.draft:
        raise HTTPException(status_code=400, detail="Can only add attachments to draft emails")
    
    # Check access
    if email["from_email"] != current_user["email"]:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Add attachment (mock implementation)
    email_index = next((i for i, e in enumerate(mock_emails) if e["id"] == email_id), None)
    if email_index is not None:
        if not mock_emails[email_index]["attachments"]:
            mock_emails[email_index]["attachments"] = []
        
        mock_emails[email_index]["attachments"].append({
            "name": file.filename,
            "size": random.randint(1000, 5000000),  # Mock size
            "type": file.content_type
        })
        mock_emails[email_index]["has_attachments"] = True
    
    return BaseResponse(success=True, message="Attachment uploaded")