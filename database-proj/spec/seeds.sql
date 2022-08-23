TRUNCATE TABLE albums RESTART IDENTITY;

INSERT INTO albums (title, release_year, artist_id) VALUES ('YES', 1996, 4);
INSERT INTO albums (title, release_year, artist_id) VALUES ('NO', 1997, 5);