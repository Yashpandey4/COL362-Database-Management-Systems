--Checks and default values

ALTER TABLE Player_Attributes
ALTER COLUMN date SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN crossing	SET DEFAULT 50,
ALTER COLUMN	finishing	SET DEFAULT 50,
ALTER COLUMN	heading_accuracy	SET DEFAULT 50,
ALTER COLUMN	short_passing	SET DEFAULT 50,
ALTER COLUMN	volleys	SET DEFAULT 50,
ALTER COLUMN	dribbling	SET DEFAULT 50,
ALTER COLUMN	curve	SET DEFAULT 50,
ALTER COLUMN	free_kick_accuracy	SET DEFAULT 50,
ALTER COLUMN	long_passing	SET DEFAULT 50,
ALTER COLUMN	ball_control	SET DEFAULT 50,
ALTER COLUMN	acceleration	SET DEFAULT 50,
ALTER COLUMN	sprint_speed	SET DEFAULT 50,
ALTER COLUMN	agility	SET DEFAULT 50,
ALTER COLUMN	reactions	SET DEFAULT 50,
ALTER COLUMN	balance	SET DEFAULT 50,
ALTER COLUMN	shot_power	SET DEFAULT 50,
ALTER COLUMN	jumping	SET DEFAULT 50,
ALTER COLUMN	stamina	SET DEFAULT 50,
ALTER COLUMN	strength	SET DEFAULT 50,
ALTER COLUMN	long_shots	SET DEFAULT 50,
ALTER COLUMN	aggression	SET DEFAULT 50,
ALTER COLUMN	interceptions	SET DEFAULT 50,
ALTER COLUMN	positioning	SET DEFAULT 50,
ALTER COLUMN	vision	SET DEFAULT 50,
ALTER COLUMN	penalties	SET DEFAULT 50,
ALTER COLUMN	marking	SET DEFAULT 50,
ALTER COLUMN	standing_tackle	SET DEFAULT 50,
ALTER COLUMN	sliding_tackle	SET DEFAULT 50,
ALTER COLUMN	gk_diving	SET DEFAULT 50,
ALTER COLUMN	gk_handling	SET DEFAULT 50,
ALTER COLUMN	gk_kicking	SET DEFAULT 50,
ALTER COLUMN	gk_positioning	SET DEFAULT 50,
ALTER COLUMN	gk_reflexes	SET DEFAULT 50,
ALTER COLUMN overall_rating SET DEFAULT 50,
ALTER COLUMN potential SET DEFAULT 50,
ALTER COLUMN preferred_foot SET DEFAULT NULL,
ALTER COLUMN attacking_work_rate SET DEFAULT NULL,
ALTER COLUMN defensive_work_rate SET DEFAULT NULL,
--DROP CONSTRAINT player_check,
ADD CONSTRAINT player_check CHECK (
    overall_rating >=0 AND overall_rating <=100
AND potential >=0 AND potential <=100
AND crossing >=0 AND crossing <=100
AND finishing >=0 AND finishing <=100
AND heading_accuracy >=0 AND heading_accuracy <=100
AND short_passing >=0 AND short_passing <=100
AND volleys >=0 AND volleys <=100
AND dribbling >=0 AND dribbling <=100
AND curve >=0 AND curve <=100
AND free_kick_accuracy >=0 AND free_kick_accuracy <=100
AND long_passing >=0 AND long_passing <=100
AND ball_control >=0 AND ball_control <=100
AND acceleration >=0 AND acceleration <=100
AND sprint_speed >=0 AND sprint_speed <=100
AND agility >=0 AND agility <=100
AND reactions >=0 AND reactions <=100
AND balance >=0 AND balance <=100
AND shot_power >=0 AND shot_power <=100
AND jumping >=0 AND jumping <=100
AND stamina >=0 AND stamina <=100
AND strength >=0 AND strength <=100
AND long_shots >=0 AND long_shots <=100
AND aggression >=0 AND aggression <=100
AND interceptions >=0 AND interceptions <=100
AND positioning >=0 AND positioning <=100
AND vision >=0 AND vision <=100
AND penalties >=0 AND penalties <=100
AND marking >=0 AND marking <=100
AND standing_tackle >=0 AND standing_tackle <=100
AND sliding_tackle >=0 AND sliding_tackle <=100
AND gk_diving >=0 AND gk_diving <=100
AND gk_handling >=0 AND gk_handling <=100
AND gk_kicking >=0 AND gk_kicking <=100
AND gk_positioning >=0 AND gk_positioning <=100
AND gk_reflexes >=0 AND gk_reflexes <=100
AND (preferred_foot IN ('left', 'right', ''))
-- AND (attacking_work_rate IN ('high', 'medium', 'low', 'le', 'None', ''))
-- AND (defensive_work_rate IN ('high', 'medium', 'low', '_0', '5', '1', 'o', 'ormal', '7', 'None', ''))
)
;

