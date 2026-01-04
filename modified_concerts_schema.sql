-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS concerts_schema;

-- Step 2: Use the Database
USE concerts_schema;

-- Step 3: Create the Artists Table
CREATE TABLE IF NOT EXISTS Artists (
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(255) NOT NULL,
    genre VARCHAR(100)
);

-- Step 4: Create the Albums Table
CREATE TABLE IF NOT EXISTS Albums (
    album_id INT PRIMARY KEY AUTO_INCREMENT,
    album_name VARCHAR(255) NOT NULL,
    release_date DATE
);

-- Step 5: Create the Songs Table
CREATE TABLE IF NOT EXISTS Songs (
    song_id INT PRIMARY KEY AUTO_INCREMENT,
    song_name VARCHAR(255) NOT NULL,
    release_date DATE,
    duration TIME
);

-- Step 6: Create the Concerts Table
CREATE TABLE IF NOT EXISTS Concerts (
    concert_id INT PRIMARY KEY AUTO_INCREMENT,
    concert_name VARCHAR(255) NOT NULL,
    concert_date DATE,
    venue VARCHAR(255)
);

-- Step 7: Create the Fans Table with Age Column
CREATE TABLE IF NOT EXISTS Fans (
    fan_id INT PRIMARY KEY AUTO_INCREMENT,
    fan_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    age INT
);

-- Step 8: Create the Tickets Table
CREATE TABLE IF NOT EXISTS Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    concert_id INT,
    fan_id INT,
    seat_number VARCHAR(50),
    FOREIGN KEY (concert_id) REFERENCES Concerts(concert_id),
    FOREIGN KEY (fan_id) REFERENCES Fans(fan_id)
);

-- Step 9: Create the ArtistAlbums Table (Many-to-Many Relationship)
CREATE TABLE IF NOT EXISTS ArtistAlbums (
    artist_id INT,
    album_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    PRIMARY KEY (artist_id, album_id)
);

-- Step 10: Create the AlbumSongs Table (Many-to-Many Relationship)
CREATE TABLE IF NOT EXISTS AlbumSongs (
    album_id INT,
    song_id INT,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id),
    PRIMARY KEY (album_id, song_id)
);

-- Step 11: Create the ArtistConcerts Table (Many-to-Many Relationship)
CREATE TABLE IF NOT EXISTS ArtistConcerts (
    artist_id INT,
    concert_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    FOREIGN KEY (concert_id) REFERENCES Concerts(concert_id),
    PRIMARY KEY (artist_id, concert_id)
);

-- Step 12: Create the FavoriteArtists Table (Many-to-Many Relationship)
CREATE TABLE IF NOT EXISTS FavoriteArtists (
    fan_id INT,
    artist_id INT,
    FOREIGN KEY (fan_id) REFERENCES Fans(fan_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    PRIMARY KEY (fan_id, artist_id)
);

-- Step 13: Create the TicketFans Table (Many-to-Many Relationship)
CREATE TABLE IF NOT EXISTS TicketFans (
    ticket_id INT,
    fan_id INT,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id),
    FOREIGN KEY (fan_id) REFERENCES Fans(fan_id),
    PRIMARY KEY (ticket_id, fan_id)
);
