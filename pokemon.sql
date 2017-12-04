\encoding utf8

DROP TABLE IF EXISTS generations;
DROP TABLE IF EXISTS moves;
DROP TABLE IF EXISTS pokemon;
DROP TABLE IF EXISTS pokemon_location_happiness;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS pokemon_types;

CREATE TABLE generations(
id integer,
main_region_id integer,
name text
);

\copy generations FROM 'Downloaded csvs/generations.csv' DELIMITER ',' CSV HEADER;


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

CREATE TABLE pokemon_types(
pokemon_id integer,
type_id integer,
slot integer
); 
\copy pokemon_types FROM 'Downloaded csvs/pokemon_types.csv' DELIMITER ',' CSV HEADER; 


/*how many pokemon in each region?*/

\copy (SELECT regions.name, numbers FROM (SELECT generation_id, COUNT(generation_id) AS numbers FROM pokemon_location_happiness GROUP BY generation_id ORDER BY generation_id) AS created, regions, generations WHERE generations.id = created.generation_id AND generations.main_region_id = regions.id ORDER BY numbers DESC) TO 'new csvs/how many pokemon in each region.csv' DELIMITER ',' CSV HEADER;

/* power vs accuracy of moves*/
\copy (SELECT power, accuracy FROM moves WHERE power IS NOT NULL AND accuracy IS NOT NULL) TO 'new csvs/power vs accuracy of moves.csv' DELIMITER ',' CSV HEADER;
/* which type of moves are most powerful*/
\copy (SELECT types.name, average FROM (SELECT type_id, AVG(power) as average FROM moves GROUP BY type_id) as created, types WHERE created.type_id = types.id ORDER BY average DESC) TO 'new csvs/which type of moves are most powerful.csv' DELIMITER ',' CSV HEADER;

/*which type of pokemon are most common*/
\copy (SELECT types.name, counter FROM (SELECT type_id, COUNT(type_id) as counter from  pokemon_types group by type_id) as created, types WHERE created.type_id = types.id ORDER BY counter DESC) TO 'new csvs/which type of pokemon are most common.csv' DELIMITER ',' CSV HEADER;

/*which pokemon type is the least friendly?*/
\copy (SELECT types.name, AVG(average) AS new_average FROM (SELECT pokemon_types.type_id, AVG(base_happiness) as average FROM pokemon, pokemon_location_happiness,pokemon_types WHERE pokemon.id = pokemon_location_happiness.id  AND pokemon_location_happiness.id = pokemon_types.pokemon_id GROUP BY pokemon_types.type_id) as created,types GROUP BY types.name ORDER BY new_average DESC) TO 'new csvs/which pokemon type is the least friendly.csv' DELIMITER ',' CSV HEADER;

