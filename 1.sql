--create a new table
CREATE SCHEMA Arts;
GO
CREATE TABLE Arts.Performer
(
    PerformerId int IDENTITY CONSTRAINT PKPerformer PRIMARY KEY,
    Name varchar(100)
);
GO

--roll back action to a saved point
BEGIN TRANSACTION;
INSERT INTO Arts.Performer(Name) VALUES ('Elvis');
SAVE TRANSACTION savepoint;

INSERT INTO Arts.Performer(Name) VALUES ('Air Supply');
ROLLBACK TRANSACTION savepoint;
COMMIT TRANSACTION;
SELECT *
FROM Arts.Performer;
GO

--two active users case: psudo code
-- Begin TRANSACTION

-- SELECT balance
-- from table1 
-- where acct = '1111';

-- update tabel1
-- set balance = 500 + 500
-- where account = '1111'

-- COMMIT TRANSACTION


-- isolation test.
-- isolation levels: Read Uncommitted, Read Committed, 
--                   Repeatable Read, Serializable
CREATE SCHEMA Art;
GO
Create TABLE Art.Artist
(
    ArtistID int CONSTRAINT PKArtist PRIMARY KEY,
    Name VARCHAR(30),
    Padding char(4000) DEFAULT (replicate('a', 4000))
);
INSERT Into Art.Artist(ArtistID, Name)
VALUES (1, 'da Vinci'), 
       (2, 'Micheangelo'), 
       (3, 'Donatello'),
       (4, 'Picasso'), 
       (5, 'Dali'), 
       (6, 'Jones');
GO
CREATE TABLE Art.ArtWork
(
    ArtWorkId int CONSTRAINT PKArtWork PRIMARY KEY,
    ArtistId int NOT NULL CONSTRAINT FKArtwork$wasDoneBy$Artist REFERENCES Art.Artist (ArtistID),
    Name VARCHAR(30),
    Padding char(4000) DEFAULT (replicate('a', 4000)),
    CONSTRAINT AKArtwork UNIQUE (ArtistId, Name)
);
Insert into Art.ArtWork (ArtWorkId, ArtistId, Name)
VALUES (1, 1, 'last Supper'),
       (2, 1, 'Mona Lisa'),
       (3, 6, 'Rabbit Fire');
GO

--Isolation test on Read Uncommited
--connection A
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION
INSERT Into Art.Artist(ArtistID,Name)
VALUES (8, 'Thomas');
ROLLBACK TRANSACTION;

--connection B
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- SELECT ArtistID, Name 
-- FROM Art.Artist
-- WHERE Name = 'Thomas';
-- GO

SELECT * 
from Sales.Shippers;

INSERT INTO Sales.Shippers (companyname, phone)
    VALUES ('Shipper XYZ', '(123)456-789');INSERT INTO Sales.Shippers (companyname, phone)
    VALUES ('Shipper XYZ', '(123)456-789');


SELECT S.shipperid
from Sales.Shippers as S 
WHERE NOT Exists 
    (
        Select *
        from Sales.Orders as O 
        WHERE O.shipperid = S.shipperid
    );

SELECT S.shipperid
FROM Sales.Shippers as S 
    LEFT OUTER JOIN Sales.Orders as O 
        ON S.shipperid = O.shipperid
WHERE O.orderid IS NULL;

DELETE From Sales.Shippers WHERE shipperid > 3;