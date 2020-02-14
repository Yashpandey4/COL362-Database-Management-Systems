CREATE TABLE Country (
	 id 	SERIAL PRIMARY KEY,
	 name 	TEXT UNIQUE);

COPY Country FROM '/home/pratyush/Downloads/Project 1/Tables/Country.csv' DELIMITER ',' CSV HEADER;

--DROP TABLE Country;