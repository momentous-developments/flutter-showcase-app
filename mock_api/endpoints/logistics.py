from fastapi import APIRouter, Query, HTTPException, Depends
from typing import Optional, List
from datetime import datetime, timedelta
import random

from models import (
    Vehicle, VehicleStatus, Delivery, DeliveryStatus,
    BaseResponse, PaginatedResponse
)
from utils import paginate_data, search_data, sort_data
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_vehicles = []
mock_deliveries = []
mock_drivers = []

# Initialize mock data
def init_mock_data():
    # Generate drivers
    driver_names = ["John Smith", "Mike Johnson", "Sarah Davis", "Tom Wilson", "Emma Brown"]
    for i in range(1, 6):
        mock_drivers.append({
            "id": i,
            "name": driver_names[i-1],
            "license_number": f"DL-{random.randint(100000, 999999)}",
            "phone": f"+1-555-{random.randint(1000, 9999)}",
            "status": random.choice(["available", "on_duty", "off_duty"]),
            "avatar": f"/images/avatars/{i}.png"
        })
    
    # Generate vehicles
    vehicle_types = ["Van", "Truck", "Motorcycle", "Bicycle", "Drone"]
    for i in range(1, 21):
        vehicle = {
            "id": i,
            "vehicle_number": f"VH-{i:04d}",
            "type": random.choice(vehicle_types),
            "capacity": random.randint(50, 500),  # kg
            "driver_id": random.choice([None, random.randint(1, 5)]),
            "driver_name": None,
            "status": random.choice(list(VehicleStatus)),
            "current_location": {
                "lat": 40.7128 + random.uniform(-0.1, 0.1),
                "lng": -74.0060 + random.uniform(-0.1, 0.1)
            },
            "last_updated": datetime.now() - timedelta(minutes=random.randint(0, 120))
        }
        
        # Set driver name if assigned
        if vehicle["driver_id"]:
            driver = next((d for d in mock_drivers if d["id"] == vehicle["driver_id"]), None)
            if driver:
                vehicle["driver_name"] = driver["name"]
        
        mock_vehicles.append(vehicle)
    
    # Generate deliveries
    cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego"]
    for i in range(1, 101):
        pickup_city = random.choice(cities)
        delivery_city = random.choice([c for c in cities if c != pickup_city])
        
        created_at = datetime.now() - timedelta(days=random.randint(0, 30))
        estimated_delivery = created_at + timedelta(hours=random.randint(2, 48))
        
        delivery = {
            "id": i,
            "tracking_number": f"TRK-{datetime.now().strftime('%Y%m')}-{i:06d}",
            "sender_name": f"Sender {random.randint(1, 50)}",
            "sender_address": {
                "street": f"{random.randint(100, 999)} Main St",
                "city": pickup_city,
                "state": "NY",
                "zip": f"{random.randint(10000, 99999)}",
                "country": "USA"
            },
            "recipient_name": f"Recipient {random.randint(1, 50)}",
            "recipient_address": {
                "street": f"{random.randint(100, 999)} Oak Ave",
                "city": delivery_city,
                "state": "CA",
                "zip": f"{random.randint(10000, 99999)}",
                "country": "USA"
            },
            "vehicle_id": random.choice([None, random.randint(1, 20)]),
            "status": random.choice(list(DeliveryStatus)),
            "estimated_delivery": estimated_delivery,
            "actual_delivery": None,
            "created_at": created_at,
            "updated_at": created_at + timedelta(hours=random.randint(0, 24)),
            "weight": random.randint(1, 100),  # kg
            "dimensions": {
                "length": random.randint(10, 100),
                "width": random.randint(10, 100),
                "height": random.randint(10, 100)
            },
            "special_instructions": random.choice([None, "Fragile", "Keep upright", "Handle with care"])
        }
        
        # Set actual delivery if delivered
        if delivery["status"] == DeliveryStatus.delivered:
            delivery["actual_delivery"] = estimated_delivery + timedelta(hours=random.randint(-12, 12))
        
        mock_deliveries.append(delivery)

init_mock_data()

