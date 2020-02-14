CREATE TABLE League (
	id	SERIAL PRIMARY KEY,
	country_id	INTEGER,
	name	TEXT UNIQUE,
	FOREIGN KEY(country_id) REFERENCES country(id) ON DELETE CASCADE ON UPDATE CASCADE
);

COPY League FROM '/home/pratyush/Downloads/Project 1/Tables/League.csv' DELIMITER ',' CSV HEADER;

-- DROP TABLE League;