ALTER TABLE Player
ALTER COLUMN birthday SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN height SET DEFAULT 170.0,
ALTER COLUMN weight SET DEFAULT 160.0
;

ALTER TABLE Team
ALTER COLUMN team_long_name SET DEFAULT NULL,
ALTER COLUMN team_short_name SET DEFAULT NULL
;

ALTER TABLE Country
ALTER COLUMN name SET DEFAULT NULL
;

ALTER TABLE League
ALTER COLUMN name SET DEFAULT NULL
;

ALTER TABLE Team_Attributes
ALTER COLUMN date SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN buildUpPlaySpeed SET DEFAULT 50,
ALTER COLUMN buildUpPlaySpeedClass SET DEFAULT NULL,
ALTER COLUMN buildUpPlayDribbling SET DEFAULT 50,
ALTER COLUMN buildUpPlayDribblingClass SET DEFAULT NULL,
ALTER COLUMN buildUpPlayPassing SET DEFAULT 50,
ALTER COLUMN buildUpPlayPassingClass SET DEFAULT NULL,
ALTER COLUMN buildUpPlayPositioningClass SET DEFAULT NULL,
ALTER COLUMN chanceCreationPassing SET DEFAULT 50,
ALTER COLUMN chanceCreationPassingClass SET DEFAULT NULL,
ALTER COLUMN chanceCreationCrossing SET DEFAULT 50,
ALTER COLUMN chanceCreationCrossingClass SET DEFAULT NULL,
ALTER COLUMN chanceCreationShooting SET DEFAULT 50,
ALTER COLUMN chanceCreationShootingClass SET DEFAULT NULL,
ALTER COLUMN chanceCreationPositioningClass SET DEFAULT NULL,
ALTER COLUMN defencePressure SET DEFAULT 50,
ALTER COLUMN defencePressureClass SET DEFAULT NULL,
ALTER COLUMN defenceAggression SET DEFAULT 50,
ALTER COLUMN defenceAggressionClass SET DEFAULT NULL,
ALTER COLUMN defenceTeamWidth SET DEFAULT 50,
ALTER COLUMN defenceTeamWidthClass SET DEFAULT NULL,
ALTER COLUMN defenceDefenderLineClass SET DEFAULT NULL,
--DROP CONSTRAINT team_check,
ADD CONSTRAINT team_check CHECK (
    buildUpPlaySpeed >=0 AND buildUpPlaySpeed <=100
AND buildUpPlaySpeed >=0 AND buildUpPlaySpeed <=100
AND buildUpPlayDribbling >=0 AND buildUpPlayDribbling <=100
AND buildUpPlayPassing >=0 AND buildUpPlayPassing <=100
AND chanceCreationPassing >=0 AND chanceCreationPassing <=100
AND chanceCreationCrossing >=0 AND chanceCreationCrossing <=100
AND chanceCreationShooting >=0 AND chanceCreationShooting <=100
AND defencePressure >=0 AND defencePressure <=100
AND defenceAggression >=0 AND defenceAggression <=100
AND defenceTeamWidth >=0 AND defenceTeamWidth <=100
AND (buildUpPlaySpeedClass IN ('Balanced','Slow','Fast'))
AND (buildUpPlayDribblingClass IN ('Lots','Little','Normal'))
AND (buildUpPlayPassingClass IN ('Long','Short','Mixed'))
AND (buildUpPlayPositioningClass IN ('Free Form','Organised'))
AND (chanceCreationPassingClass IN ('Safe','Risky', 'Normal'))
AND (chanceCreationCrossingClass IN ('Lots','Little','Normal'))
AND (chanceCreationShootingClass IN ('Lots','Little','Normal'))
AND (chanceCreationPositioningClass IN ('Free Form','Organised'))
AND (defencePressureClass IN ('High','Deep','Medium'))
AND (defenceAggressionClass IN ('Contain','Double','Press'))
AND (defenceTeamWidthClass IN ('Narrow','Normal','Wide'))
AND (defenceDefenderLineClass IN ('Cover','Offside Trap'))
)
;


