/************************************************************************************/
/* Date				Programmer			Description									*/
/*																					*/
/* 3/4/2022			Aaron Potter		Initial creation of disk database			*/
/* 3/11/2022		Aaron Poter			Add insert statements.						*/	
/*																					*/
/*																					*/
/************************************************************************************/
use master;
go
DROP DATABASE IF EXISTS disk_inventoryap;
go
CREATE DATABASE disk_inventoryap;
go
use disk_inventoryap;
go
IF SUSER_ID('diskUserap') IS NULL
	CREATE LOGIN diskUserap
	WITH PASSWORD = 'Pa$$w0rd', 
	DEFAULT_DATABASE = disk_inventoryap;
use disk_inventoryap;
go
CREATE USER diskUserap;
ALTER ROLE db_datareader
	ADD MEMBER diskUserap;
go

CREATE TABLE disk_type (
	disk_type_id	INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
); --CD, DVD, Vinyl, 8track, cassette
CREATE TABLE genre (
	genre_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
);--Country, Metal, Rock, Alt
CREATE TABLE status (
	status_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
);--Available, Onloan, Damaged,
CREATE TABLE borrower (
	borrower_id		INT NOT NULL IDENTITY PRIMARY KEY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NOT NULL,
	phone_num		VARCHAR(150) NOT NULL
);
CREATE TABLE disk (
	disk_id			INT NOT NULL IDENTITY PRIMARY KEY,
	disk_name		NVARCHAR(60) NOT NULL,
	release_date	DATE NOT NULL,
	genre_id		INT NOT NULL REFERENCES genre(genre_id),
	status_id		INT NOT NULL REFERENCES status(status_id),
	disk_type_id	INT NOT NULL REFERENCES disk_type(disk_type_id)
);
CREATE TABLE disk_has_borrower (
	disk_has_borrower_id	INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id					INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date			DATETIME2 NOT NULL,
	returned_date			DATETIME2 NULL
);
/****** END OF PROJECT 1 ******/

/*** START OF PROJECT 2***/
/***Insert Statements ***/

--Insert data into disk_type
INSERT INTO disk_type
	(description)
VALUES
	('CD'), 
	('Vinyl'), 
	('Cassette'), 
	('8-Track'), 
	('DVD');

--Insert data into genre
INSERT INTO genre
	(description)
VALUES
	('Rock'), ('Pop'), ('Hip Hop'), ('Jazz'), 
	('Rythm & Blues'), ('Folk'), ('Blues'), ('Country'), 
	('Classical'), ('EDM'), ('Alternative Rock'), ('Dance'),
	('Punk Rock'), ('Soul'), ('Indie'), ('Funk'), ('Reggae'), 
	('Techno'), ('Latin'), ('House'), ('Lo-Fi'), ('K-Pop'), 
	('Grunge'), ('Opera'), ('Blue Grass'), ('Soundtrack');

--Insert data into status
INSERT INTO status
	(description)
VALUES
	('Available'), 
	('On-loan'), 
	('Damaged'), 
	('Returned'), 
	('Unavailable'), 
	('Not-in-stock'),
	('Missing');

-- Insert into borrower
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Winifred', 'Micheal', '123-123-1234'),
	('Soren', 'Bjergsen', '223-223-2234'),
	('Callahan', 'James', '323-323-3234'),
	('Kaisa', 'Taliyah', '423-423-4234'),
	('Caitlyn', 'Violet', '523-523-5234'),
	('Zoe', 'Ezreal', '623-623-6234'),
	('Ashe', 'Pantheon', '723-723-7234'),
	('Diana', 'Leona', '823-823-8234'),
	('Luxana', 'Ezreal', '823-823-8234'),
	('Jinx', 'Ekko', '923-923-9234'),
	('Aphelios', 'Targon', '103-103-1034'),
	('Tahm', 'Kench', '121-212-2234'),
	('Talon', 'Noxus', '232-323-2234'),
	('Renata', 'Glasc', '343-343-3234'),
	('Syndra', 'Ionia', '454-545-4234'),
	('Twisted', 'Fate', '656-565-5234'),
	('Vel', 'Koz', '767-676-6234'),
	('Wukong', 'Zhongoa', '883-883-7234'),
	('Xayah', 'Rakan', '993-993-8234'),
	('Lucian', 'Senna', '100-100-8234'),
	('Xin', 'Zhao', '200-200-9234'),
	('Yasuo', 'Yone', '300-103-1034'),
	('Teemo', 'Yordle', '666-666-1034'); 

