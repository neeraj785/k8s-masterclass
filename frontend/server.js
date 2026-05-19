const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// Grab the backend URL from the environment variable injected by Kubernetes
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:5000';

app.use(express.static(path.join(__dirname)));

app.get('/api/message', async (req, res) => {
    try {
        const response = await fetch(`${BACKEND_URL}/api/v1/data`);
        const data = await response.json();
        res.json(data);
    } catch (error) {
        res.status(500).json({ message: "Could not reach backend service" });
    }
});

app.listen(PORT, () => {
    console.log(`Frontend serving on port ${PORT}, routing API to ${BACKEND_URL}`);
});