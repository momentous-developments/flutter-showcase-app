import json
import os
from typing import List, Dict, Any, Optional
from datetime import datetime, timedelta
import random
import hashlib
from passlib.context import CryptContext
from jose import JWTError, jwt

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# JWT settings
SECRET_KEY = "your-secret-key-here-change-in-production"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_DAYS = 7

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire, "type": "access"})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def create_refresh_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS)
    to_encode.update({"exp": expire, "type": "refresh"})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def verify_token(token: str, token_type: str = "access"):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        if payload.get("type") != token_type:
            return None
        return payload
    except JWTError:
        return None

def load_mock_data(filename: str) -> Dict[str, Any]:
    """Load mock data from TypeScript files"""
    data_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), "data")
    
    # Try different paths
    paths_to_try = [
        os.path.join(data_dir, "apps", f"{filename}.ts"),
        os.path.join(data_dir, "pages", f"{filename}.ts"),
        os.path.join(data_dir, f"{filename}.ts")
    ]
    
    for filepath in paths_to_try:
        if os.path.exists(filepath):
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                # Parse TypeScript file to extract data
                # This is a simplified parser - in production you'd use a proper TS parser
                try:
                    # Extract the db export
                    start = content.find("export const db")
                    if start == -1:
                        start = content.find("const db")
                    if start != -1:
                        # Find the opening brace
                        brace_start = content.find("{", start)
                        if brace_start != -1:
                            # Count braces to find the matching closing brace
                            brace_count = 0
                            i = brace_start
                            while i < len(content):
                                if content[i] == '{':
                                    brace_count += 1
                                elif content[i] == '}':
                                    brace_count -= 1
                                    if brace_count == 0:
                                        # Extract and clean the data
                                        data_str = content[brace_start:i+1]
                                        # Convert TypeScript object to Python dict
                                        return parse_ts_object(data_str)
                                i += 1
                except Exception as e:
                    print(f"Error parsing {filepath}: {e}")
    
    # Return empty dict if no data found
    return {}

def parse_ts_object(ts_str: str) -> Dict[str, Any]:
    """Convert TypeScript object string to Python dict"""
    # This is a very simplified parser
    # In production, you'd use a proper TypeScript parser
    
    # Remove TypeScript-specific syntax
    cleaned = ts_str
    # Remove type annotations
    import re
    cleaned = re.sub(r':\s*\w+(\[\])?', '', cleaned)
    # Convert single quotes to double quotes for JSON
    cleaned = cleaned.replace("'", '"')
    # Remove trailing commas
    cleaned = re.sub(r',\s*}', '}', cleaned)
    cleaned = re.sub(r',\s*]', ']', cleaned)
    
    try:
        # Try to parse as JSON
        return json.loads(cleaned)
    except:
        # If that fails, return a default structure
        return {
            "courses": generate_mock_courses(),
            "products": generate_mock_products(),
            "emails": generate_mock_emails(),
            "invoices": generate_mock_invoices(),
            "tasks": generate_mock_tasks()
        }

def generate_mock_courses() -> List[Dict[str, Any]]:
    """Generate mock course data"""
    courses = []
    categories = ["Web Development", "Mobile Development", "Data Science", "Design", "Business"]
    instructors = ["John Doe", "Jane Smith", "Mike Johnson", "Sarah Williams", "Tom Brown"]
    
    for i in range(1, 21):
        courses.append({
            "id": i,
            "title": f"Course {i}: Introduction to {random.choice(['React', 'Flutter', 'Python', 'UI/UX', 'Marketing'])}",
            "description": f"Learn the fundamentals and advanced concepts in this comprehensive course.",
            "instructor": random.choice(instructors),
            "instructor_avatar": f"/images/avatars/{random.randint(1, 8)}.png",
            "thumbnail": f"/images/courses/{i}.jpg",
            "duration": f"{random.randint(10, 40)}h {random.randint(0, 59)}m",
            "total_lessons": random.randint(20, 100),
            "completed_lessons": random.randint(0, 50),
            "enrolled_students": random.randint(100, 5000),
            "rating": round(random.uniform(4.0, 5.0), 1),
            "reviews_count": random.randint(10, 500),
            "price": random.choice([0, 29.99, 49.99, 99.99, 199.99]),
            "category": random.choice(categories),
            "tags": random.sample(["Beginner", "Intermediate", "Advanced", "Certificate", "Popular"], k=2),
            "status": random.choice(["active", "completed", "upcoming"])
        })
    
    return courses

