show databases;

create database auction;

use auction;

-- USER:
create table user(userId VARCHAR(10) PRIMARY KEY, password VARCHAR(20) NOT NULL);

-- NOTE: Create user accounts through the website!

select * from user;

-- ADMIN:
create table admin(adminId VARCHAR(10) PRIMARY KEY, password VARCHAR(20) NOT NULL);

insert into admin values('admin', 'admin123');

select * from admin;

-- CUST REP:
create table custRep(custRepId VARCHAR(10) PRIMARY KEY, password VARCHAR(20) NOT NULL, creatorId VARCHAR(10),
					FOREIGN KEY (creatorId) REFERENCES admin(adminId));

-- NOTE: Create customer representative accounts through the website!

select * from custRep;

-- MODIFIES:
create table modifiedBy(custRepId VARCHAR(10), userId VARCHAR(10), datetime VARCHAR(50),
						FOREIGN KEY (custRepId) REFERENCES custRep(custRepId),
                        FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
                        PRIMARY KEY(custRepId, userId, datetime)); 

select * from modifiedBy;

-- QUESTION:
create table question(questionId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, questionDetails VARCHAR(100), solutionDetails VARCHAR(100),
						custRepId VARCHAR(10), userId VARCHAR(10),
                        FOREIGN KEY (custRepId) REFERENCES custRep(custRepId),
                        FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE);

select * from question;


-- AUCTION ITEM:
-- colorType: (Acrylic, Oil, Watercolor, Pastel, Gouache, Encaustic, Fresco, Spray Paint, Digital)
-- paintingStyle: (Realism, Photorealism, Expressionism, Impressionism, Abstract, Surrealism, Pop Art)
-- subcategory: (History Painting, Portrait Art, Genre Painting, Landscape Painting, Still Life Painting)

create table auctionItem(itemId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(40),
						subcategory VARCHAR(40), length INT, breadth INT, colorType VARCHAR(20), 
                        description VARCHAR(100), artist VARCHAR(50),
                        initialPrice FLOAT, minPrice FLOAT, closingDateTime VARCHAR(50),
						incrementAmount FLOAT, currentBid FLOAT, sellerId VARCHAR(10) NOT NULL, buyerId VARCHAR(10),
						FOREIGN KEY (sellerId) REFERENCES user(userId) ON DELETE CASCADE);
                        
select * from auctionItem;

-- AUTO BID:
create table autoBid(autoBidId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, userId VARCHAR(10), bidLimit FLOAT,
					itemId INT NOT NULL, isLimitCrossed CHAR(1),
					FOREIGN KEY (itemId) REFERENCES AuctionItem(itemId),
					FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE);

select * from autoBid;

-- update autoBid set isLimitCrossed='Y' where autoBidId=1;

-- BID:
create table bid(bidId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, userId VARCHAR(10), dateTime VARCHAR(50),
				amount FLOAT, itemId INT NOT NULL, FOREIGN KEY (itemId) REFERENCES auctionItem(itemId), 
				FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE);

select * from bid; 

-- LISTING ALERTS:
create table listingAlerts(alertId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, userId VARCHAR(10),
							subcategory VARCHAR(40), lengthFrom INT, lengthTo INT, breadthFrom INT, breadthTo INT,
                            colorType VARCHAR(20), initialPriceFrom FLOAT, initialPriceTo FLOAT,
							FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE);
                            
select * from listingAlerts;
