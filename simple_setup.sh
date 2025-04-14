#!/bin/bash

echo "Setting up Hebrew Tongue Twisters App with minimal dependencies"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip and install required packages individually
echo "Installing core dependencies..."
pip install --upgrade pip setuptools wheel
pip install Flask==2.3.3
pip install python-dotenv==1.0.0
pip install requests==2.31.0
pip install deepgram-sdk==2.11.0
pip install asyncio==3.4.3
pip install asgiref==3.7.2
pip install gunicorn==21.2.0
pip install aws-wsgi==0.2.7

echo "The application should work now with minimal functionality."
echo "Audio processing features may be limited without numpy and audio libraries."
echo ""
echo "To run the app, use these commands:"
echo "source venv/bin/activate  # Activate the virtual environment"
echo "python app.py             # Start the Flask application"
echo ""
echo "Then open http://localhost:5000 in your browser"