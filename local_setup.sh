#!/bin/bash

echo "Setting up Hebrew Tongue Twisters App locally"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip and install setuptools
echo "Upgrading pip and installing setuptools..."
pip install --upgrade pip setuptools wheel

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

echo "Setup complete!"
echo ""
echo "To run the app, use these commands:"
echo "source venv/bin/activate  # Activate the virtual environment"
echo "python app.py             # Start the Flask application"
echo ""
echo "Then open http://localhost:5000 in your browser"