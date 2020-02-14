CREATE TABLE Team (
	id	SERIAL PRIMARY KEY,
	team_api_id	INTEGER UNIQUE,
    team_fifa_api_id	INTEGER,
	team_long_name	TEXT,
	team_short_name	TEXT
);

COPY Team FROM '/home/pratyush/Downloads/Project 1/Tables/Team.csv' DELIMITER ',' CSV HEADER;

--DROP TABLE Team;