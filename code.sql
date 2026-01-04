-- Step 1: Set the DELIMITER for multiple statements (for triggers and procedures)
DELIMITER //

-- Step 2: Create the VIEW - ConcertDetails
CREATE VIEW ConcertDetails AS
SELECT 
    c.concert_id, 
    c.concert_name, 
    COUNT(DISTINCT tf.fan_id) AS total_fans
FROM 
    Concerts c
JOIN Tickets t ON c.concert_id = t.concert_id
JOIN TicketFans tf ON t.ticket_id = tf.ticket_id
GROUP BY c.concert_id, c.concert_name
HAVING COUNT(DISTINCT tf.fan_id) > 0;

-- Step 3: Create the BEFORE INSERT Trigger - before_ticket_insert
CREATE TRIGGER before_ticket_insert 
BEFORE INSERT ON Tickets
FOR EACH ROW
BEGIN
    IF NEW.concert_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Concert ID cannot be NULL';
    END IF;
END//

-- Step 4: Drop Trigger if it exists (optional cleanup)
DROP TRIGGER IF EXISTS before_ticket_insert;

-- Step 5: Create the AFTER INSERT Trigger - after_ticket_insert
CREATE TRIGGER after_ticket_insert 
AFTER INSERT ON Tickets
FOR EACH ROW
BEGIN
    -- Automatically assign a default fan (e.g., fan_id = 1) to the new ticket
    INSERT INTO TicketFans (ticket_id, fan_id) 
    VALUES (NEW.ticket_id, 1);  -- Replace '1' with the appropriate default fan_id if needed
END//

-- Step 6: Create the GetOccupiedSeats Function
CREATE FUNCTION GetOccupiedSeats(concertId INT) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE totalSeats INT;
    
    -- Calculate the total number of distinct fans for the given concert ID
    SELECT COUNT(DISTINCT fan_id) INTO totalSeats
    FROM Tickets t
    JOIN TicketFans tf ON t.ticket_id = tf.ticket_id
    WHERE t.concert_id = concertId;
    
    RETURN totalSeats;
END//

-- Step 7: Create the CheckAndUpdateSong Procedure
CREATE PROCEDURE CheckAndUpdateSong (
    IN songId INT,
    IN albumId INT
)
BEGIN
    -- Check if the song is already associated with the album
    IF NOT EXISTS (
        SELECT 1 FROM AlbumSongs WHERE song_id = songId AND album_id = albumId
    ) THEN
        -- Insert association if it doesn't exist
        INSERT INTO AlbumSongs (album_id, song_id) VALUES (albumId, songId);
    END IF;

    -- Update the song's release date if it is later than the album's release date
    UPDATE Songs
    SET release_date = (SELECT release_date FROM Albums WHERE album_id = albumId)
    WHERE song_id = songId AND release_date > (SELECT release_date FROM Albums WHERE album_id = albumId);
END//

-- Step 8: Check the Procedure Status (optional)
SHOW PROCEDURE STATUS WHERE Db = 'concerts_schema';  -- Replace 'concerts_schema' with your database name

-- Step 9: Example call to the procedure (Replace 1 and 2 with actual IDs)
CALL CheckAndUpdateSong(1, 2);  -- Replace 1 and 2 with actual song_id and album_id values

-- Reset DELIMITER back to default
DELIMITER ;