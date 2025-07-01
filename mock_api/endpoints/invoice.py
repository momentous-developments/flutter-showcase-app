from fastapi import APIRouter, Query, HTTPException, Depends, Response
from typing import Optional, List
from datetime import datetime, timedelta
import random
from io import BytesIO

from models import (
    Invoice, InvoiceStatus, BaseResponse, PaginatedResponse
)
from utils import generate_mock_invoices, paginate_data, search_data, sort_data
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_invoices = generate_mock_invoices()
mock_clients = []

# Generate some mock clients
def init_mock_clients():
    companies = [
        "ABC Corporation", "XYZ Industries", "Tech Solutions Inc",
        "Global Services Ltd", "Local Business Co", "StartUp Ventures",
        "Enterprise Systems", "Digital Agency", "Consulting Group",
        "Manufacturing Corp"
    ]
    
    for i in range(1, 11):
        mock_clients.append({
            "id": i,
            "name": companies[i-1],
            "email": f"billing@{companies[i-1].lower().replace(' ', '')}.com",
            "phone": f"+1-555-{random.randint(1000, 9999)}",
            "address": {
                "street": f"{random.randint(100, 999)} Main Street",
                "city": random.choice(["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"]),
                "state": random.choice(["NY", "CA", "IL", "TX", "AZ"]),
                "zip": f"{random.randint(10000, 99999)}",
                "country": "USA"
            },
            "tax_id": f"TAX-{random.randint(100000, 999999)}",
            "created_at": datetime.now() - timedelta(days=random.randint(30, 365))
        })

init_mock_clients()

