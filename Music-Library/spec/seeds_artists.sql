-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES('Abba', 'Pop');

-- SELECT name, genre FROM artists WHERE id = $1;

-- INSERT INTO artists (name, genre) VALUES($1, $2);

-- DELETE FROM artists WHERE id = $1;

-- UPDATE artists SET name = $1, genre = $2 WHERE id = $3;

-- Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.
-- psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

-- in our case run this:  psql -h 127.0.0.1 music_library_test < spec/seeds_artists.sql; 
