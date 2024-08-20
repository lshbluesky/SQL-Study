CREATE TABLE actor 
(id   NUMBER     NOT NULL
,name VARCHAR2(35)
,PRIMARY KEY (id)
);

CREATE TABLE movie 
(id       NUMBER NOT NULL
,title    VARCHAR2(50)
,yr       NUMBER(4) 
,score    NUMBER(4, 2)
,PRIMARY KEY (id)
);

CREATE TABLE casting 
(movieid NUMBER NOT NULL
,actorid NUMBER NOT NULL
,ord     NUMBER
,PRIMARY KEY (movieid, actorid)
,FOREIGN KEY (movieid) REFERENCES movie(id)
,FOREIGN KEY (actorid) REFERENCES actor(id)
);

insert into actor values (1,'Woody Allen');
insert into actor values (2,'Clint Eastwood');
insert into actor values (3,'Robert De Niro');
insert into actor values (4,'Sean Connery');
insert into actor values (5,'Kevin Costner');

insert into movie values (1,'Star Wars',1977,8.80);
insert into movie values (2,'Shawshank Redemption',1995,9.00);
insert into movie values (3,'Pulp Fiction',1994,8.60);
insert into movie values (4,'Titanic',1997,7.20);
insert into movie values (5,'Star Wars: Episode V - The Empire Strikes Back',1980,8.60);
insert into movie values (6,'Usual Suspects',1995,8.70);
insert into movie values (7,'Schindler''s List',1993,8.80);
insert into movie values (8,'Saving Private Ryan',1998,8.50);
insert into movie values (9,'Braveheart',1999,8.30);
insert into movie values (10,'American Beauty',2005,8.80);

insert into casting values (1,2,1);
insert into casting values (1,4,3);
insert into casting values (1,5,2);
insert into casting values (2,1,1);
insert into casting values (2,3,2);
insert into casting values (2,2,3);
insert into casting values (3,3,3);
insert into casting values (3,4,1);
insert into casting values (3,2,2);
insert into casting values (4,1,3);
insert into casting values (4,3,2);
insert into casting values (4,5,1);
insert into casting values (5,2,1);
insert into casting values (5,4,3);
insert into casting values (5,5,2);

insert into casting values (6,5,2);
insert into casting values (6,3,1);
insert into casting values (7,2,3);
insert into casting values (7,4,1);
insert into casting values (7,1,2);
insert into casting values (8,4,1);
insert into casting values (8,3,2);
insert into casting values (8,2,3);
insert into casting values (9,3,2);
insert into casting values (9,4,3);
insert into casting values (9,5,1);
insert into casting values (10,2,3);
insert into casting values (10,3,2);
insert into casting values (10,4,1);

commit;
