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
create table question(questionId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, questionDetails VARCHAR(100), solutionDetails VARCHAR(100),
						custRepId VARCHAR(10), userId VARCHAR(10),
                        FOREIGN KEY (custRepId) REFERENCES custRep(custRepId),
                        FOREIGN KEY (userId) REFERENCES user(userId));

select * from question;

-- AUTO BID:
create table autoBid(autoBidId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, bidLimit FLOAT,
					itemId INT NOT NULL, isLimitCrossed CHAR(1),
					FOREIGN KEY (itemId) REFERENCES AuctionItem(itemId));

select * from autoBid;

-- BID:
create table bid(bidId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, userId VARCHAR(10), dateTime VARCHAR(50),
				amount FLOAT, itemId INT NOT NULL, autoBidId INT, FOREIGN KEY (itemId) REFERENCES auctionItem(itemId), 
				FOREIGN KEY (userId) REFERENCES user(userId), FOREIGN KEY (autoBidId) REFERENCES AutoBid(autoBidId));

select * from bid;

-- RESERVES:
create table reserves(bidId INT, itemId INT, PRIMARY KEY(bidId, itemId),
						FOREIGN KEY (bidId) REFERENCES bid(bidId), FOREIGN KEY (itemId) REFERENCES auctionItem(itemId));

select * from reserves;

-- AUCTION ITEM:
-- colorType: (Acrylic, Oil, Watercolor, Pastel, Gouache, Encaustic, Fresco, Spray Paint, Digital)
-- paintingStyle: (Realism, Photorealism, Expressionism, Impressionism, Abstract, Surrealism, Pop Art)
-- subcategory: (History Painting, Portrait Art, Genre Painting, Landscape Painting, Still Life Painting)

create table auctionItem(itemId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(40),
						subcategory VARCHAR(40), length INT, breadth INT, colorType VARCHAR(20), 
                        paintingStyle VARCHAR(20), description VARCHAR(100), artist VARCHAR(50),
                        initialPrice FLOAT, minPrice FLOAT, closingDateTime VARCHAR(50),
						incrementAmount FLOAT, currentBid FLOAT, sellerId VARCHAR(10) NOT NULL, buyerId VARCHAR(10),
						FOREIGN KEY (sellerId) REFERENCES user(userId));
                        
select * from auctionItem;