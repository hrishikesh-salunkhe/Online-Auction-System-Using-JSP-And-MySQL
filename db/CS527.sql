show databases;

use auction;

show tables;

-- USER:
create table user(userId VARCHAR(10) PRIMARY KEY, password VARCHAR(20) NOT NULL);

select * from user;

-- ADMIN:
create table admin(adminId VARCHAR(10) PRIMARY KEY, password VARCHAR(20) NOT NULL);

insert into admin values('admin', 'admin123');

select * from admin;

-- CUST REP:
create table custRep(custRepId VARCHAR(10) PRIMARY KEY, password VARCHAR(20) NOT NULL, creatorId VARCHAR(10),
					FOREIGN KEY (creatorId) REFERENCES admin(adminId));

insert into custRep values('cr', 'cr123', 'admin');

select * from custRep;

-- MODIFIES:
create table modifiedBy(custRepId VARCHAR(10), userId VARCHAR(10), datetime VARCHAR(50),
						FOREIGN KEY (custRepId) REFERENCES custRep(custRepId),
                        FOREIGN KEY (userId) REFERENCES user(userId),
                        PRIMARY KEY(custRepId, userId, datetime)); 

select * from modifiedBy;

-- QUESTION:
create table question(questionId int NOT NULL AUTO_INCREMENT PRIMARY KEY, questionDetails VARCHAR(100), solutionDetails VARCHAR(100),
						custRepId VARCHAR(10), userId VARCHAR(10),
                        FOREIGN KEY (custRepId) REFERENCES custRep(custRepId),
                        FOREIGN KEY (userId) REFERENCES user(userId));

select * from question;

-- AUCTION ITEM:
create table auctionItem(itemId int NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(40),
						subcategory VARCHAR(30), initialPrice FLOAT,
						minPrice FLOAT, closingDateTime DATETIME, isValid CHAR(1),
						features VARCHAR(100), delisterId VARCHAR(10), incrementAmount FLOAT, currentBid FLOAT,
						sellerId VARCHAR(10) NOT NULL, buyerId VARCHAR(10),
						FOREIGN KEY (sellerId) REFERENCES user(userId),
						FOREIGN KEY (buyerId) REFERENCES bid(userId),
						FOREIGN KEY (delisterId) REFERENCES CustomerRep(custRepId) )