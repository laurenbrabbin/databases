TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;


INSERT INTO artists (name, genre) VALUES('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES('Abba', 'Pop');

INSERT INTO albums (id, title, release_year, artist_id) VALUES ('1', 'Doolittle', '1989', '1');
INSERT INTO albums (id, title, release_year, artist_id) VALUES ('2', 'Surfer Rosa', '1988', '1');