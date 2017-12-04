\encoding utf8

DROP TABLE IF EXISTS generation;
DROP TABLE IF EXISTS moves;
DROP TABLE IF EXISTS pokemon;
DROP TABLE IF EXISTS pokemon_location_happiness;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS types;

CREATE TABLE generation(
id integer,
main_region_id integer,
identifier text
);

\copy generation FROM 'Downloaded csvs/generations.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE moves (
id integer,
name text,
generation_id integer,
type_id integer,
power integer,
pp integer,
accuracy integer
);

\copy moves FROM 'Downloaded csvs/moves.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE pokemon (
id integer,
name text,
species_id integer
);
\copy pokemon FROM 'Downloaded csvs/pokemon.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE pokemon_location_happiness (
id integer,
name text,
generation_id integer,
habitat_id integer,
base_happiness integer
);
\copy pokemon_location_happiness FROM 'Downloaded csvs/pokemon_species.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE regions (
id integer,
name text
);

\copy regions FROM 'Downloaded csvs/regions.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE types(
id integer,
name text,
generation_id integer,
damage_class_id integer

);
\copy types FROM 'Downloaded csvs/types.csv' DELIMITER ',' CSV HEADER; 