USE master
GO
IF EXISTS(SELECT * FROM SYS.sysdatabases WHERE name = 'gyukOSku') 
BEGIN
	DROP DATABASE gyukOSku
END
CREATE DATABASE gyukOSku
GO
USE gyukOSku
GO
CREATE TABLE Meat(
	MeatId CHAR(5) PRIMARY KEY,
	MeatName VARCHAR(30),
	MeatPrice INT,
	MeatCalory INT,
	MeatWeight INT,
	MeatRating INT
)
GO
CREATE TABLE Customer(
	CustomerId CHAR(5) PRIMARY KEY,
	CustomerName VARCHAR(30),
	CustomerPhone VARCHAR(20),
	CustomerGender VARCHAR(8),
	CustomerEmail VARCHAR(50),
	CustomerAddress VARCHAR(40)
)
GO
CREATE TABLE HeaderTransaction(
	TransactionId CHAR(5) PRIMARY KEY,
	CustomerId CHAR(5) REFERENCES Customer(CustomerId)ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate Date
)
GO
CREATE TABLE DetailTransaction(
	TransactionId CHAR(5) REFERENCES HeaderTransaction(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE,
	MeatId CHAR(5) REFERENCES Meat(MeatId) ON UPDATE CASCADE ON DELETE CASCADE,
	Qty INT,
	PRIMARY KEY(TransactionId,MeatId)
)
GO
INSERT INTO Meat 
VALUES
		('MT001','Karubi',38000,10,30,4),
		('MT002','Rosu',58000,50,45,5),
		('MT003','Negi Tongue',63000,30,20,3),
		('MT004','King Karubi',78000,100,70,5),
		('MT005','Aust Wagyu Karubi',83000,150,100,5)

GO
INSERT INTO Customer
	VALUES
		('CS001','Saya','082149488159','Female','saya@gmail.com','Anggrek Besar Street'),
		('CS002','Leonardo Kurwan','086888204012','Male','leonardo.kurwan@gmail.com','Syahdan Street'),
		('CS003','Eric Van Panda','086688295871','Male','ervanda@gmail.com','Mangga Lily Street'),
		('CS004','Natasia Yun','083326598210','Female','natyunsia@gmail.com','Anggrek Besar Street'),
		('CS005','Kalian','0878868222441','Female','saya@gmail.com','Anggrek Besar Street')
GO
INSERT INTO HeaderTransaction
	VALUES
			('TR001', 'CS002', '2020-01-14'),
			('TR002', 'CS005', '2020-01-14'),
			('TR003', 'CS004', '2020-01-24'),
			('TR004', 'CS002', '2020-01-24'),
			('TR005', 'CS001', '2020-02-11'),
			('TR006', 'CS003', '2020-02-11'),
			('TR007', 'CS005', '2020-02-11'),
			('TR008', 'CS004', '2020-03-21'),
			('TR009', 'CS003', '2020-03-21'),
			('TR010', 'CS003', '2020-03-21')
GO
INSERT INTO DetailTransaction
	VALUES
			('TR001', 'MT002', 2),
			('TR001', 'MT003', 2),
			('TR002', 'MT005', 3),
			('TR002', 'MT003', 4),
			('TR003', 'MT003', 5),
			('TR004', 'MT002', 4),
			('TR004', 'MT003', 2),
			('TR004', 'MT005', 2),
			('TR005', 'MT004', 3),
			('TR006', 'MT004', 2),
			('TR007', 'MT004', 4),
			('TR007', 'MT003', 3),
			('TR008', 'MT001', 4),
			('TR009', 'MT001', 5),
			('TR010', 'MT002', 6),
			('TR010', 'MT001', 6)
GO
EXEC sp_MSforeachtable 'SELECT * FROM ?'