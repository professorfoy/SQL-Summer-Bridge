-- Assignment No. 3 Relational Database

-- Create one table to keep track of Key Card Users.
-- This table includes a unique Key Card User ID and the User Name.

CREATE TABLE KeyCardUsers (
UserID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
UserName VARCHAR(30) NOT NULL
);

-- Populate the KeyCardUsers table with data.

INSERT INTO KeyCardUsers (UserID, UserName) VALUES (1, 'Modesto');
INSERT INTO KeyCardUsers (UserID, UserName) VALUES (2, 'Allyene');
INSERT INTO KeyCardUsers (UserID, UserName) VALUES (3, 'Chris');
INSERT INTO KeyCardUsers (UserID, UserName) VALUES (4, 'Cheong');
INSERT INTO KeyCardUsers (UserID, UserName) VALUES (5, 'Saulat');
INSERT INTO KeyCardUsers (UserID, UserName) VALUES (6, 'Heidy');

SELECT * FROM keycardusers;

-- Create one table to keep track of Key Card Groups.
-- This table includes a unique Key Card Group ID, and the Group Name.

CREATE TABLE KeyCardGroups (
GroupID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
GroupName VARCHAR(30) NOT NULL
);

-- Populate the KeyCardGroup table with data.

INSERT INTO KeyCardGroups (GroupID, GroupName) VALUES (1, 'IT');
INSERT INTO KeyCardGroups (GroupID, GroupName) VALUES (2, 'Sales');
INSERT INTO KeyCardGroups (GroupID, GroupName) VALUES (3, 'Aministration');
INSERT INTO KeyCardGroups (GroupID, GroupName) VALUES (4, 'Operations');

SELECT * FROM KeyCardGroups;

-- Question #1:
-- A group should appear even if there are no users assigned to the group.
-- To accomplish this, select the names of the persons in each group, then join the UserNames through a bridge.

-- Creation of Bridge table labeled UsersGroups to join Users and Groups:

CREATE TABLE UsersGroups (
UserID INT NOT NULL,
GroupID INT NOT NULL
);

-- Populate the UsersGroups table with data.  Since Heidy was not assigned a group, she does not appear below.

INSERT INTO UsersGroups (UserID, GroupID) VALUES (1, 1);
INSERT INTO UsersGroups (UserID, GroupID) VALUES (2, 1);
INSERT INTO UsersGroups (UserID, GroupID) VALUES (3, 2);
INSERT INTO UsersGroups (UserID, GroupID) VALUES (4, 2);
INSERT INTO UsersGroups (UserID, GroupID) VALUES (5, 3);

SELECT * FROM UsersGroups;

-- Run Select commmand to see all groups, and the users in each group. 

SELECT keycardgroups.GroupName AS 'Group Name', KeyCardUsers.UserName AS 'Key Card User'
FROM keycardgroups LEFT JOIN UsersGroups ON keycardgroups.GroupID = usersgroups.GroupID
LEFT JOIN KeyCardUsers ON usersgroups.UserID = keycardusers.UserID;

-- Question #2:
-- The rooms should appear even if no groups have been assigned to them.

-- Create one table to keep track of Key Card Rooms.
-- This table includes a unique Key Card Room ID, and the Room Name.

CREATE TABLE KeyCardRooms (
RoomID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
RoomName VARCHAR(30) NOT NULL
);

-- Populate the KeyCardRoom table with data.

INSERT INTO KeyCardRooms (RoomID, RoomName) VALUES (1, '101');
INSERT INTO KeyCardRooms (RoomID, RoomName) VALUES (2, '102');
INSERT INTO KeyCardRooms (RoomID, RoomName) VALUES (3, 'Auditorium A');
INSERT INTO KeyCardRooms (RoomID, RoomName) VALUES (4, 'Auditorium B');

SELECT * FROM keycardrooms;

-- Creation of Bridge table labeled GroupsRooms to join Groups and Rooms:

CREATE TABLE GroupsRooms (
GroupID INT NOT NULL,
RoomID INT NOT NULL
);

-- Populate the UsersGroups table with data.  Since Heidy was not assigned a group, she does not appear below.

