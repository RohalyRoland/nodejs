-- =============================================================================
-- BACKEND PROGRAMOZÁS TANANYAG - MINTA ADATBÁZIS (SQL SZKRIPT)
-- Téma: Könyvtár Kezelő Rendszer
-- Készült a 13. évfolyam szoftverfejlesztő vizsgájára való felkészüléshez
-- =============================================================================

-- 1. ADATBÁZIS LÉTREHOZÁSA ÉS HASZNÁLATA
-- Megjegyzés: utf8mb4 kódolást használunk a magyar ékezetes betűk miatt.

CREATE DATABASE IF NOT EXISTS konyvtar
CHARACTER SET utf8mb4
COLLATE utf8mb4_hungarian_ci;

USE konyvtar;

-- -----------------------------------------------------------------------------
-- 2. TÁBLA SZERKEZETÉNEK LÉTREHOZÁSA (CREATE)
-- A 'konyvek' tábla tárolja az alapvető adatokat.
-- Az 'id' elsődleges kulcs, ami automatikusan növekszik (AUTO_INCREMENT).

CREATE TABLE IF NOT EXISTS konyvek (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(255) NOT NULL,          -- Könyv címe (kötelező)
    kategoria VARCHAR(100),            -- Műfaj/Kategória
    statusz VARCHAR(50) DEFAULT 'elérhető', -- Alapértelmezett állapot
    beszerzes_eve INT                  -- Beszerzés éve
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 3. MINTAADATOK FELTÖLTÉSE (INSERT)
-- Itt adunk meg kezdő adatokat a teszteléshez.

INSERT INTO konyvek (nev, kategoria, statusz, beszerzes_eve) VALUES
('A Pál utcai fiúk', 'Ifjúsági regény', 'elérhető', 2022),
('Egri csillagok', 'Történelmi regény', 'kölcsönözve', 2021),
('1984', 'Disztópia', 'elérhető', 2023),
('A kis herceg', 'Mese', 'elérhető', 2020),
('Alapítvány', 'Sci-fi', 'selejtezve', 2018),
('Galaxis útikalauz stopposoknak', 'Sci-fi', 'elérhető', 2019),
('Bűn és bűnhődés', 'Klasszikus', 'elérhető', 2015),
('A Gyűrűk Ura', 'Fantasy', 'kölcsönözve', 2024);

-- -----------------------------------------------------------------------------
-- 4. ADATOK LEKÉRDEZÉSE (READ / SELECT)
-- Ezeket a lekérdezéseket a GET végpontokon fogjuk használni a backendben.

-- A) Az összes rekord lekérése
SELECT * FROM konyvek;

-- B) Egy konkrét elem lekérése azonosító alapján
-- Backendben: GET /api/konyvek/3
SELECT * FROM konyvek WHERE id = 3;

-- C) Szűrés kategória szerint (pl. csak a Sci-fi könyvek)
SELECT * FROM konyvek WHERE kategoria = 'Sci-fi';

-- D) Keresés cím alapján (részleges egyezés - LIKE)
-- Megmutatja azokat a könyveket, amik címében szerepel a 'fiú' szó.
SELECT * FROM konyvek WHERE nev LIKE '%fiú%';

-- E) Rendezett lista (beszerzés éve szerint csökkenő sorrendben)
SELECT * FROM konyvek ORDER BY beszerzes_eve DESC;

-- -----------------------------------------------------------------------------
-- 5. ADATOK MÓDOSÍTÁSA (UPDATE)
-- Ezeket a PUT végpontokon fogjuk használni.

-- Egy könyv státuszának megváltoztatása ID alapján.
UPDATE konyvek 
SET statusz = 'kölcsönözve' 
WHERE id = 1;

-- Egyszerre több adat módosítása.
UPDATE konyvek 
SET statusz = 'elérhető', beszerzes_eve = 2024 
WHERE id = 5;

-- -----------------------------------------------------------------------------
-- 6. ADATOK TÖRLÉSE (DELETE)
-- Ezeket a DELETE végpontokon fogjuk használni.

-- Figyelem: ID alapján töröljünk, hogy véletlenül ne töröljünk mást!
DELETE FROM konyvek WHERE id = 8;

-- -----------------------------------------------------------------------------
-- 7. EXTRA: STATISZTIKAI LEKÉRDEZÉSEK
-- Hasznos lehet egy dashboardhoz.

-- Hány könyv van összesen?
SELECT COUNT(*) AS osszes_konyv FROM konyvek;

-- Hány könyv érhető el jelenleg?
SELECT COUNT(*) FROM konyvek WHERE statusz = 'elérhető';

-- Kategóriánkénti eloszlás
SELECT kategoria, COUNT(*) as darab 
FROM konyvek 
GROUP BY kategoria;

-- =============================================================================
-- FONTOS BIZTONSÁGI TANÁCS (BACKEND)
-- A Node.js kódban NE így írd: `SELECT * FROM konyvek WHERE id = ` + user_id;
-- HELYETTE használd a paraméterezett formát: `... WHERE id = ?`, [user_id];
-- =============================================================================
