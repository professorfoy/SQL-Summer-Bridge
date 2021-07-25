CREATE DATABASE MySQL_Videos;
USE mysql_videos;

-- 1. Create one table to keep track of the videos.
--    This table should include a unique ID, the title of the video, the length in minutes, and the URL.

CREATE TABLE YouTube (
Unique_ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
Title VARCHAR(50) NOT NULL, 
Length_Mins INT NOT NULL,
URL VARCHAR(255) NOT NULL
);

-- Populate the table with at least three related videos from YouTube or other publicly available resources.

INSERT INTO youtube (Title, Length_Mins, URL) VALUES ('Learn SQL In 60 Minutes', 56.38, 'https://www.youtube.com/watch?v=p3qvj9hO_Bo');
INSERT INTO youtube (Title, Length_Mins, URL) VALUES ('MySQL Tutorial for Beginners', 190.18, 'https://www.youtube.com/watch?v=7S_tz1z_5bA');
INSERT INTO youtube (Title, Length_Mins, URL) VALUES ('MySQL Crash Course', 71.34, 'https://www.youtube.com/watch?v=9ylj9NR0Lcg');

-- 2. Create a second table that provides at least two user reviews for each of at least two of the videos.
--    These should be imaginary reviews that include columns for the user’s name (“Asher”, “Cyd”, etc.),
--	  the rating (which could be NULL, or a number between 0 and 5), and a short text review (“Loved it!”).
--    There should be a column that links back to the ID column in the table of videos.

CREATE TABLE Reviewers (
Unique_ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
User_Name VARCHAR(25) NOT NULL,
Rating INT NOT NULL,
Short_Review VARCHAR(100) NOT NULL,
FOREIGN KEY reviewers(Unique_ID) REFERENCES youtube(Unique_ID)
);

-- at least two user reviews for each of at least two of the videos.

INSERT INTO reviewers (User_Name, Rating, Short_Review) VALUES ('Jim Walker', 4, 'Funny and Entertaining');
INSERT INTO reviewers (User_Name, Rating, Short_Review) VALUES ('Mitch DiNatale', 2, 'A bit disorganized');
INSERT INTO reviewers (User_Name, Rating, Short_Review) VALUES ('John Hughes', 3, 'Mediocre video');

-- 3. Write a JOIN statement that shows information from both tables.

SELECT * FROM youtube
	INNER JOIN reviewers
    ON youtube.Unique_ID = reviewers.Unique_ID;
    