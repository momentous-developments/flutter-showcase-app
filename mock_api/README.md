# Flutter Demo Mock API Server

A comprehensive mock API server built with FastAPI for the Flutter demo application. This server provides realistic endpoints for all major features including authentication, e-commerce, chat, email, calendar, and more.

## Features

- **FastAPI** framework with automatic API documentation
- **CORS enabled** for Flutter web development
- **WebSocket support** for real-time chat
- **Realistic features**:
  - Pagination with limit/offset
  - Filtering by various fields
  - Sorting (ascending/descending)
  - Search functionality
  - Realistic response delays (100-500ms)
  - Error simulation (5% chance of 500 errors)
- **Authentication** with JWT tokens
- **File upload** support
- **Comprehensive endpoints** for all modules

## Quick Start

### Using the startup script (recommended):
```bash
./run_server.sh
```

### Manual setup:
```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the server
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

## API Documentation

Once the server is running, visit:
- **Interactive API docs (Swagger UI)**: http://localhost:8000/docs
- **Alternative API docs (ReDoc)**: http://localhost:8000/redoc

## Available Endpoints

### Authentication (`/api/auth`)
- `POST /api/auth/login` - Login with email/password
- `POST /api/auth/register` - Register new user
- `POST /api/auth/logout` - Logout current user
- `POST /api/auth/refresh` - Refresh access token
- `GET /api/auth/me` - Get current user info
- `PUT /api/auth/me` - Update current user
- `POST /api/auth/change-password` - Change password

### Academy (`/api/academy`)
- `GET /api/academy/courses` - List courses with filters
- `GET /api/academy/courses/{id}` - Get course details
- `GET /api/academy/courses/{id}/curriculum` - Get course curriculum
- `POST /api/academy/courses/{id}/enroll` - Enroll in course
- `GET /api/academy/my-courses` - Get enrolled courses
- `PUT /api/academy/courses/{id}/progress` - Update progress
- `GET /api/academy/instructors` - List instructors
- `GET /api/academy/categories` - List categories
- `POST /api/academy/courses/{id}/review` - Add course review

### E-commerce (`/api/ecommerce`)
- `GET /api/ecommerce/products` - List products
- `GET /api/ecommerce/products/{id}` - Get product details
- `GET /api/ecommerce/products/{id}/reviews` - Get product reviews
- `GET /api/ecommerce/cart` - Get shopping cart
- `POST /api/ecommerce/cart/add` - Add to cart
- `PUT /api/ecommerce/cart/update/{id}` - Update cart item
- `DELETE /api/ecommerce/cart/remove/{id}` - Remove from cart
- `POST /api/ecommerce/checkout` - Checkout order
- `GET /api/ecommerce/orders` - List orders
- `GET /api/ecommerce/categories` - List categories
- `GET /api/ecommerce/brands` - List brands

### Email (`/api/email`)
- `GET /api/email/messages` - List emails
- `GET /api/email/messages/{id}` - Get email details
- `POST /api/email/compose` - Send new email
- `PUT /api/email/messages/{id}` - Update email (read/star/folder)
- `DELETE /api/email/messages/{id}` - Delete email
- `POST /api/email/messages/bulk-action` - Bulk operations
- `GET /api/email/folders` - Get folders with counts
- `POST /api/email/messages/{id}/reply` - Reply to email
- `POST /api/email/messages/{id}/forward` - Forward email

### Chat (`/api/chat`)
- `GET /api/chat/conversations` - List conversations
- `GET /api/chat/conversations/{id}` - Get conversation
- `GET /api/chat/conversations/{id}/messages` - Get messages
- `POST /api/chat/conversations` - Create conversation
- `POST /api/chat/conversations/{id}/messages` - Send message
- `DELETE /api/chat/conversations/{id}` - Delete conversation
- `WebSocket /api/chat/ws/{user_id}` - Real-time chat
- `GET /api/chat/users/online` - Get online users

### Calendar (`/api/calendar`)
- `GET /api/calendar/events` - List events
- `GET /api/calendar/events/{id}` - Get event details
- `POST /api/calendar/events` - Create event
- `PUT /api/calendar/events/{id}` - Update event
- `DELETE /api/calendar/events/{id}` - Delete event
- `GET /api/calendar/events/month/{year}/{month}` - Get month view
- `GET /api/calendar/events/week/{year}/{week}` - Get week view
- `GET /api/calendar/events/upcoming` - Get upcoming events
- `POST /api/calendar/events/{id}/rsvp` - RSVP to event

### Invoice (`/api/invoice`)
- `GET /api/invoice/invoices` - List invoices
- `GET /api/invoice/invoices/{id}` - Get invoice details
- `POST /api/invoice/invoices` - Create invoice
- `PUT /api/invoice/invoices/{id}` - Update invoice
- `POST /api/invoice/invoices/{id}/send` - Send invoice
- `POST /api/invoice/invoices/{id}/payment` - Record payment
- `DELETE /api/invoice/invoices/{id}` - Delete invoice
- `GET /api/invoice/invoices/{id}/download` - Download PDF/HTML
- `GET /api/invoice/clients` - List clients
- `POST /api/invoice/clients` - Create client
- `GET /api/invoice/dashboard/stats` - Get statistics

### Kanban (`/api/kanban`)
- `GET /api/kanban/boards` - List boards
- `GET /api/kanban/boards/{id}` - Get board with columns/tasks
- `POST /api/kanban/boards` - Create board
- `PUT /api/kanban/boards/{id}` - Update board
- `DELETE /api/kanban/boards/{id}` - Delete board
- `POST /api/kanban/boards/{id}/columns` - Create column
- `PUT /api/kanban/columns/{id}` - Update column
- `DELETE /api/kanban/columns/{id}` - Delete column
- `POST /api/kanban/tasks` - Create task
- `PUT /api/kanban/tasks/{id}` - Update task
- `DELETE /api/kanban/tasks/{id}` - Delete task
- `POST /api/kanban/tasks/{id}/move` - Move task
- `POST /api/kanban/tasks/{id}/comment` - Add comment

### Logistics (`/api/logistics`)
- `GET /api/logistics/fleet` - List vehicles
- `GET /api/logistics/fleet/{id}` - Get vehicle details
- `PUT /api/logistics/fleet/{id}` - Update vehicle
- `GET /api/logistics/fleet/{id}/location` - Get real-time location
- `GET /api/logistics/deliveries` - List deliveries
- `GET /api/logistics/deliveries/{id}` - Get delivery details
- `GET /api/logistics/deliveries/track/{tracking}` - Track delivery
- `POST /api/logistics/deliveries` - Create delivery
- `PUT /api/logistics/deliveries/{id}` - Update delivery
- `POST /api/logistics/deliveries/{id}/assign` - Assign to vehicle
- `GET /api/logistics/drivers` - List drivers
- `GET /api/logistics/analytics/dashboard` - Get dashboard stats

### Users (`/api/users`)
- `GET /api/users/profile` - Get current user profile
- `PUT /api/users/profile` - Update profile
- `POST /api/users/profile/avatar` - Upload avatar
- `GET /api/users/settings` - Get user settings
- `PUT /api/users/settings` - Update settings
- `GET /api/users/permissions` - Get permissions
- `GET /api/users/list` - List all users (admin)
- `GET /api/users/{id}` - Get user details
- `PUT /api/users/{id}/role` - Update user role (admin)
- `DELETE /api/users/{id}` - Delete user (admin)
- `GET /api/users/activity/recent` - Get recent activity
- `GET /api/users/stats` - Get user statistics
- `POST /api/users/export-data` - Export user data

### Analytics (`/api/analytics`)
- `GET /api/analytics/dashboard` - Get dashboard data

## Default Credentials

- **Admin**: email: `admin@example.com`, password: `admin123`
- **User**: email: `user@example.com`, password: `user123`

## Development

### Adding New Endpoints

1. Create a new module in `endpoints/`
2. Define your router and endpoints
3. Import and include the router in `main.py`

### Modifying Mock Data

Mock data is generated in the `utils/__init__.py` file and individual endpoint modules. You can modify the generation functions to customize the data.

### Error Simulation

The server simulates random 500 errors (5% chance) to help test error handling in your Flutter app. You can adjust this in `main.py`.

## Testing with Flutter

Configure your Flutter app to point to `http://localhost:8000` for API calls. For Flutter web running on a different port, CORS is already configured to allow all origins (update for production).

Example Flutter code:
```dart
final apiUrl = 'http://localhost:8000/api';
final response = await http.get(Uri.parse('$apiUrl/academy/courses'));
```

## Production Considerations

Before deploying to production:

1. Change the `SECRET_KEY` in `utils/__init__.py`
2. Update CORS origins in `main.py` to specific domains
3. Remove error simulation middleware
4. Implement proper database instead of in-memory storage
5. Add proper logging and monitoring
6. Implement rate limiting
7. Use environment variables for configuration

## Troubleshooting

- **Port already in use**: Change the port in `run_server.sh` or kill the process using port 8000
- **Import errors**: Make sure you're in the virtual environment
- **CORS errors**: Check that the Flutter app URL is allowed in CORS settings