-- CREATE TABLE regions
-- 	( region_id INT(3) PRIMARY KEY,
-- 	  region_name VARCHAR(25)
-- 	);

-- DROP TABLE regions;

 DROP TABLE IF EXISTS member;
 CREATE TABLE member 
	( id SERIAL PRIMARY KEY,
	  name VARCHAR(40),
	  card_number CHAR(10)
    );

DROP TABLE IF EXISTS book;
CREATE TABLE book 
	( -- id int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	  id SERIAL PRIMARY KEY,
      title VARCHAR(60),
      author VARCHAR(60),
      checked_out_by_id INT REFERENCES member(id)
    );
    

    
INSERT INTO member ( name, card_number ) VALUES ( 'Annabelle Aster', '772-93-110');   
INSERT INTO member ( name, card_number ) VALUES ( 'Boris Berceli', '000-00-000');   
INSERT INTO member ( name, card_number ) VALUES ( 'Carter Corbin', '282-09-382');  

INSERT INTO book ( title, author, checked_out_by_id) VALUES ( 'In Search of Lost Time', 'Marcel Proust', 1);
INSERT INTO book ( title, author, checked_out_by_id) VALUES ( 'Ulysses', 'James Joyce', 1);
INSERT INTO book ( title, author, checked_out_by_id) VALUES ( 'Don Quixote', 'Miguel de Cervantes', 3);
INSERT INTO book ( title, author, checked_out_by_id) VALUES ( 'Moby Dick', 'Herman Melville', null);

-- Update the member with the id of 2 to have a card number of “357-15-964”.
SET SQL_SAFE_UPDATES=0;
UPDATE member SET card_number='357-15-964' WHERE id =2 ; 
SET SQL_SAFE_UPDATES=1;

-- Remove the member with the id of 2.
DELETE FROM member WHERE id =2;

-- Select all members that have the card number 772-93-110.
SELECT * FROM member WHERE card_number = '772-93-110';

-- Select all books sorted by title
SELECT * FROM book ORDER BY title;

-- Annabelle checked out another book… Update Moby Dick to be checked out by Annabelle.
SET SQL_SAFE_UPDATES=0;
UPDATE book SET checked_out_by_id=1 WHERE title = 'Moby Dick' ; 
SET SQL_SAFE_UPDATES=1;

-- Annabelle turned in a book… Update Ulysses to be checked out by no one (null).
SET SQL_SAFE_UPDATES=0;
UPDATE book SET checked_out_by_id = null WHERE title = 'Ulysses';
SET SQL_SAFE_UPDATES=0;

-- Write a JOIN that lists all the books and who they’re checked out to. Include the books that are not checked out.
-- SELECT book.title, member.name       // this will show only 2 columns
-- FROM book
-- INNER JOIN member
-- ON book.id = member.id;     // should have been --> book.checked_out_by_id   

SELECT * 
FROM book 
LEFT JOIN member 
ON book.checked_out_by_id=member.id;


-- Write a JOIN that lists the titles of all the books that are checked out to someone named Annabelle Aster (don't just use the ID)
SELECT book.title
FROM book
JOIN  member
ON book.checked_out_by_id = member.id WHERE member.name='Annabelle Aster';

-- Write a JOIN that lists the name and card number of all members who have checked out books by the author Herman Melville.
SELECT member.name, member.card_number
FROM member
JOIN book
ON book.checked_out_by_id = member.id WHERE book.author = 'Herman Melville';

-- or
 
SELECT member.name, member.card_number 
FROM book 
JOIN member 
ON book.checked_out_by_id = member.id WHERE book.author = 'Herman Melville';