#!/usr/bin/env python3

import requests
import json
import sys
from datetime import datetime

# API base URL
BASE_URL = "http://localhost:8000"

# Test colors for terminal output
class Colors:
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    END = '\033[0m'

def print_test(name, passed):
    """Print test result"""
    if passed:
        print(f"{Colors.GREEN}✓{Colors.END} {name}")
    else:
        print(f"{Colors.RED}✗{Colors.END} {name}")

def test_api():
    """Test the API endpoints"""
    print(f"\n{Colors.BLUE}Testing Flutter Demo Mock API...{Colors.END}\n")
    
    all_passed = True
    
    # Test 1: Check if server is running
    try:
        response = requests.get(f"{BASE_URL}/")
        print_test("Server is running", response.status_code == 200)
    except:
        print(f"{Colors.RED}Error: Server is not running at {BASE_URL}{Colors.END}")
        print("Please start the server with: ./run_server.sh")
        return False
    
    # Test 2: Check API documentation
    try:
        response = requests.get(f"{BASE_URL}/docs")
        print_test("API documentation available", response.status_code == 200)
    except:
        print_test("API documentation available", False)
        all_passed = False
    
    # Test 3: Test authentication
    try:
        # Login
        login_data = {
            "username": "admin@example.com",
            "password": "admin123"
        }
        response = requests.post(
            f"{BASE_URL}/api/auth/login",
            data=login_data
        )
        
        if response.status_code == 200:
            token_data = response.json()
            access_token = token_data.get("access_token")
            print_test("Authentication (login)", bool(access_token))
            
            # Test authenticated endpoint
            headers = {"Authorization": f"Bearer {access_token}"}
            response = requests.get(f"{BASE_URL}/api/auth/me", headers=headers)
            print_test("Authentication (get user)", response.status_code == 200)
        else:
            print_test("Authentication", False)
            all_passed = False
            access_token = None
    except Exception as e:
        print_test("Authentication", False)
        print(f"  Error: {e}")
        all_passed = False
        access_token = None
    
    # Test 4: Test public endpoints
    endpoints_to_test = [
        ("/api/academy/courses", "Academy courses"),
        ("/api/ecommerce/products", "E-commerce products"),
        ("/api/analytics/dashboard", "Analytics dashboard"),
    ]
    
    for endpoint, name in endpoints_to_test:
        try:
            response = requests.get(f"{BASE_URL}{endpoint}")
            print_test(f"{name} endpoint", response.status_code == 200)
            
            # Check response structure
            data = response.json()
            if "data" in data:
                print(f"  - Found {len(data['data'])} items")
        except Exception as e:
            print_test(f"{name} endpoint", False)
            print(f"  Error: {e}")
            all_passed = False
    
    # Test 5: Test authenticated endpoints
    if access_token:
        auth_endpoints = [
            ("/api/users/profile", "User profile"),
            ("/api/email/messages", "Email messages"),
            ("/api/chat/conversations", "Chat conversations"),
            ("/api/calendar/events", "Calendar events"),
        ]
        
        headers = {"Authorization": f"Bearer {access_token}"}
        
        for endpoint, name in auth_endpoints:
            try:
                response = requests.get(f"{BASE_URL}{endpoint}", headers=headers)
                print_test(f"{name} endpoint (authenticated)", response.status_code == 200)
            except Exception as e:
                print_test(f"{name} endpoint (authenticated)", False)
                print(f"  Error: {e}")
                all_passed = False
    
    # Test 6: Test pagination
    try:
        response = requests.get(f"{BASE_URL}/api/academy/courses?limit=5&offset=0")
        if response.status_code == 200:
            data = response.json()
            has_pagination = all(key in data for key in ["total", "limit", "offset", "data"])
            print_test("Pagination support", has_pagination)
        else:
            print_test("Pagination support", False)
            all_passed = False
    except:
        print_test("Pagination support", False)
        all_passed = False
    
    # Test 7: Test search
    try:
        response = requests.get(f"{BASE_URL}/api/ecommerce/products?search=product")
        print_test("Search functionality", response.status_code == 200)
    except:
        print_test("Search functionality", False)
        all_passed = False
    
    # Test 8: Test sorting
    try:
        response = requests.get(f"{BASE_URL}/api/academy/courses?sort_by=title&order=asc")
        print_test("Sorting functionality", response.status_code == 200)
    except:
        print_test("Sorting functionality", False)
        all_passed = False
    
    # Summary
    print(f"\n{Colors.BLUE}Test Summary:{Colors.END}")
    if all_passed:
        print(f"{Colors.GREEN}All tests passed! The API is working correctly.{Colors.END}")
    else:
        print(f"{Colors.YELLOW}Some tests failed. Please check the errors above.{Colors.END}")
    
    print(f"\n{Colors.BLUE}API Information:{Colors.END}")
    print(f"- Base URL: {BASE_URL}")
    print(f"- Documentation: {BASE_URL}/docs")
    print(f"- Alternative docs: {BASE_URL}/redoc")
    print(f"- WebSocket endpoint: ws://localhost:8000/api/chat/ws/{{user_id}}")
    
    return all_passed

if __name__ == "__main__":
    try:
        success = test_api()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print(f"\n{Colors.YELLOW}Test interrupted by user{Colors.END}")
        sys.exit(1)
    except Exception as e:
        print(f"\n{Colors.RED}Unexpected error: {e}{Colors.END}")
        sys.exit(1)