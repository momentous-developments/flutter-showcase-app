from fastapi import APIRouter, Query, HTTPException, Depends
from typing import Optional, List
from datetime import datetime, timedelta, date
import random

from models import (
    CalendarEvent, EventType, BaseResponse, PaginatedResponse
)
from utils import paginate_data, search_data, sort_data
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_events = []

# Generate some mock events
def init_mock_events():
    event_titles = [
        "Team Meeting", "Project Review", "Client Call", "Design Workshop",
        "Sprint Planning", "Code Review", "Lunch Meeting", "Training Session",
        "Product Demo", "Strategy Meeting", "Interview", "All Hands Meeting"
    ]
    
    locations = [
        "Conference Room A", "Conference Room B", "Virtual - Zoom",
        "Virtual - Teams", "Office Cafeteria", "Meeting Room 101",
        None  # Some events don't have locations
    ]
    
    colors = ["#FF5733", "#33FF57", "#3357FF", "#FF33F5", "#33FFF5", "#F5FF33"]
    
    # Generate events for the next 60 days
    for i in range(50):
        start_date = datetime.now() + timedelta(days=random.randint(-30, 30))
        duration_hours = random.choice([0.5, 1, 1.5, 2, 3, 8])  # 8 for all-day events
        
        event = {
            "id": i + 1,
            "title": random.choice(event_titles),
            "description": f"This is a description for event {i + 1}",
            "start_time": start_date,
            "end_time": start_date + timedelta(hours=duration_hours),
            "all_day": duration_hours == 8,
            "location": random.choice(locations),
            "attendees": [f"user{j}@example.com" for j in range(random.randint(1, 5))],
            "type": random.choice(list(EventType)),
            "color": random.choice(colors),
            "reminder": random.choice([None, 15, 30, 60]),  # minutes before
            "user_id": random.randint(1, 5)  # Mock user ownership
        }
        mock_events.append(event)

init_mock_events()

