# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Run application: `python app.py`
- Install dependencies: `pip install -r requirements.txt`
- Format Python code: `black .`
- Lint Python code: `flake8 .`

## Code Style Guidelines
- **Imports**: Group imports in this order: standard library, third-party, local application
- **Formatting**: Use 4-space indentation for Python, 2-space for HTML/JS
- **Naming**: Use snake_case for Python variables/functions and camelCase for JavaScript
- **File Organization**: Keep route handlers organized by functionality
- **Error Handling**: Use try/except blocks with specific exceptions and meaningful error messages
- **Comments**: Add docstrings for functions and classes, explaining purpose and parameters
- **HTML Structure**: Use semantic HTML elements and maintain RTL support for Hebrew content
- **JavaScript**: Use async/await for asynchronous operations
- **API Responses**: Return JSON with 'success' boolean and appropriate messages

## Environment
- Python 3.x
- Flask web framework
- Deepgram for speech recognition
- Store API keys in .env file (never commit actual keys)