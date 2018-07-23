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





