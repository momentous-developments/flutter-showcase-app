from pydantic import BaseModel, Field, EmailStr
from typing import Optional, List, Dict, Any
from datetime import datetime
from enum import Enum

# Base models
class PaginationParams(BaseModel):
    limit: int = Field(default=10, ge=1, le=100)
    offset: int = Field(default=0, ge=0)
    
class SortParams(BaseModel):
    sort_by: Optional[str] = None
    order: Optional[str] = Field(default="asc", pattern="^(asc|desc)$")

class SearchParams(BaseModel):
    q: Optional[str] = None
    
class BaseResponse(BaseModel):
    success: bool = True
    message: Optional[str] = None
    
class PaginatedResponse(BaseResponse):
    total: int
    limit: int
    offset: int
    data: List[Any]

# Auth models
class LoginRequest(BaseModel):
    email: EmailStr
    password: str
    
class RegisterRequest(BaseModel):
    email: EmailStr
    password: str
    username: str
    full_name: Optional[str] = None
    
class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int = 3600
    
class UserResponse(BaseModel):
    id: int
    email: str
    username: str
    full_name: Optional[str]
    avatar: Optional[str]
    role: str
    created_at: datetime
    
# Academy models
class CourseStatus(str, Enum):
    active = "active"
    completed = "completed"
    upcoming = "upcoming"
    
class Course(BaseModel):
    id: int
    title: str
    description: str
    instructor: str
    instructor_avatar: str
    thumbnail: str
    duration: str
    total_lessons: int
    completed_lessons: int
    enrolled_students: int
    rating: float
    reviews_count: int
    price: float
    category: str
    tags: List[str]
    status: CourseStatus
    
# E-commerce models
class ProductStatus(str, Enum):
    in_stock = "in_stock"
    out_of_stock = "out_of_stock"
    limited = "limited"
    
class Product(BaseModel):
    id: int
    name: str
    description: str
    price: float
    discount_price: Optional[float]
    sku: str
    category: str
    brand: str
    images: List[str]
    stock: int
    status: ProductStatus
    rating: float
    reviews_count: int
    tags: List[str]
    
class OrderStatus(str, Enum):
    pending = "pending"
    processing = "processing"
    shipped = "shipped"
    delivered = "delivered"
    cancelled = "cancelled"
    
class Order(BaseModel):
    id: int
    order_number: str
    customer_id: int
    customer_name: str
    items: List[Dict[str, Any]]
    total_amount: float
    status: OrderStatus
    payment_method: str
    shipping_address: Dict[str, str]
    created_at: datetime
    updated_at: datetime
    
# Email models
class EmailFolder(str, Enum):
    inbox = "inbox"
    sent = "sent"
    draft = "draft"
    starred = "starred"
    spam = "spam"
    trash = "trash"
    
class Email(BaseModel):
    id: int
    from_email: str
    from_name: str
    to: List[str]
    cc: Optional[List[str]]
    bcc: Optional[List[str]]
    subject: str
    body: str
    folder: EmailFolder
    is_read: bool
    is_starred: bool
    has_attachments: bool
    attachments: Optional[List[Dict[str, Any]]]
    created_at: datetime
    
# Chat models
class ChatMessage(BaseModel):
    id: int
    conversation_id: int
    sender_id: int
    sender_name: str
    sender_avatar: str
    message: str
    timestamp: datetime
    is_read: bool
    
class Conversation(BaseModel):
    id: int
    participants: List[Dict[str, Any]]
    last_message: Optional[ChatMessage]
    unread_count: int
    created_at: datetime
    updated_at: datetime
    
# Calendar models
class EventType(str, Enum):
    meeting = "meeting"
    appointment = "appointment"
    reminder = "reminder"
    task = "task"
    
class CalendarEvent(BaseModel):
    id: int
    title: str
    description: Optional[str]
    start_time: datetime
    end_time: datetime
    all_day: bool
    location: Optional[str]
    attendees: Optional[List[str]]
    type: EventType
    color: str
    reminder: Optional[int]  # minutes before
    
# Invoice models
class InvoiceStatus(str, Enum):
    draft = "draft"
    sent = "sent"
    paid = "paid"
    overdue = "overdue"
    cancelled = "cancelled"
    
class Invoice(BaseModel):
    id: int
    invoice_number: str
    client_id: int
    client_name: str
    client_email: str
    items: List[Dict[str, Any]]
    subtotal: float
    tax: float
    total: float
    status: InvoiceStatus
    due_date: datetime
    created_at: datetime
    paid_at: Optional[datetime]
    
# Kanban models
class TaskPriority(str, Enum):
    low = "low"
    medium = "medium"
    high = "high"
    urgent = "urgent"
    
class KanbanTask(BaseModel):
    id: int
    title: str
    description: Optional[str]
    column_id: int
    assignee_id: Optional[int]
    assignee_name: Optional[str]
    assignee_avatar: Optional[str]
    priority: TaskPriority
    due_date: Optional[datetime]
    tags: List[str]
    attachments: List[Dict[str, Any]]
    comments_count: int
    created_at: datetime
    updated_at: datetime
    
class KanbanColumn(BaseModel):
    id: int
    board_id: int
    title: str
    position: int
    tasks: List[KanbanTask]
    
class KanbanBoard(BaseModel):
    id: int
    title: str
    description: Optional[str]
    columns: List[KanbanColumn]
    members: List[Dict[str, Any]]
    created_at: datetime
    updated_at: datetime
    
# Logistics models
class VehicleStatus(str, Enum):
    available = "available"
    in_transit = "in_transit"
    maintenance = "maintenance"
    
class DeliveryStatus(str, Enum):
    pending = "pending"
    picked_up = "picked_up"
    in_transit = "in_transit"
    delivered = "delivered"
    failed = "failed"
    
class Vehicle(BaseModel):
    id: int
    vehicle_number: str
    type: str
    capacity: float
    driver_id: Optional[int]
    driver_name: Optional[str]
    status: VehicleStatus
    current_location: Dict[str, float]
    last_updated: datetime
    
class Delivery(BaseModel):
    id: int
    tracking_number: str
    sender_name: str
    sender_address: Dict[str, str]
    recipient_name: str
    recipient_address: Dict[str, str]
    vehicle_id: Optional[int]
    status: DeliveryStatus
    estimated_delivery: datetime
    actual_delivery: Optional[datetime]
    created_at: datetime
    updated_at: datetime