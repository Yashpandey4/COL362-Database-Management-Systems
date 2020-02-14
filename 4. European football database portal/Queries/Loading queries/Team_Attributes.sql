CREATE TABLE Team_Attributes (
id SERIAL PRIMARY KEY,
team_fifa_api_id INTEGER,
team_api_id INTEGER,
date TEXT,
buildUpPlaySpeed INTEGER,
buildUpPlaySpeedClass TEXT,
buildUpPlayDribbling INTEGER,
buildUpPlayDribblingClass TEXT,
buildUpPlayPassing INTEGER,
buildUpPlayPassingClass TEXT,
buildUpPlayPositioningClass TEXT,
chanceCreationPassing INTEGER,
chanceCreationPassingClass TEXT,
chanceCreationCrossing INTEGER,
chanceCreationCrossingClass TEXT,
chanceCreationShooting INTEGER,
chanceCreationShootingClass TEXT,
chanceCreationPositioningClass TEXT,
defencePressure INTEGER,
defencePressureClass TEXT,
defenceAggression INTEGER,
defenceAggressionClass TEXT,
defenceTeamWidth INTEGER,
defenceTeamWidthClass TEXT,
defenceDefenderLineClass TEXT,
-- FOREIGN KEY(team_fifa_api_id) REFERENCES Team(team_fifa_api_id), (there is no unique constraint matching given keys for referenced table "team")
FOREIGN KEY(team_api_id) REFERENCES Team(team_api_id) ON DELETE CASCADE ON UPDATE CASCADE
);

COPY Team_Attributes FROM '/home/pratyush/Downloads/Project 1/Tables/Team_Attributes.csv' DELIMITER ',' CSV HEADER;

-- DROP TABLE Team_Attributes;