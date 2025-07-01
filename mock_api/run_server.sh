#!/bin/bash

# Flutter Demo Mock API Server Startup Script

echo "Starting Flutter Demo Mock API Server..."
echo "======================================="

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Run the server
echo "Starting server on http://localhost:8000"
echo "API Documentation available at http://localhost:8000/docs"
echo "======================================="

# Run with uvicorn for better performance
uvicorn main:app --host 0.0.0.0 --port 8000 --reload

# Alternative: run with Python directly
# python main.py