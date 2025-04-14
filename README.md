# Hebrew Tongue Twisters Web App

A simple web application that generates Hebrew tongue twisters (skorogovorok) and allows users to view them randomly.

## Features

- Generate 20 Hebrew tongue twisters
- Display a random tongue twister from the generated list
- Responsive design with RTL (Right-to-Left) support for Hebrew

## Requirements

- Python 3.x
- Flask
- python-dotenv
- requests

## Installation

1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

## Usage

1. Run the application:
   ```
   python app.py
   ```
2. Open your browser and navigate to `http://localhost:5000`
3. Click the "Generate" button to create 20 tongue twisters
4. Click the "Random" button to display a random tongue twister

## Note

This application uses placeholder Hebrew tongue twisters. In a production environment, you would integrate with Azure OpenAI API to generate authentic tongue twisters.
