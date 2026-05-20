-- Adatbázis létrehozása
CREATE DATABASE IF NOT EXISTS konyvtar
CHARACTER SET utf8mb4
COLLATE utf8mb4_hungarian_ci;

USE konyvtar;

-- Könyvek tábla létrehozása
CREATE TABLE IF NOT EXISTS konyvek (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(255) NOT NULL,
    kategoria VARCHAR(100),
    statusz VARCHAR(50) DEFAULT 'elérhető',
    beszerzes_eve INT
);