def generate_mock_products() -> List[Dict[str, Any]]:
    """Generate mock product data"""
    products = []
    categories = ["Electronics", "Clothing", "Books", "Home & Garden", "Sports"]
    brands = ["TechCorp", "StyleBrand", "HomeGoods", "SportsPro", "BookWorld"]
    
    for i in range(1, 51):
        price = round(random.uniform(10, 1000), 2)
        products.append({
            "id": i,
            "name": f"Product {i}",
            "description": f"High-quality product with excellent features and durability.",
            "price": price,
            "discount_price": price * 0.8 if random.random() > 0.7 else None,
            "sku": f"SKU-{i:05d}",
            "category": random.choice(categories),
            "brand": random.choice(brands),
            "images": [f"/images/products/{i}-{j}.jpg" for j in range(1, random.randint(2, 5))],
            "stock": random.randint(0, 100),
            "status": "out_of_stock" if random.randint(0, 100) == 0 else ("limited" if random.randint(0, 100) < 20 else "in_stock"),
            "rating": round(random.uniform(3.5, 5.0), 1),
            "reviews_count": random.randint(0, 200),
            "tags": random.sample(["New", "Sale", "Popular", "Limited Edition", "Eco-Friendly"], k=random.randint(1, 3))
        })
    
    return products

def generate_mock_emails() -> List[Dict[str, Any]]:
    """Generate mock email data"""
    emails = []
    subjects = [
        "Meeting reminder",
        "Project update",
        "Invoice attached",
        "Welcome to our service",
        "Your order has been shipped",
        "Weekly newsletter",
        "Important announcement"
    ]
    senders = [
        ("John Doe", "john@example.com"),
        ("Jane Smith", "jane@example.com"),
        ("Support Team", "support@company.com"),
        ("Marketing", "marketing@company.com"),
        ("HR Department", "hr@company.com")
    ]
    
    for i in range(1, 101):
        sender = random.choice(senders)
        emails.append({
            "id": i,
            "from_email": sender[1],
            "from_name": sender[0],
            "to": ["user@example.com"],
            "cc": ["cc@example.com"] if random.random() > 0.8 else None,
            "bcc": None,
            "subject": random.choice(subjects),
            "body": f"This is the email body content for email {i}. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "folder": random.choice(["inbox", "sent", "draft", "starred", "spam", "trash"]),
            "is_read": random.random() > 0.3,
            "is_starred": random.random() > 0.9,
            "has_attachments": random.random() > 0.8,
            "attachments": [{"name": f"document{i}.pdf", "size": random.randint(100, 5000)}] if random.random() > 0.8 else None,
            "created_at": (datetime.now() - timedelta(days=random.randint(0, 30))).isoformat()
        })
    
    return emails

