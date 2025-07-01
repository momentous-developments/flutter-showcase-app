from fastapi import APIRouter, Query, HTTPException, Depends
from typing import Optional, List
from datetime import datetime, timedelta
import random

from models import (
    Product, ProductStatus, Order, OrderStatus,
    PaginatedResponse, BaseResponse
)
from utils import (
    generate_mock_products, paginate_data, filter_data,
    search_data, sort_data
)
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_products = generate_mock_products()
mock_orders = []
mock_cart = {}
mock_customers = []
mock_reviews = []

@router.get("/products", response_model=PaginatedResponse)
async def get_products(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    category: Optional[str] = None,
    brand: Optional[str] = None,
    min_price: Optional[float] = Query(None, ge=0),
    max_price: Optional[float] = None,
    status: Optional[ProductStatus] = None,
    min_rating: Optional[float] = Query(None, ge=0, le=5),
    search: Optional[str] = None,
    sort_by: Optional[str] = Query(None, regex="^(name|price|rating|created_at)$"),
    order: Optional[str] = Query("asc", regex="^(asc|desc)$")
):
    """Get all products with filtering, sorting, and pagination"""
    products = mock_products.copy()
    
    # Apply filters
    if category:
        products = [p for p in products if p["category"].lower() == category.lower()]
    if brand:
        products = [p for p in products if p["brand"].lower() == brand.lower()]
    if min_price is not None:
        products = [p for p in products if p["price"] >= min_price]
    if max_price is not None:
        products = [p for p in products if p["price"] <= max_price]
    if status:
        products = [p for p in products if p["status"] == status]
    if min_rating:
        products = [p for p in products if p["rating"] >= min_rating]
    
    # Apply search
    if search:
        products = search_data(products, search, ["name", "description", "category", "brand"])
    
    # Apply sorting
    if sort_by:
        products = sort_data(products, sort_by, order)
    
    # Apply pagination
    result = paginate_data(products, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/products/{product_id}", response_model=Product)
async def get_product(product_id: int):
    """Get a specific product by ID"""
    product = next((p for p in mock_products if p["id"] == product_id), None)
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    return product

@router.get("/products/{product_id}/reviews")
async def get_product_reviews(
    product_id: int,
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0)
):
    """Get reviews for a specific product"""
    product = next((p for p in mock_products if p["id"] == product_id), None)
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    
    # Generate mock reviews if not exists
    product_reviews = [r for r in mock_reviews if r["product_id"] == product_id]
    
    if not product_reviews:
        # Generate some mock reviews
        for i in range(random.randint(5, 20)):
            mock_reviews.append({
                "id": len(mock_reviews) + 1,
                "product_id": product_id,
                "user_id": random.randint(1, 100),
                "user_name": f"User {random.randint(1, 100)}",
                "user_avatar": f"/images/avatars/{random.randint(1, 8)}.png",
                "rating": random.randint(3, 5),
                "title": random.choice(["Great product!", "Good value", "Satisfied", "Excellent quality"]),
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "helpful_count": random.randint(0, 50),
                "created_at": (datetime.now() - timedelta(days=random.randint(1, 180))).isoformat()
            })
        product_reviews = [r for r in mock_reviews if r["product_id"] == product_id]
    
    # Apply pagination
    result = paginate_data(product_reviews, limit, offset)
    
    return result

@router.get("/cart")
async def get_cart(current_user: dict = Depends(get_current_user)):
    """Get current user's shopping cart"""
    user_cart = mock_cart.get(current_user["id"], {"items": [], "total": 0})
    
    # Calculate totals
    subtotal = sum(item["price"] * item["quantity"] for item in user_cart["items"])
    tax = subtotal * 0.1  # 10% tax
    shipping = 10 if subtotal < 50 else 0  # Free shipping over $50
    
    return {
        "items": user_cart["items"],
        "subtotal": round(subtotal, 2),
        "tax": round(tax, 2),
        "shipping": shipping,
        "total": round(subtotal + tax + shipping, 2),
        "items_count": sum(item["quantity"] for item in user_cart["items"])
    }

