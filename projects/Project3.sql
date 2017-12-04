/*
 *  project3.sql
 * 
 *  author: Taewoo Kim
 *
 */

DROP TABLE IF EXISTS books1;
DROP TABLE IF EXISTS books2;
DROP TABLE IF EXISTS books;

/* Step 1 */
CREATE TABLE books1 (number integer PRIMARY KEY, title text, isbn text, publicationdate date, pages integer);

INSERT INTO books1 VALUES (1,'Harry Potter and the Philosopher''s Stone','0-7475-3269-9','1997-06-26',223),(2,'Harry Potter and the Chamber of Secrets','0-7475-3849-2','1998-07-02',251),(3,'Harry Potter and the Prisoner of Azkaban','0-7475-4215-5','1999-07-08',317),(4,'Harry Potter and the Goblet of Fire','0-7475-4624-X','2000-07-08',636),(5,'Harry Potter and the Order of the Phoenix','0-7475-5100-6','2003-06-21',766),(6,'Harry Potter and the Half-Blood Prince','0-7475-8108-8','2005-07-16',607),(7,'Harry Potter and the Deathly Hallows','0-545-01022-5','2007-07-21',607),(8,'Harry Potter and the Bunnies of Doom','1-234-56789-0','2010-01-15',NULL);

DELETE FROM books1 WHERE number = 8;

/* Step 2 */

CREATE TABLE books2 (number integer PRIMARY KEY, publicationdate date, pages integer);

INSERT INTO books2 SELECT * FROM public.project3_us_books;

/* Step 3 */

CREATE TABLE books (number integer PRIMARY KEY, title text NOT NULL, isbn text, publicationdate date, pages integer, ustitle text, uspublicationdate date, uspages integer);

INSERT INTO books (number, title, isbn, publicationdate, pages, uspublicationdate, uspages) SELECT books1.number, books1.title, books1.isbn, books1.publicationdate, books1.pages,books2.publicationdate, books2.pages FROM books1,books2 WHERE books1.number = books2.number;

UPDATE books SET ustitle = title;

UPDATE books SET ustitle = 'Harry Potter and the Sorceror''s Stone' WHERE number = 1;