#!/bin/bash

echo "Starting Netlify deployment script"

# Install Python if needed (Netlify supports this)
if [ ! -f ".python-install-bin/python3.9" ] && [ "$NETLIFY" = "true" ]; then
    echo "Installing Python 3.9..."
    mkdir -p .python-install-bin
    curl -L https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.9.7-x86_64-unknown-linux-gnu-install_only.tar.gz | tar -xz -C .python-install-bin
    export PATH=$(pwd)/.python-install-bin/python/bin:$PATH
fi

# Check Python version
echo "Python version:"
python3 --version || python --version

# Create and activate virtual environment
echo "Creating virtual environment..."
python3 -m venv .venv || python -m venv .venv
source .venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Print installed packages for debugging
pip list

# For Netlify, we don't start the app here
echo "Deployment build completed successfully"