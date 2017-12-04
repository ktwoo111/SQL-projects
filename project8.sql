\encoding utf8
DROP TABLE IF EXISTS anime;

CREATE TABLE anime(
anime_id integer,
name text,
genre text,
type text,
episodes text,
rating numeric(4,2),
members integer,
PRIMARY KEY(anime_id)
);

\copy anime(anime_id,name,genre,type,episodes,rating,members) FROM 'anime.csv' DELIMITER ',' CSV HEADER;

DELETE from anime WHERE genre like '%Hentai%';
