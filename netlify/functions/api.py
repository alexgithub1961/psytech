from flask import Flask, request
import awsgi  # Using aws-wsgi instead of netlify_lambda_wsgi
import sys
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('netlify-function')

# Check Python version
logger.info(f"Python version: {sys.version}")
logger.info(f"Python executable: {sys.executable}")

# Add the parent directory to sys.path so we can import from the app module
root_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(root_dir)
logger.info(f"Added to path: {root_dir}")

# Import the Flask app from the main app.py file
try:
    from app import app as flask_app
    logger.info("Successfully imported Flask app")
except Exception as e:
    logger.error(f"Error importing Flask app: {str(e)}")
    raise

# Create the Lambda handler using aws-wsgi
def handler(event, context):
    logger.info("Handler called with event")
    return awsgi.response(flask_app, event, context)
