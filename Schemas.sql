-- Entity Sets

CREATE TABLE Hotel ( 
	hotelID INTEGER,
	hotelAddress VARCHAR(255),
	managerID INTEGER,
	PRIMARY KEY (hotelID),
	FOREIGN KEY (managerID) REFERENCES Employee(employeeID) ON DELETE CASCADE
);

CREATE TABLE Employee ( 
	employeeID INTEGER,
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	dob DATE,
	role VARCHAR(15),
	salary INTEGER,
	hotelID INTEGER,
	PRIMARY KEY (employeeID)
	FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) ON DELETE CASCADE
	CHECK (role = 'Manager' or role = 'Employee')
);

CREATE TABLE Customer ( 
	customerID INTEGER,
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	phoneNumber INTEGER,
	roomNumber INTEGER, 
	hotelID INTEGER,
	PRIMARY KEY (customerID)
	FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) ON DELETE CASCADE
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);


CREATE TABLE Room ( 
	roomNumber INTEGER,
	hotelID INTEGER,
	occupied VARCHAR(3), 
	PRIMARY KEY (roomNumber)
	FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) ON DELETE CASCADE
	CHECK (occupied = 'Yes' or occupied = 'No')
);


CREATE TABLE Transactions (
	transNumber INTEGER,
	transDate DATE, 
	amount INTEGER,
	customerID INTEGER,
	PRIMARY KEY (transNumber)
	FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
	CHECK (amount>0)
);	

CREATE TABLE TodayPrice ( 
	roomType VARCHAR(20),
	discount FLOAT,
	price INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (roomType)
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);




-- Weak Entities

CREATE TABLE Single (
	capacity INTEGER,
	roomNumber INTEGER, 
	PRIMARY KEY (roomNumber)
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);

CREATE TABLE Double (
	capacity INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (roomNumber)
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);

CREATE TABLE Triple (
	capacity INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (roomNumber)
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);

CREATE TABLE Quad (
	capacity INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (roomNumber)
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);


-- RELATIONS

CREATE TABLE Employs (
	hotelID INTEGER,
	employeeID INTEGER,
	PRIMARY KEY (employeeID,hotelID)
	FOREIGN KEY (employeeID) REFERENCES Employee(employeeID) ON DELETE CASCADE
	FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) ON DELETE CASCADE
);

CREATE TABLE Owns (
	hotelID INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (roomNumber,hotelID)
	FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) ON DELETE CASCADE
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);

CREATE TABLE Book (
	customerID INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (customerID,roomNumber)
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
	FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
);

CREATE TABLE Payment (
	transNumber INTEGER,
	customerID INTEGER,
	PRIMARY KEY (customerID,transNumber)
	FOREIGN KEY (transNumber) REFERENCES Transactions(transNumber) ON DELETE CASCADE
	FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
);

CREATE TABLE Cost (
	amount INTEGER,
	roomNumber INTEGER,
	PRIMARY KEY (roomNumber,amount)
	FOREIGN KEY (amount) REFERENCES TodayPrice(amount) ON DELETE CASCADE
	FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber) ON DELETE CASCADE
);