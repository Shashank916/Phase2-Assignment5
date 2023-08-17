CREATE DATABASE Assesment05Db;

USE Assesment05Db;

CREATE SCHEMA bank;

CREATE TABLE bank.Customer (
    CId INT PRIMARY KEY,
    CName VARCHAR(255) NOT NULL,
    CEmail VARCHAR(255) NOT NULL UNIQUE,
    Contact VARCHAR(20) NOT NULL UNIQUE,
    CPwd AS RIGHT(CName, 2) + CAST(CId AS VARCHAR) + LEFT(Contact, 2) PERSISTED
);


CREATE TABLE bank.MailInfo (
    mailTo VARCHAR(255),
    mailDate DATE,
    mailMessage VARCHAR(MAX)
);


CREATE TRIGGER trgMailToCust
ON bank.Customer
AFTER INSERT
AS
BEGIN
    INSERT INTO bank.MailInfo (mailTo, mailDate, mailMessage)
    SELECT 
        i.CEmail, 
        GETDATE(), 
        CONCAT('Your net banking Password is: ', i.CPwd, '. It is valid up to 2 days only. Update it')
    FROM inserted i;
END;


INSERT INTO bank.Customer (CId, CName, CEmail, Contact)
VALUES
    (1001, 'Shashank', 'shashank@gmail.com', '1234567890'),
    (1002, 'Bhumika', 'bhumika@gmail.com', '9876543210'),
	(1003, 'Kokila', 'kokila@gmail.com', '9632587410'),
	(1004, 'Rani','Rani@gmail.com','8523697410');



SELECT * FROM bank.Customer;

SELECT * FROM bank.MailInfo;


