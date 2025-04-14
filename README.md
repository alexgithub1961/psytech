# Hebrew Tongue Twisters Web App

A simple web application that generates Hebrew tongue twisters (skorogovorok) and allows users to view them randomly.

## Features

- Generate 20 Hebrew tongue twisters
- Display a random tongue twister from the generated list
- Responsive design with RTL (Right-to-Left) support for Hebrew

## Deployment

This application can be deployed to various platforms that support Python web applications:

### Netlify Deployment

1. Connect your GitHub repository to Netlify
2. Set the build command to `./netlify.sh`
3. Set the publish directory to `.`
4. Add environment variable `DEEPGRAM_API_KEY` in the Netlify dashboard
5. Deploy the site

### Heroku Deployment

1. Install the Heroku CLI
2. Login to Heroku: `heroku login`
3. Create a new Heroku app: `heroku create your-app-name`
4. Set environment variables: `heroku config:set DEEPGRAM_API_KEY=your-api-key`
5. Deploy the app: `git push heroku main`

### Render Deployment

1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Set the build command: `pip install -r requirements.txt`
4. Set the start command: `gunicorn app:app`
5. Add environment variables in the Render dashboard

## Requirements

- Python 3.9+
- Flask
- python-dotenv
- requests
- Deepgram API key (for speech recognition)

## Installation

1. Clone the repository
2. Create a `.env` file with your Deepgram API key:
   ```
   DEEPGRAM_API_KEY=your-api-key-here
   ```
3. Run the setup script:
   ```
   ./local_setup.sh
   ```
   This will create a virtual environment and install all dependencies.

## Running Locally

1. Run the application:
   ```
   ./run.sh
   ```
   Or manually:
   ```
   source venv/bin/activate
   python app.py
   ```
2. Open your browser and navigate to `http://localhost:5000`
3. Click the "Generate" button to create 20 tongue twisters
4. Click the "Random" button to display a random tongue twister
5. Click "Start" to begin recording your voice
6. Try to pronounce the tongue twister
7. The application will evaluate your pronunciation and give you a score

## Note

This application uses the Deepgram Whisper model for Hebrew speech recognition.
