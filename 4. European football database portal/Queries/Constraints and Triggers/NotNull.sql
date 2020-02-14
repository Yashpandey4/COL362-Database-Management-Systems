--ALTER TABLE Player_Attributes RENAME COLUMN date_stat TO date;  --fixed once then dont bother

-- NOT NULL Constraints

ALTER TABLE Country 
ALTER COLUMN id SET NOT NULL
;

ALTER TABLE League 
ALTER COLUMN id SET NOT NULL
;

ALTER TABLE Player
ALTER COLUMN id SET NOT NULL
;

ALTER TABLE Player_Attributes
ALTER COLUMN id SET NOT NULL
;

ALTER TABLE Team_Attributes
ALTER COLUMN id SET NOT NULL
;

--create proper sequences

--Player
SELECT setval('player_id_seq', 11076, FALSE);

CREATE SEQUENCE player_player_api_id_seq 
owned by player.player_api_id;
SELECT setval('player_player_api_id_seq', 750585, FALSE);
alter table player
alter column player_api_id set default nextval('player_player_api_id_seq');

CREATE SEQUENCE player_player_fifa_api_id_seq 
owned by player.player_fifa_api_id;
SELECT setval('player_player_fifa_api_id_seq',  234142, FALSE);
alter table player
alter column player_fifa_api_id set default nextval('player_player_fifa_api_id_seq');


-- country
SELECT setval('country_id_seq', 24559, FALSE);

--league
SELECT setval('league_id_seq', 24559, FALSE);

--Match
SELECT setval('match_id_seq', 25980, FALSE);

--Team
SELECT setval('team_id_seq', 51607, FALSE);

CREATE SEQUENCE team_team_api_id_seq 
owned by team.team_api_id;
SELECT setval('team_team_api_id_seq', 274582, FALSE);
alter table team
alter column team_api_id set default nextval('team_team_api_id_seq');

CREATE SEQUENCE team_team_fifa_api_id_seq 
owned by team.team_fifa_api_id;
SELECT setval('team_team_fifa_api_id_seq',  112514, FALSE);
alter table team
alter column team_fifa_api_id set default nextval('team_team_fifa_api_id_seq');


--Player_Attributes
SELECT setval('player_attributes_id_seq', 183979, FALSE);

--Team_Attributes
SELECT setval('team_attributes_id_seq', 183979, FALSE);


commit;