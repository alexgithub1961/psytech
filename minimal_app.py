import os
import json
import random
import time
import base64
import logging
from flask import Flask, render_template, request, jsonify
from dotenv import load_dotenv

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler('app.log')
    ]
)
logger = logging.getLogger('psytech')

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Store generated tongue twisters
generated_tongue_twisters = []

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate():
    global generated_tongue_twisters
    
    # Placeholder for Hebrew tongue twisters
    generated_tongue_twisters = [
        "שרה שרה שיר שמח",
        "דן דן דן בדלת דקה",
        "ציפור צייצה צליל צלול",
        "גדי גידל גזר גדול בגינה",
        "רוני רץ רחוק ראה רכבת",
        "פיל פילף פלפל פעם",
        "חיים חלם חלום חדש",
        "טלי טיילה בטיילת",
        "כרמל כתבה כרטיס כחול",
        "מיכל מצאה מטבע מבריק",
        "נועה נתנה נר נאה",
        "סבא סיפר סיפור סודי",
        "עומר עבד עבודה עצומה",
        "צבי צייר ציור צבעוני",
        "קרן קנתה קופסה קטנה",
        "רותי רקדה ריקוד רועש",
        "שלומי שתל שתיל שמנמן",
        "תמר תפרה תיק תכלת",
        "אבי אהב אגס אדום",
        "בני בנה בניין בבוקר"
    ]
    
    return jsonify({'success': True, 'count': len(generated_tongue_twisters)})

@app.route('/random', methods=['GET'])
def get_random():
    global generated_tongue_twisters
    
    if not generated_tongue_twisters:
        return jsonify({'success': False, 'message': 'No tongue twisters generated yet'})
    
    random_tongue_twister = random.choice(generated_tongue_twisters)
    return jsonify({'success': True, 'tongue_twister': random_tongue_twister})

# Store the last shown tongue twister and its timestamp
last_tongue_twister = {
    'text': '',
    'timestamp': 0
}

@app.route('/set-current', methods=['POST'])
def set_current_tongue_twister():
    global last_tongue_twister
    
    data = request.json
    if 'tongue_twister' not in data:
        return jsonify({'success': False, 'message': 'No tongue twister provided'})
    
    last_tongue_twister['text'] = data['tongue_twister']
    last_tongue_twister['timestamp'] = time.time()
    
    return jsonify({'success': True})

@app.route('/evaluate-speech', methods=['POST'])
def evaluate_speech():
    global last_tongue_twister
    
    # Check if we have a tongue twister to compare against
    if not last_tongue_twister['text']:
        return jsonify({
            'success': False, 
            'message': 'No tongue twister has been selected yet'
        })
    
    # Get audio data from the request
    data = request.json
    if 'audio_data' not in data:
        return jsonify({
            'success': False, 
            'message': 'No audio data provided'
        })
    
    try:
        # Decode the base64 audio data
        try:
            # Handle different formats of base64 data
            audio_data = data['audio_data']
            if ',' in audio_data:
                # Format: data:audio/webm;base64,BASE64DATA
                audio_bytes = base64.b64decode(audio_data.split(',')[1])
            else:
                # Format: Just the BASE64DATA
                audio_bytes = base64.b64decode(audio_data)
            
            logger.info(f'Audio data size: {len(audio_bytes)} bytes')
        except IndexError:
            return jsonify({
                'success': False, 
                'message': 'Invalid audio data format'
            })
        
        # Calculate time taken (in seconds)
        end_time = time.time()
        time_taken = end_time - last_tongue_twister['timestamp']
        
        # Create a mock transcription (just use the original text with some errors)
        # In a real app, this would come from Deepgram
        original_text = last_tongue_twister['text']
        
        # Introduce some random "errors" to simulate transcription
        characters = list(original_text)
        for i in range(min(3, len(characters))):
            if len(characters) > 0:
                idx = random.randint(0, len(characters) - 1)
                if random.random() < 0.5 and characters[idx] != ' ':
                    # Drop a character
                    characters.pop(idx)
                else:
                    # Swap adjacent characters
                    if idx > 0:
                        characters[idx], characters[idx-1] = characters[idx-1], characters[idx]
        
        transcription = ''.join(characters)
        
        # Calculate accuracy (0-100)
        similarity = max(0, 100 - (5 * random.random()))  # Random but high accuracy
        
        # Calculate score factors
        time_factor = max(0, 100 - (time_taken * 10)) if time_taken < 10 else 0
        score = (similarity * time_factor) / 100
        
        return jsonify({
            'success': True,
            'transcription': transcription,
            'original': last_tongue_twister['text'],
            'accuracy': round(similarity, 2),
            'time_taken': round(time_taken, 2),
            'time_factor': round(time_factor, 2),
            'score': round(score, 2)
        })
        
    except Exception as e:
        logger.error(f'Error in evaluate_speech: {str(e)}')
        return jsonify({
            'success': False,
            'message': f'Error processing audio: {str(e)}'
        })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)