ALTER TABLE Match
--DROP CONSTRAINT match_check,
ALTER COLUMN date SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN home_team_goal SET DEFAULT 0,
ALTER COLUMN away_team_goal SET DEFAULT 0,
ALTER COLUMN home_player_X1 SET DEFAULT 0,
ALTER COLUMN home_player_X2 SET DEFAULT 0,
ALTER COLUMN home_player_X3 SET DEFAULT 0,
ALTER COLUMN home_player_X4 SET DEFAULT 0,
ALTER COLUMN home_player_X5 SET DEFAULT 0,
ALTER COLUMN home_player_X6 SET DEFAULT 0,
ALTER COLUMN home_player_X7 SET DEFAULT 0,
ALTER COLUMN home_player_X8 SET DEFAULT 0,
ALTER COLUMN home_player_X9 SET DEFAULT 0,
ALTER COLUMN home_player_X10 SET DEFAULT 0,
ALTER COLUMN home_player_X11 SET DEFAULT 0,
ALTER COLUMN away_player_X1 SET DEFAULT 0,
ALTER COLUMN away_player_X2 SET DEFAULT 0,
ALTER COLUMN away_player_X3 SET DEFAULT 0,
ALTER COLUMN away_player_X4 SET DEFAULT 0,
ALTER COLUMN away_player_X5 SET DEFAULT 0,
ALTER COLUMN away_player_X6 SET DEFAULT 0,
ALTER COLUMN away_player_X7 SET DEFAULT 0,
ALTER COLUMN away_player_X8 SET DEFAULT 0,
ALTER COLUMN away_player_X9 SET DEFAULT 0,
ALTER COLUMN away_player_X10 SET DEFAULT 0,
ALTER COLUMN away_player_X11 SET DEFAULT 0,
ALTER COLUMN home_player_Y1 SET DEFAULT 0,
ALTER COLUMN home_player_Y2 SET DEFAULT 0,
ALTER COLUMN home_player_Y3 SET DEFAULT 0,
ALTER COLUMN home_player_Y4 SET DEFAULT 0,
ALTER COLUMN home_player_Y5 SET DEFAULT 0,
ALTER COLUMN home_player_Y6 SET DEFAULT 0,
ALTER COLUMN home_player_Y7 SET DEFAULT 0,
ALTER COLUMN home_player_Y8 SET DEFAULT 0,
ALTER COLUMN home_player_Y9 SET DEFAULT 0,
ALTER COLUMN home_player_Y10 SET DEFAULT 0,
ALTER COLUMN home_player_Y11 SET DEFAULT 0,
ALTER COLUMN away_player_Y1 SET DEFAULT 0,
ALTER COLUMN away_player_Y2 SET DEFAULT 0,
ALTER COLUMN away_player_Y3 SET DEFAULT 0,
ALTER COLUMN away_player_Y4 SET DEFAULT 0,
ALTER COLUMN away_player_Y5 SET DEFAULT 0,
ALTER COLUMN away_player_Y6 SET DEFAULT 0,
ALTER COLUMN away_player_Y7 SET DEFAULT 0,
ALTER COLUMN away_player_Y8 SET DEFAULT 0,
ALTER COLUMN away_player_Y9 SET DEFAULT 0,
ALTER COLUMN away_player_Y10 SET DEFAULT 0,
ALTER COLUMN away_player_Y11 SET DEFAULT 0,
ALTER COLUMN B365H SET DEFAULT 0.0,
ALTER COLUMN B365D SET DEFAULT 0.0,
ALTER COLUMN B365A SET DEFAULT 0.0,
ALTER COLUMN BWH SET DEFAULT 0.0,
ALTER COLUMN BWD SET DEFAULT 0.0,
ALTER COLUMN BWA SET DEFAULT 0.0,
ALTER COLUMN IWH SET DEFAULT 0.0,
ALTER COLUMN IWD SET DEFAULT 0.0,
ALTER COLUMN IWA SET DEFAULT 0.0,
ALTER COLUMN LBH SET DEFAULT 0.0,
ALTER COLUMN LBD SET DEFAULT 0.0,
ALTER COLUMN LBA SET DEFAULT 0.0,
ALTER COLUMN PSH SET DEFAULT 0.0,
ALTER COLUMN PSD SET DEFAULT 0.0,
ALTER COLUMN PSA SET DEFAULT 0.0,
ALTER COLUMN WHH SET DEFAULT 0.0,
ALTER COLUMN WHD SET DEFAULT 0.0,
ALTER COLUMN WHA SET DEFAULT 0.0,
ALTER COLUMN SJH SET DEFAULT 0.0,
ALTER COLUMN SJD SET DEFAULT 0.0,
ALTER COLUMN SJA SET DEFAULT 0.0,
ALTER COLUMN VCH SET DEFAULT 0.0,
ALTER COLUMN VCD SET DEFAULT 0.0,
ALTER COLUMN VCA SET DEFAULT 0.0,
ALTER COLUMN GBH SET DEFAULT 0.0,
ALTER COLUMN GBD SET DEFAULT 0.0,
ALTER COLUMN GBA SET DEFAULT 0.0,
ALTER COLUMN BSH SET DEFAULT 0.0,
ALTER COLUMN BSD SET DEFAULT 0.0,
ALTER COLUMN BSA SET DEFAULT 0.0,
ALTER COLUMN goal SET DEFAULT NULL,
ALTER COLUMN shoton SET DEFAULT NULL,
ALTER COLUMN shotoff SET DEFAULT NULL,
ALTER COLUMN foulcommit SET DEFAULT NULL,
ALTER COLUMN card SET DEFAULT NULL,
ALTER COLUMN "cross" SET DEFAULT NULL,
ALTER COLUMN corner SET DEFAULT NULL,
ALTER COLUMN possession SET DEFAULT NULL,
ALTER COLUMN season SET DEFAULT '2015/2016',
ALTER COLUMN stage SET DEFAULT 1,
--DROP CONSTRAINT match_check,
ADD CONSTRAINT match_check CHECK (
    home_team_goal >=0
AND away_team_goal >=0
AND home_player_X1 >=0
AND home_player_X2 >=0
AND home_player_X3 >=0
AND home_player_X4 >=0
AND home_player_X5 >=0
AND home_player_X6 >=0
AND home_player_X7 >=0
AND home_player_X8 >=0
AND home_player_X9 >=0
AND home_player_X10 >=0
AND home_player_X11 >=0
AND away_player_X1 >=0
AND away_player_X2 >=0
AND away_player_X3 >=0
AND away_player_X4 >=0
AND away_player_X5 >=0
AND away_player_X6 >=0
AND away_player_X7 >=0
AND away_player_X8 >=0
AND away_player_X9 >=0
AND away_player_X10 >=0
AND away_player_X11 >=0
AND home_player_Y1 >=0
AND home_player_Y2 >=0
AND home_player_Y3 >=0
AND home_player_Y4 >=0
AND home_player_Y5 >=0
AND home_player_Y6 >=0
AND home_player_Y7 >=0
AND home_player_Y8 >=0
AND home_player_Y9 >=0
AND home_player_Y10 >=0
AND home_player_Y11 >=0
AND away_player_Y1 >=0
AND away_player_Y2 >=0
AND away_player_Y3 >=0
AND away_player_Y4 >=0
AND away_player_Y5 >=0
AND away_player_Y6 >=0
AND away_player_Y7 >=0
AND away_player_Y8 >=0
AND away_player_Y9 >=0
AND away_player_Y10 >=0
AND away_player_Y11 >=0
AND B365H >=0.0
AND B365D >=0.0
AND B365A >=0.0
AND BWH >=0.0
AND BWD >=0.0
AND BWA >=0.0
AND IWH >=0.0
AND IWD >=0.0
AND IWA >=0.0
AND LBH >=0.0
AND LBD >=0.0
AND LBA >=0.0
AND PSH >=0.0
AND PSD >=0.0
AND PSA >=0.0
AND WHH >=0.0
AND WHD >=0.0
AND WHA >=0.0
AND SJH >=0.0
AND SJD >=0.0
AND SJA >=0.0
AND VCH >=0.0
AND VCD >=0.0
AND VCA >=0.0
AND GBH >=0.0
AND GBD >=0.0
AND GBA >=0.0
AND BSH >=0.0
AND BSD >=0.0
AND BSA >=0.0
AND (season IN ('2012/2013', '2010/2011', '2013/2014' , '2015/2016',  '2008/2009' , '2014/2015'  ,'2011/2012', '2009/2010'))
AND stage>0 AND stage<=40) --38 max stage in data)
;