@router.post("/cart/add", response_model=BaseResponse)
async def add_to_cart(
    product_id: int,
    quantity: int = 1,
    current_user: dict = Depends(get_current_user)
):
    """Add a product to the shopping cart"""
    product = next((p for p in mock_products if p["id"] == product_id), None)
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    
    if product["status"] == "out_of_stock":
        raise HTTPException(status_code=400, detail="Product is out of stock")
    
    if quantity > product["stock"]:
        raise HTTPException(status_code=400, detail="Insufficient stock")
    
    # Initialize user cart if not exists
    if current_user["id"] not in mock_cart:
        mock_cart[current_user["id"]] = {"items": []}
    
    user_cart = mock_cart[current_user["id"]]
    
    # Check if product already in cart
    existing_item = next((item for item in user_cart["items"] if item["product_id"] == product_id), None)
    
    if existing_item:
        # Update quantity
        new_quantity = existing_item["quantity"] + quantity
        if new_quantity > product["stock"]:
            raise HTTPException(status_code=400, detail="Insufficient stock")
        existing_item["quantity"] = new_quantity
    else:
        # Add new item
        user_cart["items"].append({
            "product_id": product_id,
            "name": product["name"],
            "price": product["discount_price"] or product["price"],
            "image": product["images"][0] if product["images"] else None,
            "quantity": quantity
        })
    
    return BaseResponse(success=True, message="Product added to cart")

@router.put("/cart/update/{product_id}", response_model=BaseResponse)
async def update_cart_item(
    product_id: int,
    quantity: int,
    current_user: dict = Depends(get_current_user)
):
    """Update quantity of a cart item"""
    if current_user["id"] not in mock_cart:
        raise HTTPException(status_code=404, detail="Cart not found")
    
    user_cart = mock_cart[current_user["id"]]
    item = next((item for item in user_cart["items"] if item["product_id"] == product_id), None)
    
    if not item:
        raise HTTPException(status_code=404, detail="Item not found in cart")
    
    if quantity <= 0:
        # Remove item
        user_cart["items"] = [i for i in user_cart["items"] if i["product_id"] != product_id]
    else:
        # Check stock
        product = next((p for p in mock_products if p["id"] == product_id), None)
        if product and quantity > product["stock"]:
            raise HTTPException(status_code=400, detail="Insufficient stock")
        item["quantity"] = quantity
    
    return BaseResponse(success=True, message="Cart updated")

