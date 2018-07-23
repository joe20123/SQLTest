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





