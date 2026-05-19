from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/api/v1/data', methods=['GET'])
def get_data():
    return jsonify({
        "status": "success",
        "message": "Hello from the Python Flask Backend running inside Kubernetes!"
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)