-- e.2 Delete only 1 borrower row using a where clause
DELETE borrower
WHERE fname = 'Teemo';

-- d
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES -- Needs at least 20 real world albums
('An Awesome Wave','1/1/2012', 11, 2, 1),
('This Is All Yours','1/2/2014', 11, 2, 1),
('RELAXER','1/3/2017', 11, 2, 1),
('The Dream','12/11/2022', 11, 2, 1),
('WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?', '1/5/2019', 11, 2, 1),
('Happier Than Ever','1/6/2021', 11, 1, 1),
('Inside','1/7/2021', 26, 1, 1),
('Lost Tapes','1/18/2020', 2, 1, 1),
('The Queen''s Gambit','1/19/2020', 26, 2, 1),
('Mutmath','1/10/2006', 11, 5, 1),
('Armistice','1/11/2009', 11, 2, 1),
('Odd Soul','1/12/2011', 11, 2, 1),
('Vitals','1/13/2015', 11, 1, 1),
('Parachutes','1/14/2000', 1, 5, 1),
('A Rush of Blood to the Head','1/15/2002', 1, 1, 1),
('X&Y','1/16/2005', 1, 1, 1),
('Viva La Vida','1/17/2008', 1, 2, 1),
('Vampire Weekend','1/18/2008', 11, 1, 1),
('Modern Vampires of the City','1/19/2013', 11, 1, 1),
('Contra','1/20/2010', 11, 2, 1),
('Father of the Bride','1/21/2012', 11, 2, 1);

-- d.2 Update only 1 disk row using a where clause
UPDATE disk
SET release_date = '5/3/2012'
WHERE disk_name = 'Father of the Bride';

--Insert borrowed rows DiskHasBorrower table
INSERT disk_has_borrower
	(borrower_id, disk_id, borrowed_date, returned_date)
VALUES
	(1, 1, '1-1-2012', '2-15-2012'),
	(3, 5, '11-2-2012', '12-15-2012'),
	(3, 6, '1-3-2012', '2-25-2012'),
	(2, 7, '7-4-2017', '8-15-2019'),
	(5, 2, '1-5-2012', NULL),
	(5, 7, '1-6-2007', '2-15-2010'),
	(6, 1, '1-7-2012', NULL),
	(7, 1, '1-8-2012', '2-15-2012'),
	(11, 1, '1-9-2012', '2-15-2012'),
	(15, 1, '1-10-2012', '2-15-2017'),
	(8, 1, '1-11-2012', '3-15-2018'),
	(12, 14, '1-12-2012', '3-15-2019'),
	(14, 15, '1-13-2012', NULL),
	(13, 15, '1-14-2012', '2-15-2012'),
	(19, 18, '1-15-2012', '2-15-2018'),
	(20, 14, '1-16-2012', NULL),
	(22, 12, '1-17-2012', '2-15-2012'),
	(9, 21, '1-18-2012', '2-15-2021'),
	(15, 19, '1-19-2012', '2-15-2021'),
	(11, 9, '1-20-2012', '2-15-2020'),
	(14, 12, '1-21-2012', '2-15-2020');

--g Create a query to list the disks that are on loan and have not been returned
SELECT borrower_id as Borrower_id, disk_id as Disk_id, 
	CAST(borrowed_date as date) as Borrowed_date, returned_date as Return_date
FROM disk_has_borrower
WHERE returned_date  IS NULL;
