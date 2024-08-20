CREATE TABLE album
(asin   CHAR(10) NOT NULL PRIMARY KEY
,title  VARCHAR2(50)
,artist VARCHAR2(20)
,price  NUMBER(10,2)		
,rdate  DATE
,label  VARCHAR2(10)
,rank   NUMBER
);

CREATE TABLE track
(album  CHAR(10) NOT NULL
,dsk    NUMBER  NOT NULL
,posn   NUMBER  NOT NULL
,song   VARCHAR2(50)
,PRIMARY KEY(album,dsk,posn) 
,FOREIGN KEY (album) REFERENCES album(asin)
);

INSERT INTO album VALUES ('B0000009VO', 'The Very Best Of Elvis Costello And The Attraction', 'Elvis Costello', NULL, TO_DATE('1994-10-25', 'YYYY-MM-DD'), 'Ryko', 1465);
INSERT INTO album VALUES ('B000000OU0', 'Hell Freezes Over', 'Eagles', 13.99, TO_DATE('1994-11-08', 'YYYY-MM-DD'), NULL, 513);
INSERT INTO album VALUES ('B000000WA4', 'Mellon Collie and the Infinite Sadness', 'Smashing Pumpkins', 21.99, TO_DATE('1995-10-24', 'YYYY-MM-DD'), NULL, 2332);
INSERT INTO album VALUES ('B000000WDA', 'Blur', 'Blur', 11.98, TO_DATE('1997-03-11', 'YYYY-MM-DD'), NULL, 17154);
INSERT INTO album VALUES ('B000000WF0', 'Urban Hymns', 'The Verve', 13.99, TO_DATE('1997-09-30', 'YYYY-MM-DD'), NULL, 1855);

insert into track values ('B0000009VO',1,1,'Alison');
insert into track values ('B0000009VO',1,2,'Watching The Detectives');
insert into track values ('B0000009VO',1,3,'(I Don''t Want To Go To) Chelsea');
insert into track values ('B0000009VO',1,4,'Pump It Up');
insert into track values ('B0000009VO',1,5,'Radio Radio');
insert into track values ('B0000009VO',1,6,'(What''s So Funny ''Bout) Peace, Love...');
insert into track values ('B0000009VO',1,7,'Oliver''s Army');
insert into track values ('B0000009VO',1,8,'Accidents Will Happen');
insert into track values ('B0000009VO',1,9,'I Can''t Stand Up (For Falling Down)');
insert into track values ('B0000009VO',1,10,'New Amsterdam');
insert into track values ('B0000009VO',1,11,'High Fidelity');
insert into track values ('B0000009VO',1,12,'Clubland');
insert into track values ('B0000009VO',1,13,'Watch Your Step');
insert into track values ('B0000009VO',1,14,'Good Year For The Roses');
insert into track values ('B0000009VO',1,15,'Beyond Belief');
insert into track values ('B0000009VO',1,16,'Man Out Of Time');
insert into track values ('B0000009VO',1,17,'Everyday I Write The Book');
insert into track values ('B0000009VO',1,18,'Shipbuilding');
insert into track values ('B0000009VO',1,19,'Love');
insert into track values ('B0000009VO',1,20,'Brilliant Mistake');
insert into track values ('B0000009VO',1,21,'Indoor Fireworks');
insert into track values ('B0000009VO',1,22,'I Want You');

insert into track values ('B000000OU0',1,1,'Get Over It');
insert into track values ('B000000OU0',1,2,'Love');
insert into track values ('B000000OU0',1,3,'The Girl From Yesterday');
insert into track values ('B000000OU0',1,4,'Learn To Be Still');
insert into track values ('B000000OU0',1,5,'Tequila Sunrise');
insert into track values ('B000000OU0',1,6,'Hotel California');
insert into track values ('B000000OU0',1,7,'Wasted Time');
insert into track values ('B000000OU0',1,8,'Pretty Maids All In A Row');
insert into track values ('B000000OU0',1,9,'I Can''t Tell You Why');
insert into track values ('B000000OU0',1,10,'New York Minute');
insert into track values ('B000000OU0',1,11,'The Last Resort');
insert into track values ('B000000OU0',1,12,'Take It Easy');
insert into track values ('B000000OU0',1,13,'In The City');
insert into track values ('B000000OU0',1,14,'Life In The Fast Lane');
insert into track values ('B000000OU0',1,15,'Desperado');

insert into track values ('B000000WA4',1,1,'Mellon Collie and the Infinite Sadness');
insert into track values ('B000000WA4',1,2,'Tonight, Tonight');
insert into track values ('B000000WA4',1,3,'Jellybelly');
insert into track values ('B000000WA4',1,4,'Zero');
insert into track values ('B000000WA4',1,5,'Here Is No Why');
insert into track values ('B000000WA4',1,6,'Bullet With Butterfly Wings');
insert into track values ('B000000WA4',1,7,'To Forgive');
insert into track values ('B000000WA4',1,8,'An Ode to No One');
insert into track values ('B000000WA4',1,9,'Love');
insert into track values ('B000000WA4',1,10,'Cupid de Locke');
insert into track values ('B000000WA4',1,11,'Galapogos');
insert into track values ('B000000WA4',1,12,'Muzzle');
insert into track values ('B000000WA4',1,13,'Porcelina of the Vast Oceans');
insert into track values ('B000000WA4',1,14,'Take Me Down');

insert into track values ('B000000WDA',1,1,'Beetlebum');
insert into track values ('B000000WDA',1,2,'Song 2');
insert into track values ('B000000WDA',1,3,'Country Sad Ballad Man');
insert into track values ('B000000WDA',1,4,'M.O.R.');
insert into track values ('B000000WDA',1,5,'On Your Own');
insert into track values ('B000000WDA',1,6,'Theme From Retro');
insert into track values ('B000000WDA',1,7,'You''re So Great');
insert into track values ('B000000WDA',1,8,'Death Of A Party');
insert into track values ('B000000WDA',1,9,'Chinese Bombs');
insert into track values ('B000000WDA',1,10,'I''m Just A Killer For Your Love');
insert into track values ('B000000WDA',1,11,'Look Inside America');
insert into track values ('B000000WDA',1,12,'Strange News From Another Star');
insert into track values ('B000000WDA',1,13,'Movin'' On');
insert into track values ('B000000WDA',1,14,'Essex Dogs');

insert into track values ('B000000WF0',1,1,'Bittersweet Symphony');
insert into track values ('B000000WF0',1,2,'Sonnet');
insert into track values ('B000000WF0',1,3,'Rolling People');
insert into track values ('B000000WF0',1,4,'Drugs Don''t Work');
insert into track values ('B000000WF0',1,5,'Catching the Butterfly');
insert into track values ('B000000WF0',1,6,'Neon Wilderness');
insert into track values ('B000000WF0',1,7,'Space and Time');
insert into track values ('B000000WF0',1,8,'Weeping Willow');
insert into track values ('B000000WF0',1,9,'Lucky Man');
insert into track values ('B000000WF0',1,10,'One Day');
insert into track values ('B000000WF0',1,11,'This Time');
insert into track values ('B000000WF0',1,12,'Velvet Morning');
insert into track values ('B000000WF0',1,13,'Come On');

commit;
