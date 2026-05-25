const express = require('express');
const dotenv = require('dotenv');

dotenv.config();
const app = express();

// Middleware a JSON adatokhoz
app.use(express.json());

app.get('/', (req, res) => {
    res.json({ message: "Szerver online!" });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Szerver fut: http://localhost:${PORT}`);
});

const mysql = require('mysql2');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10
});

// Promise alapúvá alakítás
module.exports = pool.promise();

app.post('/api/diakok', async (req, res) => {
    const { nev, osztaly } = req.body;
    try {
        const [result] = await db.query(
            "INSERT INTO diakok (nev, osztaly) VALUES (?, ?)",
            [nev, osztaly]
        );
        res.status(201).json({ id: result.insertId, message: "Diák felvéve!" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.get('/api/diakok', async (req, res) => {
    try {
        const [rows] = await db.query("SELECT * FROM diakok");
        res.json(rows);
    } catch (err) {
        res.status(500).send("Szerver hiba");
    }
});

if (!req.body.nev || req.body.nev.length < 3) {
    return res.status(400).json({ 
        message: "A név kötelező és legalább 3 karakter!" 
    });
}

if (!req.body.nev || req.body.nev.length < 3) {
    return res.status(400).json({ 
        message: "A név kötelező és legalább 3 karakter!" 
    });
}