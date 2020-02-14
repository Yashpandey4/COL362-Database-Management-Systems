-- Load these at end

ALTER TABLE Match
ADD FOREIGN KEY(country_id) REFERENCES country(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY(league_id) REFERENCES League(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY(home_team_api_id) REFERENCES Team(team_api_id),
ADD FOREIGN KEY(away_team_api_id) REFERENCES Team(team_api_id),
ADD FOREIGN KEY(home_player_1) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_2) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_3) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_4) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_5) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_6) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_7) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_8) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_9) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_10) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(home_player_11) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_1) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_2) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_3) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_4) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_5) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_6) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_7) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_8) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_9) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_10) REFERENCES Player(player_api_id),
ADD FOREIGN KEY(away_player_11) REFERENCES Player(player_api_id)
;

-- ALTER TABLE team_attributes
-- ADD FOREIGN KEY(team_api_id) REFERENCES Team(team_api_id) ON DELETE CASCADE ON UPDATE CASCADE
-- ;

-- ALTER TABLE league
-- ADD FOREIGN KEY(country_id) REFERENCES country(id) ON DELETE CASCADE ON UPDATE CASCADE
-- ;