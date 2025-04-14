#!/bin/bash

# Set Python version
export PYTHON_VERSION=3.9

# Check for available Python versions
echo "Available Python versions:"
which python python3 python3.9 python3.11 2>/dev/null | sort

# Try to use Python 3.9 if available
if command -v python3.9 &> /dev/null; then
    PYTHON_CMD=python3.9
elif command -v python3 &> /dev/null; then
    PYTHON_CMD=python3
else
    PYTHON_CMD=python
fi

echo "Using Python: $($PYTHON_CMD --version)"

# Create and activate virtual environment
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    $PYTHON_CMD -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
python -m pip install --upgrade pip

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Verify installations
echo "Verifying installations..."
pip list

# Start the application
echo "Starting application..."
python app.py