@router.delete("/cart/remove/{product_id}", response_model=BaseResponse)
async def remove_from_cart(
    product_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Remove an item from the cart"""
    if current_user["id"] not in mock_cart:
        raise HTTPException(status_code=404, detail="Cart not found")
    
    user_cart = mock_cart[current_user["id"]]
    user_cart["items"] = [i for i in user_cart["items"] if i["product_id"] != product_id]
    
    return BaseResponse(success=True, message="Item removed from cart")

@router.delete("/cart/clear", response_model=BaseResponse)
async def clear_cart(current_user: dict = Depends(get_current_user)):
    """Clear all items from the cart"""
    if current_user["id"] in mock_cart:
        mock_cart[current_user["id"]] = {"items": []}
    
    return BaseResponse(success=True, message="Cart cleared")

@router.post("/checkout", response_model=Order)
async def checkout(
    payment_method: str,
    shipping_address: dict,
    current_user: dict = Depends(get_current_user)
):
    """Checkout and create an order"""
    if current_user["id"] not in mock_cart or not mock_cart[current_user["id"]]["items"]:
        raise HTTPException(status_code=400, detail="Cart is empty")
    
    user_cart = mock_cart[current_user["id"]]
    
    # Calculate totals
    subtotal = sum(item["price"] * item["quantity"] for item in user_cart["items"])
    tax = subtotal * 0.1
    shipping = 10 if subtotal < 50 else 0
    total = subtotal + tax + shipping
    
    # Create order
    new_order = {
        "id": len(mock_orders) + 1,
        "order_number": f"ORD-{datetime.now().strftime('%Y%m%d')}-{len(mock_orders) + 1:04d}",
        "customer_id": current_user["id"],
        "customer_name": current_user["full_name"],
        "items": user_cart["items"].copy(),
        "subtotal": round(subtotal, 2),
        "tax": round(tax, 2),
        "shipping": shipping,
        "total_amount": round(total, 2),
        "status": "pending",
        "payment_method": payment_method,
        "shipping_address": shipping_address,
        "created_at": datetime.now(),
        "updated_at": datetime.now()
    }
    
    mock_orders.append(new_order)
    
    # Clear cart
    mock_cart[current_user["id"]] = {"items": []}
    
    # Update product stock
    for item in new_order["items"]:
        product_index = next((i for i, p in enumerate(mock_products) if p["id"] == item["product_id"]), None)
        if product_index is not None:
            mock_products[product_index]["stock"] -= item["quantity"]
            if mock_products[product_index]["stock"] <= 0:
                mock_products[product_index]["status"] = "out_of_stock"
    
    return Order(**new_order)

@router.get("/orders", response_model=PaginatedResponse)
async def get_orders(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    status: Optional[OrderStatus] = None,
    sort_by: Optional[str] = Query("created_at", regex="^(created_at|total_amount|order_number)$"),
    order: Optional[str] = Query("desc", regex="^(asc|desc)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get current user's orders"""
    user_orders = [o for o in mock_orders if o["customer_id"] == current_user["id"]]
    
    # Apply filters
    if status:
        user_orders = [o for o in user_orders if o["status"] == status]
    
    # Apply sorting
    if sort_by:
        user_orders = sort_data(user_orders, sort_by, order)
    
    # Apply pagination
    result = paginate_data(user_orders, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/orders/{order_id}", response_model=Order)
async def get_order(
    order_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific order by ID"""
    order = next((o for o in mock_orders if o["id"] == order_id), None)
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    
    # Check if order belongs to user
    if order["customer_id"] != current_user["id"] and current_user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Access denied")
    
    return order

@router.get("/categories")
async def get_categories():
    """Get all product categories"""
    categories = {}
    
    for product in mock_products:
        category = product["category"]
        if category not in categories:
            categories[category] = {
                "name": category,
                "slug": category.lower().replace(" & ", "-").replace(" ", "-"),
                "products_count": 0,
                "image": f"/images/categories/{category.lower().replace(' ', '-')}.jpg"
            }
        categories[category]["products_count"] += 1
    
    return {
        "categories": list(categories.values()),
        "total": len(categories)
    }

@router.get("/brands")
async def get_brands():
    """Get all product brands"""
    brands = {}
    
    for product in mock_products:
        brand = product["brand"]
        if brand not in brands:
            brands[brand] = {
                "name": brand,
                "slug": brand.lower().replace(" ", "-"),
                "products_count": 0,
                "logo": f"/images/brands/{brand.lower().replace(' ', '-')}.png"
            }
        brands[brand]["products_count"] += 1
    
    return {
        "brands": list(brands.values()),
        "total": len(brands)
    }

@router.post("/products/{product_id}/review", response_model=BaseResponse)
async def add_product_review(
    product_id: int,
    rating: int = Query(..., ge=1, le=5),
    title: str = "",
    comment: str = "",
    current_user: dict = Depends(get_current_user)
):
    """Add a review for a product"""
    product = next((p for p in mock_products if p["id"] == product_id), None)
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    
    # Check if user has purchased this product
    user_orders = [o for o in mock_orders if o["customer_id"] == current_user["id"]]
    has_purchased = any(
        any(item["product_id"] == product_id for item in order["items"])
        for order in user_orders
    )
    
    if not has_purchased:
        raise HTTPException(status_code=403, detail="Must purchase product to review")
    
    # Add review
    mock_reviews.append({
        "id": len(mock_reviews) + 1,
        "product_id": product_id,
        "user_id": current_user["id"],
        "user_name": current_user["full_name"],
        "user_avatar": current_user["avatar"],
        "rating": rating,
        "title": title,
        "comment": comment,
        "helpful_count": 0,
        "created_at": datetime.now().isoformat()
    })
    
    # Update product rating
    product_reviews = [r for r in mock_reviews if r["product_id"] == product_id]
    if product_reviews:
        avg_rating = sum(r["rating"] for r in product_reviews) / len(product_reviews)
        product_index = next((i for i, p in enumerate(mock_products) if p["id"] == product_id), None)
        if product_index is not None:
            mock_products[product_index]["rating"] = round(avg_rating, 1)
            mock_products[product_index]["reviews_count"] = len(product_reviews)
    
    return BaseResponse(success=True, message="Review added successfully")