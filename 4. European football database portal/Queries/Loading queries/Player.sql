CREATE TABLE Player (
	id	SERIAL PRIMARY KEY,
	player_api_id	INTEGER UNIQUE,
	player_name	TEXT,
	player_fifa_api_id	INTEGER UNIQUE,
	birthday	TEXT,
	height	NUMERIC,
	weight	NUMERIC
);

COPY Player FROM '/home/pratyush/Downloads/Project 1/Tables/Player.csv' DELIMITER ',' CSV HEADER;

--DROP TABLE Player;