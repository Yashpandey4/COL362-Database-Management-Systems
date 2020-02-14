CREATE TABLE Manager (
	id	SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT UNIQUE,
    "password" TEXT,
	country_id	INTEGER,
    team_id INTEGER,
	FOREIGN KEY(country_id) REFERENCES country(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(team_id) REFERENCES team(id) ON DELETE CASCADE ON UPDATE CASCADE
);