@router.get("/invoices", response_model=PaginatedResponse)
async def get_invoices(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    status: Optional[InvoiceStatus] = None,
    client_id: Optional[int] = None,
    min_amount: Optional[float] = None,
    max_amount: Optional[float] = None,
    start_date: Optional[datetime] = None,
    end_date: Optional[datetime] = None,
    search: Optional[str] = None,
    sort_by: Optional[str] = Query("created_at", regex="^(invoice_number|total|created_at|due_date)$"),
    order: Optional[str] = Query("desc", regex="^(asc|desc)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get invoices with filtering, sorting, and pagination"""
    invoices = mock_invoices.copy()
    
    # Apply filters
    if status:
        invoices = [i for i in invoices if i["status"] == status]
    if client_id:
        invoices = [i for i in invoices if i["client_id"] == client_id]
    if min_amount is not None:
        invoices = [i for i in invoices if i["total"] >= min_amount]
    if max_amount is not None:
        invoices = [i for i in invoices if i["total"] <= max_amount]
    if start_date:
        invoices = [i for i in invoices if datetime.fromisoformat(i["created_at"]) >= start_date]
    if end_date:
        invoices = [i for i in invoices if datetime.fromisoformat(i["created_at"]) <= end_date]
    
    # Apply search
    if search:
        invoices = search_data(invoices, search, ["invoice_number", "client_name", "client_email"])
    
    # Update overdue status
    now = datetime.now()
    for invoice in invoices:
        if invoice["status"] == "sent" and datetime.fromisoformat(invoice["due_date"]) < now:
            invoice["status"] = "overdue"
    
    # Apply sorting
    if sort_by:
        invoices = sort_data(invoices, sort_by, order)
    
    # Apply pagination
    result = paginate_data(invoices, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/invoices/{invoice_id}", response_model=Invoice)
async def get_invoice(
    invoice_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific invoice by ID"""
    invoice = next((i for i in mock_invoices if i["id"] == invoice_id), None)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    # Update overdue status if needed
    if invoice["status"] == "sent" and datetime.fromisoformat(invoice["due_date"]) < datetime.now():
        invoice["status"] = "overdue"
    
    return invoice

@router.post("/invoices", response_model=Invoice)
async def create_invoice(
    client_id: int,
    items: List[dict],
    due_days: int = 30,
    notes: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Create a new invoice"""
    # Validate client
    client = next((c for c in mock_clients if c["id"] == client_id), None)
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    # Calculate totals
    subtotal = sum(item["quantity"] * item["rate"] for item in items)
    tax_rate = 0.1  # 10% tax
    tax = round(subtotal * tax_rate, 2)
    total = subtotal + tax
    
    # Create invoice
    new_invoice = {
        "id": len(mock_invoices) + 1,
        "invoice_number": f"INV-{datetime.now().strftime('%Y')}-{len(mock_invoices) + 1:04d}",
        "client_id": client_id,
        "client_name": client["name"],
        "client_email": client["email"],
        "items": items,
        "subtotal": round(subtotal, 2),
        "tax": tax,
        "total": round(total, 2),
        "status": "draft",
        "due_date": (datetime.now() + timedelta(days=due_days)).isoformat(),
        "created_at": datetime.now().isoformat(),
        "paid_at": None,
        "notes": notes
    }
    
    mock_invoices.append(new_invoice)
    
    return Invoice(**new_invoice)

@router.put("/invoices/{invoice_id}", response_model=Invoice)
async def update_invoice(
    invoice_id: int,
    items: Optional[List[dict]] = None,
    due_date: Optional[datetime] = None,
    notes: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update an invoice (only if in draft status)"""
    invoice = next((i for i in mock_invoices if i["id"] == invoice_id), None)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    if invoice["status"] != "draft":
        raise HTTPException(status_code=400, detail="Can only edit draft invoices")
    
    invoice_index = next((i for i, inv in enumerate(mock_invoices) if inv["id"] == invoice_id), None)
    if invoice_index is not None:
        # Update items and recalculate if provided
        if items:
            subtotal = sum(item["quantity"] * item["rate"] for item in items)
            tax = round(subtotal * 0.1, 2)
            total = subtotal + tax
            
            mock_invoices[invoice_index]["items"] = items
            mock_invoices[invoice_index]["subtotal"] = round(subtotal, 2)
            mock_invoices[invoice_index]["tax"] = tax
            mock_invoices[invoice_index]["total"] = round(total, 2)
        
        if due_date:
            mock_invoices[invoice_index]["due_date"] = due_date.isoformat()
        
        if notes is not None:
            mock_invoices[invoice_index]["notes"] = notes
        
        return Invoice(**mock_invoices[invoice_index])
    
    raise HTTPException(status_code=500, detail="Failed to update invoice")

@router.post("/invoices/{invoice_id}/send", response_model=BaseResponse)
async def send_invoice(
    invoice_id: int,
    message: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Send an invoice to the client"""
    invoice = next((i for i in mock_invoices if i["id"] == invoice_id), None)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    if invoice["status"] not in ["draft", "sent"]:
        raise HTTPException(status_code=400, detail="Cannot send this invoice")
    
    # Update status
    invoice_index = next((i for i, inv in enumerate(mock_invoices) if inv["id"] == invoice_id), None)
    if invoice_index is not None:
        mock_invoices[invoice_index]["status"] = "sent"
        mock_invoices[invoice_index]["sent_at"] = datetime.now().isoformat()
        
        # TODO: In a real app, send email to client
        
        return BaseResponse(success=True, message="Invoice sent successfully")
    
    raise HTTPException(status_code=500, detail="Failed to send invoice")

@router.post("/invoices/{invoice_id}/payment", response_model=BaseResponse)
async def record_payment(
    invoice_id: int,
    amount: float,
    payment_method: str = "bank_transfer",
    payment_date: Optional[datetime] = None,
    current_user: dict = Depends(get_current_user)
):
    """Record a payment for an invoice"""
    invoice = next((i for i in mock_invoices if i["id"] == invoice_id), None)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    if invoice["status"] == "paid":
        raise HTTPException(status_code=400, detail="Invoice is already paid")
    
    if invoice["status"] == "cancelled":
        raise HTTPException(status_code=400, detail="Cannot record payment for cancelled invoice")
    
    if amount > invoice["total"]:
        raise HTTPException(status_code=400, detail="Payment amount exceeds invoice total")
    
    # Update invoice
    invoice_index = next((i for i, inv in enumerate(mock_invoices) if inv["id"] == invoice_id), None)
    if invoice_index is not None:
        if amount >= invoice["total"]:
            mock_invoices[invoice_index]["status"] = "paid"
            mock_invoices[invoice_index]["paid_at"] = (payment_date or datetime.now()).isoformat()
        else:
            # Partial payment - keep as sent/overdue
            if "payments" not in mock_invoices[invoice_index]:
                mock_invoices[invoice_index]["payments"] = []
            mock_invoices[invoice_index]["payments"].append({
                "amount": amount,
                "method": payment_method,
                "date": (payment_date or datetime.now()).isoformat()
            })
        
        return BaseResponse(success=True, message="Payment recorded successfully")
    
    raise HTTPException(status_code=500, detail="Failed to record payment")

@router.delete("/invoices/{invoice_id}", response_model=BaseResponse)
async def delete_invoice(
    invoice_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Delete an invoice (only if in draft status)"""
    invoice = next((i for i in mock_invoices if i["id"] == invoice_id), None)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    if invoice["status"] != "draft":
        raise HTTPException(status_code=400, detail="Can only delete draft invoices")
    
    # Remove invoice
    mock_invoices[:] = [i for i in mock_invoices if i["id"] != invoice_id]
    
    return BaseResponse(success=True, message="Invoice deleted successfully")

@router.get("/invoices/{invoice_id}/download")
async def download_invoice(
    invoice_id: int,
    format: str = Query("pdf", regex="^(pdf|html)$"),
    current_user: dict = Depends(get_current_user)
):
    """Download invoice as PDF or HTML"""
    invoice = next((i for i in mock_invoices if i["id"] == invoice_id), None)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    if format == "pdf":
        # Mock PDF generation
        pdf_content = f"Mock PDF content for invoice {invoice['invoice_number']}".encode()
        return Response(
            content=pdf_content,
            media_type="application/pdf",
            headers={
                "Content-Disposition": f"attachment; filename=invoice_{invoice['invoice_number']}.pdf"
            }
        )
    else:
        # Generate HTML
        html_content = f"""
        <html>
        <head><title>Invoice {invoice['invoice_number']}</title></head>
        <body>
            <h1>Invoice {invoice['invoice_number']}</h1>
            <p>Client: {invoice['client_name']}</p>
            <p>Total: ${invoice['total']}</p>
            <p>Status: {invoice['status']}</p>
        </body>
        </html>
        """
        return Response(
            content=html_content,
            media_type="text/html",
            headers={
                "Content-Disposition": f"inline; filename=invoice_{invoice['invoice_number']}.html"
            }
        )

@router.get("/clients")
async def get_clients(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    search: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Get all clients"""
    clients = mock_clients.copy()
    
    # Apply search
    if search:
        clients = search_data(clients, search, ["name", "email"])
    
    # Apply pagination
    result = paginate_data(clients, limit, offset)
    
    return result

@router.post("/clients", response_model=dict)
async def create_client(
    name: str,
    email: str,
    phone: Optional[str] = None,
    address: Optional[dict] = None,
    tax_id: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Create a new client"""
    # Check if client already exists
    existing = next((c for c in mock_clients if c["email"] == email), None)
    if existing:
        raise HTTPException(status_code=400, detail="Client with this email already exists")
    
    new_client = {
        "id": len(mock_clients) + 1,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address or {
            "street": "",
            "city": "",
            "state": "",
            "zip": "",
            "country": ""
        },
        "tax_id": tax_id,
        "created_at": datetime.now()
    }
    
    mock_clients.append(new_client)
    
    return new_client

@router.get("/dashboard/stats")
async def get_invoice_stats(
    period: str = Query("month", regex="^(week|month|quarter|year)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get invoice statistics for dashboard"""
    now = datetime.now()
    
    # Calculate period start date
    if period == "week":
        start_date = now - timedelta(days=7)
    elif period == "month":
        start_date = now - timedelta(days=30)
    elif period == "quarter":
        start_date = now - timedelta(days=90)
    else:  # year
        start_date = now - timedelta(days=365)
    
    # Filter invoices by period
    period_invoices = [
        i for i in mock_invoices
        if datetime.fromisoformat(i["created_at"]) >= start_date
    ]
    
    # Calculate stats
    total_invoices = len(period_invoices)
    total_revenue = sum(i["total"] for i in period_invoices if i["status"] == "paid")
    pending_amount = sum(i["total"] for i in period_invoices if i["status"] in ["sent", "overdue"])
    overdue_amount = sum(i["total"] for i in period_invoices if i["status"] == "overdue")
    
    # Status breakdown
    status_breakdown = {}
    for status in InvoiceStatus:
        count = len([i for i in period_invoices if i["status"] == status.value])
        status_breakdown[status.value] = count
    
    # Top clients
    client_totals = {}
    for invoice in period_invoices:
        if invoice["status"] == "paid":
            client_name = invoice["client_name"]
            if client_name not in client_totals:
                client_totals[client_name] = 0
            client_totals[client_name] += invoice["total"]
    
    top_clients = sorted(client_totals.items(), key=lambda x: x[1], reverse=True)[:5]
    
    return {
        "period": period,
        "total_invoices": total_invoices,
        "total_revenue": round(total_revenue, 2),
        "pending_amount": round(pending_amount, 2),
        "overdue_amount": round(overdue_amount, 2),
        "status_breakdown": status_breakdown,
        "top_clients": [
            {"name": name, "total": round(total, 2)}
            for name, total in top_clients
        ],
        "average_invoice_value": round(total_revenue / total_invoices, 2) if total_invoices > 0 else 0
    }