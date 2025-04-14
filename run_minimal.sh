#!/bin/bash

# Activate the virtual environment if it exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

echo "Starting minimal version of the application..."
echo "This version uses simulated speech recognition without Deepgram API"
echo "Open http://localhost:5000 in your browser"

# Start the minimal application
python minimal_app.py