@router.get("/fleet", response_model=PaginatedResponse)
async def get_vehicles(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    status: Optional[VehicleStatus] = None,
    type: Optional[str] = None,
    has_driver: Optional[bool] = None,
    search: Optional[str] = None,
    sort_by: Optional[str] = Query("last_updated", regex="^(vehicle_number|type|status|last_updated)$"),
    order: Optional[str] = Query("desc", regex="^(asc|desc)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get all vehicles in the fleet"""
    vehicles = mock_vehicles.copy()
    
    # Apply filters
    if status:
        vehicles = [v for v in vehicles if v["status"] == status]
    if type:
        vehicles = [v for v in vehicles if v["type"].lower() == type.lower()]
    if has_driver is not None:
        if has_driver:
            vehicles = [v for v in vehicles if v["driver_id"] is not None]
        else:
            vehicles = [v for v in vehicles if v["driver_id"] is None]
    
    # Apply search
    if search:
        vehicles = search_data(vehicles, search, ["vehicle_number", "type", "driver_name"])
    
    # Apply sorting
    if sort_by:
        vehicles = sort_data(vehicles, sort_by, order)
    
    # Apply pagination
    result = paginate_data(vehicles, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/fleet/{vehicle_id}", response_model=Vehicle)
async def get_vehicle(
    vehicle_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get details of a specific vehicle"""
    vehicle = next((v for v in mock_vehicles if v["id"] == vehicle_id), None)
    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    return vehicle

@router.put("/fleet/{vehicle_id}", response_model=Vehicle)
async def update_vehicle(
    vehicle_id: int,
    status: Optional[VehicleStatus] = None,
    driver_id: Optional[int] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update vehicle details"""
    vehicle = next((v for v in mock_vehicles if v["id"] == vehicle_id), None)
    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    
    vehicle_index = next((i for i, v in enumerate(mock_vehicles) if v["id"] == vehicle_id), None)
    if vehicle_index is not None:
        if status:
            mock_vehicles[vehicle_index]["status"] = status
        
        if driver_id is not None:
            if driver_id == 0:
                # Unassign driver
                mock_vehicles[vehicle_index]["driver_id"] = None
                mock_vehicles[vehicle_index]["driver_name"] = None
            else:
                # Assign driver
                driver = next((d for d in mock_drivers if d["id"] == driver_id), None)
                if not driver:
                    raise HTTPException(status_code=404, detail="Driver not found")
                mock_vehicles[vehicle_index]["driver_id"] = driver_id
                mock_vehicles[vehicle_index]["driver_name"] = driver["name"]
        
        mock_vehicles[vehicle_index]["last_updated"] = datetime.now()
        
        return Vehicle(**mock_vehicles[vehicle_index])
    
    raise HTTPException(status_code=500, detail="Failed to update vehicle")

@router.get("/fleet/{vehicle_id}/location")
async def get_vehicle_location(
    vehicle_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get real-time location of a vehicle"""
    vehicle = next((v for v in mock_vehicles if v["id"] == vehicle_id), None)
    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    
    # Simulate movement
    vehicle["current_location"]["lat"] += random.uniform(-0.001, 0.001)
    vehicle["current_location"]["lng"] += random.uniform(-0.001, 0.001)
    vehicle["last_updated"] = datetime.now()
    
    return {
        "vehicle_id": vehicle_id,
        "location": vehicle["current_location"],
        "speed": random.randint(0, 60) if vehicle["status"] == VehicleStatus.in_transit else 0,
        "heading": random.randint(0, 359),
        "last_updated": vehicle["last_updated"],
        "status": vehicle["status"]
    }

@router.get("/deliveries", response_model=PaginatedResponse)
async def get_deliveries(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    status: Optional[DeliveryStatus] = None,
    vehicle_id: Optional[int] = None,
    start_date: Optional[datetime] = None,
    end_date: Optional[datetime] = None,
    search: Optional[str] = None,
    sort_by: Optional[str] = Query("created_at", regex="^(tracking_number|status|created_at|estimated_delivery)$"),
    order: Optional[str] = Query("desc", regex="^(asc|desc)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get all deliveries"""
    deliveries = mock_deliveries.copy()
    
    # Apply filters
    if status:
        deliveries = [d for d in deliveries if d["status"] == status]
    if vehicle_id:
        deliveries = [d for d in deliveries if d["vehicle_id"] == vehicle_id]
    if start_date:
        deliveries = [d for d in deliveries if d["created_at"] >= start_date]
    if end_date:
        deliveries = [d for d in deliveries if d["created_at"] <= end_date]
    
    # Apply search
    if search:
        deliveries = search_data(deliveries, search, ["tracking_number", "sender_name", "recipient_name"])
    
    # Apply sorting
    if sort_by:
        deliveries = sort_data(deliveries, sort_by, order)
    
    # Apply pagination
    result = paginate_data(deliveries, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/deliveries/{delivery_id}", response_model=Delivery)
async def get_delivery(
    delivery_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get details of a specific delivery"""
    delivery = next((d for d in mock_deliveries if d["id"] == delivery_id), None)
    if not delivery:
        raise HTTPException(status_code=404, detail="Delivery not found")
    return delivery

@router.get("/deliveries/track/{tracking_number}")
async def track_delivery(tracking_number: str):
    """Track a delivery by tracking number (public endpoint)"""
    delivery = next((d for d in mock_deliveries if d["tracking_number"] == tracking_number), None)
    if not delivery:
        raise HTTPException(status_code=404, detail="Delivery not found")
    
    # Generate tracking history
    tracking_history = []
    created_at = delivery["created_at"]
    
    # Add events based on status
    tracking_history.append({
        "timestamp": created_at.isoformat(),
        "status": "created",
        "description": "Delivery order created",
        "location": delivery["sender_address"]["city"]
    })
    
    if delivery["status"] in [DeliveryStatus.picked_up, DeliveryStatus.in_transit, DeliveryStatus.delivered]:
        tracking_history.append({
            "timestamp": (created_at + timedelta(hours=1)).isoformat(),
            "status": "picked_up",
            "description": "Package picked up from sender",
            "location": delivery["sender_address"]["city"]
        })
    
    if delivery["status"] in [DeliveryStatus.in_transit, DeliveryStatus.delivered]:
        tracking_history.append({
            "timestamp": (created_at + timedelta(hours=6)).isoformat(),
            "status": "in_transit",
            "description": "Package in transit",
            "location": "Distribution Center"
        })
    
    if delivery["status"] == DeliveryStatus.delivered:
        tracking_history.append({
            "timestamp": delivery["actual_delivery"].isoformat(),
            "status": "delivered",
            "description": "Package delivered successfully",
            "location": delivery["recipient_address"]["city"]
        })
    
    return {
        "tracking_number": tracking_number,
        "current_status": delivery["status"],
        "sender": delivery["sender_name"],
        "recipient": delivery["recipient_name"],
        "estimated_delivery": delivery["estimated_delivery"],
        "actual_delivery": delivery["actual_delivery"],
        "tracking_history": tracking_history
    }

@router.post("/deliveries", response_model=Delivery)
async def create_delivery(
    sender_name: str,
    sender_address: dict,
    recipient_name: str,
    recipient_address: dict,
    weight: float,
    dimensions: dict,
    special_instructions: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Create a new delivery"""
    new_delivery = {
        "id": len(mock_deliveries) + 1,
        "tracking_number": f"TRK-{datetime.now().strftime('%Y%m%d')}-{len(mock_deliveries) + 1:06d}",
        "sender_name": sender_name,
        "sender_address": sender_address,
        "recipient_name": recipient_name,
        "recipient_address": recipient_address,
        "vehicle_id": None,
        "status": DeliveryStatus.pending,
        "estimated_delivery": datetime.now() + timedelta(hours=random.randint(24, 72)),
        "actual_delivery": None,
        "created_at": datetime.now(),
        "updated_at": datetime.now(),
        "weight": weight,
        "dimensions": dimensions,
        "special_instructions": special_instructions
    }
    
    mock_deliveries.append(new_delivery)
    
    return Delivery(**new_delivery)

@router.put("/deliveries/{delivery_id}", response_model=Delivery)
async def update_delivery(
    delivery_id: int,
    status: Optional[DeliveryStatus] = None,
    vehicle_id: Optional[int] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update delivery details"""
    delivery = next((d for d in mock_deliveries if d["id"] == delivery_id), None)
    if not delivery:
        raise HTTPException(status_code=404, detail="Delivery not found")
    
    delivery_index = next((i for i, d in enumerate(mock_deliveries) if d["id"] == delivery_id), None)
    if delivery_index is not None:
        if status:
            mock_deliveries[delivery_index]["status"] = status
            if status == DeliveryStatus.delivered:
                mock_deliveries[delivery_index]["actual_delivery"] = datetime.now()
        
        if vehicle_id is not None:
            if vehicle_id == 0:
                # Unassign vehicle
                mock_deliveries[delivery_index]["vehicle_id"] = None
            else:
                # Verify vehicle exists
                vehicle = next((v for v in mock_vehicles if v["id"] == vehicle_id), None)
                if not vehicle:
                    raise HTTPException(status_code=404, detail="Vehicle not found")
                mock_deliveries[delivery_index]["vehicle_id"] = vehicle_id
        
        mock_deliveries[delivery_index]["updated_at"] = datetime.now()
        
        return Delivery(**mock_deliveries[delivery_index])
    
    raise HTTPException(status_code=500, detail="Failed to update delivery")

@router.get("/drivers")
async def get_drivers(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    status: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Get all drivers"""
    drivers = mock_drivers.copy()
    
    # Apply filters
    if status:
        drivers = [d for d in drivers if d["status"] == status]
    
    # Add assigned vehicle info
    for driver in drivers:
        assigned_vehicles = [v for v in mock_vehicles if v["driver_id"] == driver["id"]]
        driver["assigned_vehicles"] = len(assigned_vehicles)
        driver["current_vehicle"] = assigned_vehicles[0]["vehicle_number"] if assigned_vehicles else None
    
    # Apply pagination
    result = paginate_data(drivers, limit, offset)
    
    return result

@router.get("/analytics/dashboard")
async def get_logistics_dashboard(current_user: dict = Depends(get_current_user)):
    """Get logistics dashboard analytics"""
    # Calculate stats
    total_vehicles = len(mock_vehicles)
    available_vehicles = len([v for v in mock_vehicles if v["status"] == VehicleStatus.available])
    in_transit_vehicles = len([v for v in mock_vehicles if v["status"] == VehicleStatus.in_transit])
    
    total_deliveries = len(mock_deliveries)
    pending_deliveries = len([d for d in mock_deliveries if d["status"] == DeliveryStatus.pending])
    in_transit_deliveries = len([d for d in mock_deliveries if d["status"] == DeliveryStatus.in_transit])
    delivered_today = len([
        d for d in mock_deliveries 
        if d["status"] == DeliveryStatus.delivered and
        d["actual_delivery"] and d["actual_delivery"].date() == datetime.now().date()
    ])
    
    # Delivery performance
    on_time_deliveries = 0
    late_deliveries = 0
    for delivery in mock_deliveries:
        if delivery["status"] == DeliveryStatus.delivered and delivery["actual_delivery"]:
            if delivery["actual_delivery"] <= delivery["estimated_delivery"]:
                on_time_deliveries += 1
            else:
                late_deliveries += 1
    
    # Vehicle utilization
    vehicle_utilization = {}
    for vehicle_type in ["Van", "Truck", "Motorcycle", "Bicycle", "Drone"]:
        type_vehicles = [v for v in mock_vehicles if v["type"] == vehicle_type]
        if type_vehicles:
            in_use = len([v for v in type_vehicles if v["status"] == VehicleStatus.in_transit])
            vehicle_utilization[vehicle_type] = {
                "total": len(type_vehicles),
                "in_use": in_use,
                "utilization_rate": round((in_use / len(type_vehicles)) * 100, 1)
            }
    
    return {
        "vehicles": {
            "total": total_vehicles,
            "available": available_vehicles,
            "in_transit": in_transit_vehicles,
            "maintenance": total_vehicles - available_vehicles - in_transit_vehicles
        },
        "deliveries": {
            "total": total_deliveries,
            "pending": pending_deliveries,
            "in_transit": in_transit_deliveries,
            "delivered_today": delivered_today
        },
        "performance": {
            "on_time_rate": round((on_time_deliveries / (on_time_deliveries + late_deliveries)) * 100, 1) if (on_time_deliveries + late_deliveries) > 0 else 0,
            "average_delivery_time": "24.5 hours",  # Mock value
            "deliveries_per_vehicle": round(total_deliveries / total_vehicles, 1) if total_vehicles > 0 else 0
        },
        "vehicle_utilization": vehicle_utilization
    }

@router.post("/deliveries/{delivery_id}/assign", response_model=BaseResponse)
async def assign_delivery_to_vehicle(
    delivery_id: int,
    vehicle_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Assign a delivery to a vehicle"""
    delivery = next((d for d in mock_deliveries if d["id"] == delivery_id), None)
    if not delivery:
        raise HTTPException(status_code=404, detail="Delivery not found")
    
    vehicle = next((v for v in mock_vehicles if v["id"] == vehicle_id), None)
    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    
    if vehicle["status"] != VehicleStatus.available:
        raise HTTPException(status_code=400, detail="Vehicle is not available")
    
    # Assign delivery to vehicle
    delivery_index = next((i for i, d in enumerate(mock_deliveries) if d["id"] == delivery_id), None)
    if delivery_index is not None:
        mock_deliveries[delivery_index]["vehicle_id"] = vehicle_id
        mock_deliveries[delivery_index]["status"] = DeliveryStatus.picked_up
        mock_deliveries[delivery_index]["updated_at"] = datetime.now()
        
        # Update vehicle status
        vehicle_index = next((i for i, v in enumerate(mock_vehicles) if v["id"] == vehicle_id), None)
        if vehicle_index is not None:
            mock_vehicles[vehicle_index]["status"] = VehicleStatus.in_transit
            mock_vehicles[vehicle_index]["last_updated"] = datetime.now()
        
        return BaseResponse(success=True, message="Delivery assigned successfully")
    
    raise HTTPException(status_code=500, detail="Failed to assign delivery")