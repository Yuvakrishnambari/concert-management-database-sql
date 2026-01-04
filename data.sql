-- Insert data into Artists Table
INSERT INTO Artists (artist_name, genre) 
VALUES 
('Artist 1', 'Rock'), 
('Artist 2', 'Pop');

-- Insert data into Concerts Table
INSERT INTO Concerts (concert_name, concert_date, venue) 
VALUES 
('Concert 1', '2024-01-01', 'Stadium A'), 
('Concert 2', '2024-02-15', 'Arena B');

-- Insert data into Albums Table
INSERT INTO Albums (album_name, release_date) 
VALUES 
('pushpa', '2024-01-01'), 
('gs', '2024-02-01');

-- Insert data into Songs Table
INSERT INTO Songs (song_name, release_date, duration) 
VALUES 
('Song 1', '2024-01-01', '00:03:30'), 
('Song 2', '2024-01-15', '00:04:00');

-- Link artists to albums (ArtistAlbums)
INSERT INTO ArtistAlbums (artist_id, album_id) 
VALUES 
(1, 1), 
(2, 2);

-- Link albums to songs (AlbumSongs)
INSERT INTO AlbumSongs (album_id, song_id) 
VALUES 
(1, 1), 
(2, 2);

-- Link artists to concerts (ArtistConcerts)
INSERT INTO ArtistConcerts (artist_id, concert_id) 
VALUES 
(1, 1), 
(2, 2);

-- Insert data into Fans Table
INSERT INTO Fans (fan_name, email, age) 
VALUES 
('Fan 1', 'okay@gmail.com', 25), 
('Fan 2', 'yes@gmail.com', 30);

-- Insert data into Tickets Table (concert_id must exist in the Concerts table)
INSERT INTO Tickets (concert_id, fan_id, seat_number) 
VALUES 
(1, 1, 'A1'), 
(2, 2, 'B1');

-- Link tickets to fans (TicketFans)
INSERT INTO TicketFans (ticket_id, fan_id) 
VALUES 
(1, 1),  -- Fan 1 bought ticket for Concert 1
(2, 2);  -- Fan 2 bought ticket for Concert 2

-- Link fans to favorite artists (FavoriteArtists)
INSERT INTO FavoriteArtists (fan_id, artist_id) 
VALUES 
(1, 1),  -- Fan 1's favorite artist is Artist 1
(1, 2),  -- Fan 1 also likes Artist 2
(2, 2);  -- Fan 2's favorite artist is Artist 2