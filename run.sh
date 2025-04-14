#!/bin/bash

# Configuration
PORT=5000
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$APP_DIR/venv"
LOG_FILE="$APP_DIR/app.log"

# Print with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Starting Hebrew Tongue Twister App..."

# Check if .env file exists
if [ ! -f "$APP_DIR/.env" ]; then
    if [ -f "$APP_DIR/.env.example" ]; then
        log "Warning: .env file not found. Creating from .env.example"
        cp "$APP_DIR/.env.example" "$APP_DIR/.env"
        log "Please update .env with your actual API keys"
    else
        log "Error: Neither .env nor .env.example found. Please create a .env file with your API keys."
        exit 1
    fi
fi

# Check if port is in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
    log "Port $PORT is already in use. Attempting to kill the process..."
    PID=$(lsof -Pi :$PORT -sTCP:LISTEN -t)
    kill -15 $PID 2>/dev/null || kill -9 $PID 2>/dev/null
    sleep 2
    
    # Check if process was killed successfully
    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
        log "Failed to kill process using port $PORT. Please close it manually."
        exit 1
    else
        log "Successfully killed process on port $PORT."
    fi
fi

# Check if virtual environment exists, create if it doesn't
if [ ! -d "$VENV_DIR" ]; then
    log "Virtual environment not found. Creating..."
    python3 -m venv "$VENV_DIR"
    if [ ! -d "$VENV_DIR" ]; then
        log "Failed to create virtual environment. Please install python3-venv."
        exit 1
    fi
fi

# Activate virtual environment
log "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Install or update dependencies
log "Installing/updating dependencies..."
pip install -r "$APP_DIR/requirements.txt"

# Start the application
log "Starting Flask application on port $PORT..."
cd "$APP_DIR"

# Set Flask environment variables
export FLASK_APP=app.py
export FLASK_ENV=development
export FLASK_DEBUG=1

# Run the application
log "Application started! Access it at http://localhost:$PORT"
log "Press Ctrl+C to stop the server"
log "Logs will be saved to $LOG_FILE"

# Start the Flask app and redirect output to log file
python -m flask run --host=0.0.0.0 --port=$PORT 2>&1 | tee -a "$LOG_FILE"
