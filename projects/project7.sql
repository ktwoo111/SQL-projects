/*
 *  project7.sql
 * 
 *  author: Taewoo Kim
 *
 */
\encoding utf8
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS AlbumGenre;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Label;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Artist;

CREATE TABLE Artist(
id serial, 
name text, 
type text,  
PRIMARY KEY(id)
);

INSERT INTO Artist (name, type)
SELECT DISTINCT member_name, 'Person'
FROM public.project7 WHERE member_name IS NOT NULL;

INSERT INTO Artist(name, type)
SELECT DISTINCT artist_name, artist_type
FROM public.project7 WHERE (artist_name) NOT IN
(SELECT name FROM Artist); 

CREATE TABLE Members(
artist_id integer,
member_id integer,
member_begin numeric(4,0), 
member_end numeric(4,0),
FOREIGN KEY(artist_id) REFERENCES Artist(id),
FOREIGN KEY(member_id) REFERENCES Artist(id),
PRIMARY KEY(artist_id,member_id) 
);

INSERT INTO Members(member_begin, member_end, artist_id, member_id)
SELECT DISTINCT member_begin_year, member_end_year, a.id, m.id
FROM public.project7 as p
JOIN Artist as a ON a.name = p.artist_name  
JOIN Artist as m ON m.name = p.member_name;

CREATE TABLE Label(
id serial,
name text,
location text,
PRIMARY KEY(id)
);

INSERT INTO Label (name, location)
SELECT DISTINCT label, headquarters
FROM public.project7
WHERE label IS NOT NULL;


CREATE TABLE Album(
id serial,
title text,
year numeric(4,0),
artist_id integer,
label_id integer,
FOREIGN KEY(artist_id) REFERENCES Artist(id),
FOREIGN KEY(label_id) REFERENCES Label(id),
PRIMARY KEY(id)
);

INSERT INTO Album (title, year, artist_id, label_id)
SELECT DISTINCT album_title, album_year, a.id, l.id
FROM public.project7 AS p
JOIN Artist as a ON a.name = p.artist_name
JOIN Label as l ON l.name = p.label;

CREATE TABLE AlbumGenre(
id serial,
album_id integer,
genre text,
PRIMARY KEY(id),
FOREIGN KEY(album_id) REFERENCES Album(id)
);

INSERT INTO AlbumGenre (album_id, genre)
SELECT DISTINCT a.id, p.genre
FROM public.project7 as p, Album as a
WHERE a.title = p.album_title;

CREATE TABLE Track(
name text,
number text,
album_id integer,
FOREIGN KEY(album_id) REFERENCES Album(id),
PRIMARY KEY(name, number, album_id)
);

INSERT INTO Track(name, number, album_id)
SELECT DISTINCT track_name, track_number, a.id
FROM public.project7 AS p
JOIN Album AS a ON a.title = p.album_title;


/* the Questions and answers */
/*Get all members of The Who and their begin/end years with the group ordered by their starting year and name.*/
SELECT a.name, m.member_begin, m.member_end
FROM Members AS m, Artist as a
WHERE (a.id) IN 
(SELECT m.member_id
FROM Members AS m, Artist as a
WHERE a.name = 'The Who' and a.id = m.artist_id) AND a.id = m.member_id order by m.member_begin,a.name;

/*Get all groups that Chris Thile has been a part of*/
SELECT name 
FROM artist 
WHERE (id) IN 
(SELECT artist_id 
From members as m, artist as a 
Where a.name = 'Chris Thile' AND a.id = m.member_id);

/*Get all albums (album, year, artist, and label) that Chris Thile has performed on, ordered by year:*/
SELECT DISTINCT a.title, a.year, t.name, l.name
FROM Album as a, Artist as t, Label as l, Members as m
WHERE 
l.id = a.label_id 
AND
t.id = a.artist_id
AND
(t.id) IN 
(
SELECT artist_id from members where (member_id) IN (SELECT ID FROM artist WHERE name = 'Chris Thile')
UNION
SELECT id FROM Artist WHERE name = 'Chris Thile' 
)
ORDER BY a.year;

/*Get all albums (artist, album, year) in the 'electronica' genre ordered by year, artist:*/
SELECT t.name, a.title, a.year
FROM Album as a
JOIN Artist as t ON t.id = a.artist_id
JOIN AlbumGenre as g ON a.id = album_id WHERE g.genre = 'electronica'
ORDER BY a.year;

/*Get all the tracks on Led Zeppelin's Houses of the Holy in order by track number:*/
SELECT t.name, t.number
FROM Track as t
WHERE (album_id) IN (SELECT Album.id FROM Album WHERE Album.title = 'Houses of the Holy')
ORDER BY t.number; 

/*Get all genres that James Taylor has performed in:*/
SELECT DISTINCT genre
FROM AlbumGenre as g, Album as a, Artist as t
WHERE 
g.album_id = a.id
AND
a.artist_id = t.id
AND
t.name = 'James Taylor';

/*Get all albums published by a label headquartered in Hollywood:*/
SELECT t.name, a.title, a.year, l.name
FROM Artist as t, Album as a, label as l
WHERE
(l.id) IN (SELECT id FROM label WHERE location = 'Hollywood')
AND 
a.label_id = l.id
AND
t.id = a.artist_id
ORDER BY a.year DESC;