def generate_mock_invoices() -> List[Dict[str, Any]]:
    """Generate mock invoice data"""
    invoices = []
    clients = [
        ("ABC Corp", "billing@abccorp.com"),
        ("XYZ Industries", "accounts@xyz.com"),
        ("Tech Solutions", "finance@techsol.com"),
        ("Global Services", "payments@global.com"),
        ("Local Business", "owner@local.com")
    ]
    
    for i in range(1, 31):
        client = random.choice(clients)
        subtotal = round(random.uniform(100, 10000), 2)
        tax = round(subtotal * 0.1, 2)
        
        invoices.append({
            "id": i,
            "invoice_number": f"INV-{2024000 + i}",
            "client_id": random.randint(1, 10),
            "client_name": client[0],
            "client_email": client[1],
            "items": [
                {
                    "description": f"Service {j}",
                    "quantity": random.randint(1, 10),
                    "rate": round(random.uniform(50, 500), 2),
                    "amount": round(random.uniform(50, 2000), 2)
                } for j in range(1, random.randint(2, 6))
            ],
            "subtotal": subtotal,
            "tax": tax,
            "total": subtotal + tax,
            "status": random.choice(["draft", "sent", "paid", "overdue", "cancelled"]),
            "due_date": (datetime.now() + timedelta(days=random.randint(-30, 30))).isoformat(),
            "created_at": (datetime.now() - timedelta(days=random.randint(0, 60))).isoformat(),
            "paid_at": (datetime.now() - timedelta(days=random.randint(0, 30))).isoformat() if random.random() > 0.5 else None
        })
    
    return invoices

def generate_mock_tasks() -> List[Dict[str, Any]]:
    """Generate mock kanban tasks"""
    tasks = []
    titles = [
        "Update homepage design",
        "Fix login bug",
        "Add new feature",
        "Write documentation",
        "Review pull request",
        "Deploy to production",
        "Update dependencies"
    ]
    assignees = [
        ("John Doe", "/images/avatars/1.png"),
        ("Jane Smith", "/images/avatars/2.png"),
        ("Mike Johnson", "/images/avatars/3.png"),
        ("Sarah Williams", "/images/avatars/4.png"),
        (None, None)
    ]
    
    for i in range(1, 41):
        assignee = random.choice(assignees)
        tasks.append({
            "id": i,
            "title": random.choice(titles),
            "description": f"Task description for task {i}. This needs to be completed as part of the current sprint.",
            "column_id": random.randint(1, 4),
            "assignee_id": random.randint(1, 4) if assignee[0] else None,
            "assignee_name": assignee[0],
            "assignee_avatar": assignee[1],
            "priority": random.choice(["low", "medium", "high", "urgent"]),
            "due_date": (datetime.now() + timedelta(days=random.randint(-7, 14))).isoformat() if random.random() > 0.5 else None,
            "tags": random.sample(["bug", "feature", "enhancement", "documentation", "testing"], k=random.randint(1, 3)),
            "attachments": [],
            "comments_count": random.randint(0, 10),
            "created_at": (datetime.now() - timedelta(days=random.randint(0, 30))).isoformat(),
            "updated_at": (datetime.now() - timedelta(days=random.randint(0, 7))).isoformat()
        })
    
    return tasks

def paginate_data(data: List[Any], limit: int, offset: int) -> Dict[str, Any]:
    """Paginate a list of data"""
    total = len(data)
    paginated = data[offset:offset + limit]
    
    return {
        "total": total,
        "limit": limit,
        "offset": offset,
        "data": paginated
    }

def filter_data(data: List[Dict[str, Any]], filters: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Filter data based on provided filters"""
    filtered = data
    
    for key, value in filters.items():
        if value is not None:
            filtered = [item for item in filtered if str(item.get(key, "")).lower() == str(value).lower()]
    
    return filtered

def search_data(data: List[Dict[str, Any]], query: str, fields: List[str]) -> List[Dict[str, Any]]:
    """Search data in specified fields"""
    if not query:
        return data
    
    query_lower = query.lower()
    results = []
    
    for item in data:
        for field in fields:
            if field in item and query_lower in str(item[field]).lower():
                results.append(item)
                break
    
    return results

def sort_data(data: List[Dict[str, Any]], sort_by: str, order: str = "asc") -> List[Dict[str, Any]]:
    """Sort data by a specific field"""
    if not sort_by or sort_by not in data[0] if data else True:
        return data
    
    reverse = order.lower() == "desc"
    return sorted(data, key=lambda x: x.get(sort_by, ""), reverse=reverse)