INSERT INTO GroupsRooms (GroupID, RoomID) VALUES (1, 1);
INSERT INTO GroupsRooms (GroupID, RoomID) VALUES (1, 2);
INSERT INTO GroupsRooms (GroupID, RoomID) VALUES (2, 2);
INSERT INTO GroupsRooms (GroupID, RoomID) VALUES (2, 3);

-- Run Select command to see the values of Users to Group assignments:

SELECT * FROM GroupsRooms;

-- Run Select command to see all rooms, and the groups assigned to each room. 

SELECT keycardrooms.RoomName AS 'Room Name', KeyCardGroups.GroupName AS 'Key Card Groups'
FROM keycardrooms LEFT JOIN GroupsRooms ON KeyCardRooms.RoomID = GroupsRooms.RoomID
LEFT JOIN KeyCardGroups ON GroupsRooms.GroupID = KeyCardGroups.GroupID;

-- Question #3:
-- Join list of users, the groups that they belong to, and the rooms to which they are assigned. 
-- This should be sorted alphabetically by user, then by group, then by room.

-- Since each table is a many to many relationships type, to join them a bridge table is set up between the 
-- Users and Groups (labeled UsersGroups), and the Groups and Rooms (labeld GroupsRooms).  

-- I did this three ways, 1) with the Left Join listing the fields from left to right, 2) a Right Join listing the fields 
-- from right to left, 3) and the second Left Join from right to left.  The first and second way yielded the answer.  Intuitively, 
-- I thought the second way of doing it would work, moving from right to left, but it did not yield the answer to the question as  
-- the output omitted Saulat from the list. I have not been able to figure out why. Perhaps if you have the time, can you please 
-- give me a short explanation why the answer needs to move from left to right with a Left Join, but the answers to questions
-- one and two above used a left join moving from right to left?

-- Method 1 (correct answer):

SELECT KeyCardUsers.UserName AS 'Key Card User', KeyCardGroups.GroupName AS 'Key Card Groups', keycardrooms.RoomName AS 'Room Name'
FROM keycardrooms RIGHT JOIN GroupsRooms ON KeyCardRooms.RoomID = GroupsRooms.RoomID
RIGHT JOIN KeyCardGroups ON GroupsRooms.GroupID = KeyCardGroups.GroupID
RIGHT JOIN UsersGroups ON keycardgroups.GroupID = usersgroups.GroupID
RIGHT JOIN KeyCardUsers ON usersgroups.UserID = keycardusers.UserID
ORDER BY KeyCardUsers.UserName, KeyCardGroups.GroupName, keycardrooms.RoomName;

-- Method 2 (correct answer):

SELECT KeyCardUsers.UserName AS 'Key Card User', KeyCardGroups.GroupName AS 'Key Card Groups', keycardrooms.RoomName AS 'Room Name'
FROM KeyCardUsers LEFT JOIN UsersGroups ON usersgroups.UserID = keycardusers.UserID 
LEFT JOIN KeyCardGroups ON keycardgroups.GroupID = usersgroups.GroupID
LEFT JOIN GroupsRooms ON GroupsRooms.GroupID = KeyCardGroups.GroupID
LEFT JOIN  keycardrooms ON KeyCardRooms.RoomID = GroupsRooms.RoomID
ORDER BY KeyCardUsers.UserName, KeyCardGroups.GroupName, keycardrooms.RoomName;

-- Method 3 (incorrect answer):

SELECT KeyCardUsers.UserName AS 'Key Card User', KeyCardGroups.GroupName AS 'Key Card Groups', keycardrooms.RoomName AS 'Room Name'
FROM keycardrooms LEFT JOIN GroupsRooms ON KeyCardRooms.RoomID = GroupsRooms.RoomID
LEFT JOIN KeyCardGroups ON GroupsRooms.GroupID = KeyCardGroups.GroupID
LEFT JOIN UsersGroups ON keycardgroups.GroupID = usersgroups.GroupID
LEFT JOIN KeyCardUsers ON usersgroups.UserID = keycardusers.UserID
ORDER BY KeyCardUsers.UserName, KeyCardGroups.GroupName, keycardrooms.RoomName;