@router.get("/events", response_model=PaginatedResponse)
async def get_events(
    limit: int = Query(50, ge=1, le=200),
    offset: int = Query(0, ge=0),
    start_date: Optional[date] = None,
    end_date: Optional[date] = None,
    type: Optional[EventType] = None,
    search: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Get calendar events with filtering"""
    # Filter events for current user
    user_events = [e for e in mock_events if e["user_id"] == current_user["id"]]
    
    # Apply date filters
    if start_date:
        user_events = [e for e in user_events if e["start_time"].date() >= start_date]
    if end_date:
        user_events = [e for e in user_events if e["start_time"].date() <= end_date]
    
    # Apply type filter
    if type:
        user_events = [e for e in user_events if e["type"] == type]
    
    # Apply search
    if search:
        user_events = search_data(user_events, search, ["title", "description", "location"])
    
    # Sort by start time
    user_events.sort(key=lambda x: x["start_time"])
    
    # Apply pagination
    result = paginate_data(user_events, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/events/{event_id}", response_model=CalendarEvent)
async def get_event(
    event_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific event by ID"""
    event = next((e for e in mock_events if e["id"] == event_id), None)
    if not event:
        raise HTTPException(status_code=404, detail="Event not found")
    
    # Check if user owns this event or is an attendee
    if event["user_id"] != current_user["id"] and current_user["email"] not in event.get("attendees", []):
        raise HTTPException(status_code=403, detail="Access denied")
    
    return event

@router.post("/events", response_model=CalendarEvent)
async def create_event(
    event: CalendarEvent,
    current_user: dict = Depends(get_current_user)
):
    """Create a new calendar event"""
    new_event = {
        "id": len(mock_events) + 1,
        "title": event.title,
        "description": event.description,
        "start_time": event.start_time,
        "end_time": event.end_time,
        "all_day": event.all_day,
        "location": event.location,
        "attendees": event.attendees or [],
        "type": event.type,
        "color": event.color,
        "reminder": event.reminder,
        "user_id": current_user["id"]
    }
    
    # Validate times
    if new_event["end_time"] <= new_event["start_time"]:
        raise HTTPException(status_code=400, detail="End time must be after start time")
    
    mock_events.append(new_event)
    
    # TODO: In a real app, send invitations to attendees
    
    return CalendarEvent(**new_event)

@router.put("/events/{event_id}", response_model=CalendarEvent)
async def update_event(
    event_id: int,
    event: CalendarEvent,
    current_user: dict = Depends(get_current_user)
):
    """Update an existing event"""
    existing_event = next((e for e in mock_events if e["id"] == event_id), None)
    if not existing_event:
        raise HTTPException(status_code=404, detail="Event not found")
    
    # Check if user owns this event
    if existing_event["user_id"] != current_user["id"]:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Update event
    event_index = next((i for i, e in enumerate(mock_events) if e["id"] == event_id), None)
    if event_index is not None:
        updated_event = {
            "id": event_id,
            "title": event.title,
            "description": event.description,
            "start_time": event.start_time,
            "end_time": event.end_time,
            "all_day": event.all_day,
            "location": event.location,
            "attendees": event.attendees or [],
            "type": event.type,
            "color": event.color,
            "reminder": event.reminder,
            "user_id": current_user["id"]
        }
        
        # Validate times
        if updated_event["end_time"] <= updated_event["start_time"]:
            raise HTTPException(status_code=400, detail="End time must be after start time")
        
        mock_events[event_index] = updated_event
        
        return CalendarEvent(**updated_event)
    
    raise HTTPException(status_code=500, detail="Failed to update event")

@router.delete("/events/{event_id}", response_model=BaseResponse)
async def delete_event(
    event_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Delete an event"""
    event = next((e for e in mock_events if e["id"] == event_id), None)
    if not event:
        raise HTTPException(status_code=404, detail="Event not found")
    
    # Check if user owns this event
    if event["user_id"] != current_user["id"]:
        raise HTTPException(status_code=403, detail="Access denied")
    
    # Remove event
    mock_events[:] = [e for e in mock_events if e["id"] != event_id]
    
    return BaseResponse(success=True, message="Event deleted successfully")

@router.get("/events/month/{year}/{month}")
async def get_month_events(
    year: int,
    month: int,
    current_user: dict = Depends(get_current_user)
):
    """Get events for a specific month"""
    # Validate month
    if month < 1 or month > 12:
        raise HTTPException(status_code=400, detail="Invalid month")
    
    # Get first and last day of month
    first_day = date(year, month, 1)
    if month == 12:
        last_day = date(year + 1, 1, 1) - timedelta(days=1)
    else:
        last_day = date(year, month + 1, 1) - timedelta(days=1)
    
    # Filter events
    user_events = [e for e in mock_events if e["user_id"] == current_user["id"]]
    month_events = [
        e for e in user_events
        if first_day <= e["start_time"].date() <= last_day
    ]
    
    # Group by day
    events_by_day = {}
    for event in month_events:
        day = event["start_time"].day
        if day not in events_by_day:
            events_by_day[day] = []
        events_by_day[day].append({
            "id": event["id"],
            "title": event["title"],
            "start_time": event["start_time"].isoformat(),
            "end_time": event["end_time"].isoformat(),
            "all_day": event["all_day"],
            "color": event["color"],
            "type": event["type"]
        })
    
    return {
        "year": year,
        "month": month,
        "events_by_day": events_by_day,
        "total_events": len(month_events)
    }

@router.get("/events/week/{year}/{week}")
async def get_week_events(
    year: int,
    week: int,
    current_user: dict = Depends(get_current_user)
):
    """Get events for a specific week"""
    # Calculate week start and end
    jan1 = date(year, 1, 1)
    week_start = jan1 + timedelta(days=(week - 1) * 7 - jan1.weekday())
    week_end = week_start + timedelta(days=6)
    
    # Filter events
    user_events = [e for e in mock_events if e["user_id"] == current_user["id"]]
    week_events = [
        e for e in user_events
        if week_start <= e["start_time"].date() <= week_end
    ]
    
    # Group by day
    events_by_day = {}
    for i in range(7):
        day_date = week_start + timedelta(days=i)
        day_key = day_date.isoformat()
        events_by_day[day_key] = []
        
        for event in week_events:
            if event["start_time"].date() == day_date:
                events_by_day[day_key].append({
                    "id": event["id"],
                    "title": event["title"],
                    "start_time": event["start_time"].isoformat(),
                    "end_time": event["end_time"].isoformat(),
                    "all_day": event["all_day"],
                    "color": event["color"],
                    "type": event["type"],
                    "location": event["location"]
                })
    
    return {
        "year": year,
        "week": week,
        "week_start": week_start.isoformat(),
        "week_end": week_end.isoformat(),
        "events_by_day": events_by_day,
        "total_events": len(week_events)
    }

@router.get("/events/upcoming")
async def get_upcoming_events(
    limit: int = Query(10, ge=1, le=50),
    current_user: dict = Depends(get_current_user)
):
    """Get upcoming events for the current user"""
    now = datetime.now()
    
    # Filter upcoming events
    user_events = [e for e in mock_events if e["user_id"] == current_user["id"]]
    upcoming_events = [e for e in user_events if e["start_time"] > now]
    
    # Sort by start time
    upcoming_events.sort(key=lambda x: x["start_time"])
    
    # Limit results
    upcoming_events = upcoming_events[:limit]
    
    return {
        "events": [CalendarEvent(**e) for e in upcoming_events],
        "count": len(upcoming_events)
    }

@router.post("/events/{event_id}/rsvp", response_model=BaseResponse)
async def rsvp_to_event(
    event_id: int,
    response: str = Query(..., regex="^(yes|no|maybe)$"),
    current_user: dict = Depends(get_current_user)
):
    """RSVP to an event invitation"""
    event = next((e for e in mock_events if e["id"] == event_id), None)
    if not event:
        raise HTTPException(status_code=404, detail="Event not found")
    
    # Check if user is invited
    if current_user["email"] not in event.get("attendees", []):
        raise HTTPException(status_code=403, detail="You are not invited to this event")
    
    # TODO: In a real app, store RSVP responses
    
    return BaseResponse(success=True, message=f"RSVP recorded: {response}")

@router.get("/events/search")
async def search_events(
    q: str,
    limit: int = Query(20, ge=1, le=100),
    current_user: dict = Depends(get_current_user)
):
    """Search events by title, description, or location"""
    if not q:
        raise HTTPException(status_code=400, detail="Search query is required")
    
    # Filter user events
    user_events = [e for e in mock_events if e["user_id"] == current_user["id"]]
    
    # Search
    results = search_data(user_events, q, ["title", "description", "location"])
    
    # Sort by relevance (start time for now)
    results.sort(key=lambda x: x["start_time"])
    
    # Limit results
    results = results[:limit]
    
    return {
        "query": q,
        "results": [CalendarEvent(**e) for e in results],
        "count": len(results)
    }