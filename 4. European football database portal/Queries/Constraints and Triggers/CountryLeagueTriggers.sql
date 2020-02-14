
--League triggers, assuming country present in Country table
-- insert into League (country_id, name) values ((select id from country where name = 'Spain') , 'kamaalClub');
-- delete from League where name='kamaalClub';

-- -- create a new player

-- insert into player (player_name, player_fifa_api_id, birthday, height, weight) values(player_name, null, null ,null ,null);
-- delete from player where player_name=player_name;

-- -- start assigning player attributes (assume player_name inputted)
-- CREATE TRIGGER playerstat_newplayer
-- BEFORE INSERT ON Player_Attributes
-- WHEN player_name NOT IN Player.player_name
-- EXECUTE PROCEDURE
-- insert into player (player_name, player_fifa_api_id, birthday, height, weight) values($1, null, null ,null ,null)
-- ;


-- -- create a new team (assume team_name_short, team_name_long inputted as $2, $1)

-- insert into team (team_long_name, team_short_name) values($1,$2);
-- delete from team where team_long_name=$1 OR team_short_name=$2;

-- -- start assigning team attributes (assume team_name_short, team_name_long inputted)

-- CREATE TRIGGER teamstat_newteam
-- BEFORE INSERT ON Team_Attributes
-- WHEN $1 NOT IN Team.team_long_name OR $2 NOT IN Team.team_short_name
-- EXECUTE PROCEDURE
-- insert into team (team_long_name, team_short_name) values($1,$2)
-- ;

-- UPDATION triggers

--update class on updating buildUpPlaySpeed

CREATE OR REPLACE FUNCTION upd_buildUpPlaySpeedClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.buildUpPlaySpeed >=67 THEN
NEW.buildUpPlaySpeedClass = 'Fast';
ELSEIF NEW.buildUpPlaySpeed>=34 THEN
NEW.buildUpPlaySpeedClass = 'Balanced';
ELSEIF NEW.buildUpPlaySpeed>=0 THEN
NEW.buildUpPlaySpeedClass = 'Slow';
ELSE
NEW.buildUpPlaySpeed = OLD.buildUpPlaySpeed;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_buildUpPlaySpeed 
AFTER UPDATE OF buildUpPlaySpeed 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_buildUpPlaySpeedClass();

--update class on updating buildUpPlayDribbling

CREATE OR REPLACE FUNCTION upd_buildUpPlayDribblingClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.buildUpPlayDribbling >=67 THEN
NEW.buildUpPlayDribblingClass = 'Lots';
ELSEIF NEW.buildUpPlayDribbling>=34 THEN
NEW.buildUpPlayDribblingClass = 'Little';
ELSEIF NEW.buildUpPlayDribbling>=0 THEN
NEW.buildUpPlayDribblingClass = 'Normal';
ELSE
NEW.buildUpPlayDribbling = OLD.buildUpPlayDribbling;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_buildUpPlayDribbling 
AFTER UPDATE OF buildUpPlayDribbling 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_buildUpPlayDribblingClass();

--update class on updating buildUpPlayPassing

CREATE OR REPLACE FUNCTION upd_buildUpPlayPassingClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.buildUpPlayPassing >=67 THEN
NEW.buildUpPlayPassingClass = 'Long';
ELSEIF NEW.buildUpPlayPassing>=34 THEN
NEW.buildUpPlayPassingClass = 'Mixed';
ELSEIF NEW.buildUpPlayPassing>=0 THEN
NEW.buildUpPlayPassingClass = 'Short';
ELSE
NEW.buildUpPlayPassing = OLD.buildUpPlayPassing;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_buildUpPlayPassing 
AFTER UPDATE OF buildUpPlayPassing 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_buildUpPlayPassingClass();

--update class on updating chanceCreationPassing

CREATE OR REPLACE FUNCTION upd_chanceCreationPassingClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.chanceCreationPassing >=67 THEN
NEW.chanceCreationPassingClass = 'Free Form';
ELSEIF NEW.chanceCreationPassing>=34 THEN
NEW.chanceCreationPassingClass = 'Organised';
ELSE
NEW.chanceCreationPassing = OLD.chanceCreationPassing;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_chanceCreationPassing 
AFTER UPDATE OF chanceCreationPassing 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_chanceCreationPassingClass();

--update class on updating chanceCreationCrossing

CREATE OR REPLACE FUNCTION upd_chanceCreationCrossingClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.chanceCreationCrossing >=67 THEN
NEW.chanceCreationCrossingClass = 'Safe';
ELSEIF NEW.chanceCreationCrossing>=34 THEN
NEW.chanceCreationCrossingClass = 'Normal';
ELSEIF NEW.chanceCreationCrossing>=0 THEN
NEW.chanceCreationCrossingClass = 'Risky';
ELSE
NEW.chanceCreationCrossing = OLD.chanceCreationCrossing;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_chanceCreationCrossing 
AFTER UPDATE OF chanceCreationCrossing 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_chanceCreationCrossingClass();

--update class on updating chanceCreationShooting

CREATE OR REPLACE FUNCTION upd_chanceCreationShootingClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.chanceCreationShooting >=67 THEN
NEW.chanceCreationShootingClass = 'Free From';
ELSEIF NEW.chanceCreationShooting>=34 THEN
NEW.chanceCreationShootingClass = 'Organised';
ELSE
NEW.chanceCreationShooting = OLD.chanceCreationShooting;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_chanceCreationShooting 
AFTER UPDATE OF chanceCreationShooting 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_chanceCreationShootingClass();

--update class on updating defencePressure

CREATE OR REPLACE FUNCTION upd_defencePressureClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.defencePressure >=67 THEN
NEW.defencePressureClass = 'High';
ELSEIF NEW.defencePressure>=34 THEN
NEW.defencePressureClass = 'Deep';
ELSEIF NEW.defencePressure>=0 THEN
NEW.defencePressureClass = 'Medium';
ELSE
NEW.defencePressure = OLD.defencePressure;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_defencePressure 
AFTER UPDATE OF defencePressure 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_defencePressureClass();

--update class on updating defenceAggression

CREATE OR REPLACE FUNCTION upd_defenceAggressionClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.defenceAggression >=67 THEN
NEW.defenceAggressionClass = 'Contain';
ELSEIF NEW.defenceAggression>=34 THEN
NEW.defenceAggressionClass = 'Double';
ELSEIF NEW.defenceAggression>=0 THEN
NEW.defenceAggressionClass = 'Pressed';
ELSE
NEW.defenceAggression = OLD.defenceAggression;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_defenceAggression 
AFTER UPDATE OF defenceAggression 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_defenceAggressionClass();

--update class on updating defenceTeamWidth

CREATE OR REPLACE FUNCTION upd_defenceTeamWidthClass()
RETURNS trigger AS
$$
BEGIN
IF NEW.defenceTeamWidth >=67 THEN
NEW.defenceTeamWidthClass = 'Cover';
ELSEIF NEW.defenceTeamWidth>=34 THEN
NEW.defenceTeamWidthClass = 'Offside Trap';
ELSE
NEW.defenceTeamWidth = OLD.defenceTeamWidth;
END IF;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_defenceTeamWidth 
AFTER UPDATE OF defenceTeamWidth 
ON Team_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_defenceTeamWidthClass();


--update overall ratings on updating potential
CREATE OR REPLACE FUNCTION upd_overallRatings_potential()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.potential - OLD.potential)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_potential 
AFTER UPDATE OF potential
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_potential();


--update overall ratings on updating crossing
CREATE OR REPLACE FUNCTION upd_overallRatings_crossing()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.crossing - OLD.crossing)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_crossing 
AFTER UPDATE OF crossing
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_crossing();

--update overall ratings on updating finishing
CREATE OR REPLACE FUNCTION upd_overallRatings_finishing()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.finishing - OLD.finishing)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_finishing 
AFTER UPDATE OF finishing
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_finishing();

--update overall ratings on updating heading_accuracy
CREATE OR REPLACE FUNCTION upd_overallRatings_heading_accuracy()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.heading_accuracy - OLD.heading_accuracy)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_heading_accuracy 
AFTER UPDATE OF heading_accuracy
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_heading_accuracy();

--update overall ratings on updating short_passing
CREATE OR REPLACE FUNCTION upd_overallRatings_short_passing()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.short_passing - OLD.short_passing)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_short_passing 
AFTER UPDATE OF short_passing
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_short_passing();

--update overall ratings on updating volleys
CREATE OR REPLACE FUNCTION upd_overallRatings_volleys()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.volleys - OLD.volleys)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_volleys 
AFTER UPDATE OF volleys
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_volleys();

--update overall ratings on updating dribbling
CREATE OR REPLACE FUNCTION upd_overallRatings_dribbling()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.dribbling - OLD.dribbling)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_dribbling 
AFTER UPDATE OF dribbling
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_dribbling();

--update overall ratings on updating curve
CREATE OR REPLACE FUNCTION upd_overallRatings_curve()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.curve - OLD.curve)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_curve 
AFTER UPDATE OF curve
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_curve();

--update overall ratings on updating free_kick_accuracy
CREATE OR REPLACE FUNCTION upd_overallRatings_free_kick_accuracy()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.free_kick_accuracy - OLD.free_kick_accuracy)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_free_kick_accuracy 
AFTER UPDATE OF free_kick_accuracy
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_free_kick_accuracy();

--update overall ratings on updating long_passing
CREATE OR REPLACE FUNCTION upd_overallRatings_long_passing()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.long_passing - OLD.long_passing)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_long_passing 
AFTER UPDATE OF long_passing
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_long_passing();

--update overall ratings on updating ball_control
CREATE OR REPLACE FUNCTION upd_overallRatings_ball_control()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.ball_control - OLD.ball_control)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_ball_control 
AFTER UPDATE OF ball_control
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_ball_control();

--update overall ratings on updating acceleration
CREATE OR REPLACE FUNCTION upd_overallRatings_acceleration()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.acceleration - OLD.acceleration)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_acceleration 
AFTER UPDATE OF acceleration
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_acceleration();

--update overall ratings on updating sprint_speed
CREATE OR REPLACE FUNCTION upd_overallRatings_sprint_speed()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.sprint_speed - OLD.sprint_speed)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_sprint_speed 
AFTER UPDATE OF sprint_speed
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_sprint_speed();

--update overall ratings on updating agility
CREATE OR REPLACE FUNCTION upd_overallRatings_agility()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.agility - OLD.agility)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_agility 
AFTER UPDATE OF agility
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_agility();

--update overall ratings on updating reactions
CREATE OR REPLACE FUNCTION upd_overallRatings_reactions()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.reactions - OLD.reactions)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_reactions 
AFTER UPDATE OF reactions
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_reactions();

--update overall ratings on updating balance
CREATE OR REPLACE FUNCTION upd_overallRatings_balance()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.balance - OLD.balance)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_balance 
AFTER UPDATE OF balance
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_balance();

--update overall ratings on updating shot_power
CREATE OR REPLACE FUNCTION upd_overallRatings_shot_power()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.shot_power - OLD.shot_power)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_shot_power 
AFTER UPDATE OF shot_power
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_shot_power();

--update overall ratings on updating jumping
CREATE OR REPLACE FUNCTION upd_overallRatings_jumping()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.jumping - OLD.jumping)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_jumping 
AFTER UPDATE OF jumping
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_jumping();

--update overall ratings on updating stamina
CREATE OR REPLACE FUNCTION upd_overallRatings_stamina()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.stamina - OLD.stamina)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_stamina 
AFTER UPDATE OF stamina
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_stamina();

--update overall ratings on updating strength
CREATE OR REPLACE FUNCTION upd_overallRatings_strength()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.strength - OLD.strength)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_strength 
AFTER UPDATE OF strength
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_strength();

--update overall ratings on updating long_shots
CREATE OR REPLACE FUNCTION upd_overallRatings_long_shots()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.long_shots - OLD.long_shots)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_long_shots 
AFTER UPDATE OF long_shots
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_long_shots();

--update overall ratings on updating aggression
CREATE OR REPLACE FUNCTION upd_overallRatings_aggression()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.aggression - OLD.aggression)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_aggression 
AFTER UPDATE OF aggression
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_aggression();

--update overall ratings on updating interceptions
CREATE OR REPLACE FUNCTION upd_overallRatings_interceptions()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.interceptions - OLD.interceptions)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_interceptions 
AFTER UPDATE OF interceptions
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_interceptions();

--update overall ratings on updating positioning
CREATE OR REPLACE FUNCTION upd_overallRatings_positioning()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.positioning - OLD.positioning)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_positioning 
AFTER UPDATE OF positioning
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_positioning();

--update overall ratings on updating vision
CREATE OR REPLACE FUNCTION upd_overallRatings_vision()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.vision - OLD.vision)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_vision 
AFTER UPDATE OF vision
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_vision();

--update overall ratings on updating penalties
CREATE OR REPLACE FUNCTION upd_overallRatings_penalties()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.penalties - OLD.penalties)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_penalties 
AFTER UPDATE OF penalties
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_penalties();

--update overall ratings on updating marking
CREATE OR REPLACE FUNCTION upd_overallRatings_marking()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.marking - OLD.marking)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_marking 
AFTER UPDATE OF marking
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_marking();

--update overall ratings on updating standing_tackle
CREATE OR REPLACE FUNCTION upd_overallRatings_standing_tackle()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.standing_tackle - OLD.standing_tackle)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_standing_tackle 
AFTER UPDATE OF standing_tackle
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_standing_tackle();

--update overall ratings on updating sliding_tackle
CREATE OR REPLACE FUNCTION upd_overallRatings_sliding_tackle()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.sliding_tackle - OLD.sliding_tackle)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_sliding_tackle 
AFTER UPDATE OF sliding_tackle
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_sliding_tackle();

--update overall ratings on updating gk_diving
CREATE OR REPLACE FUNCTION upd_overallRatings_gk_diving()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.gk_diving - OLD.gk_diving)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_gk_diving 
AFTER UPDATE OF gk_diving
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_gk_diving();

--update overall ratings on updating gk_handling
CREATE OR REPLACE FUNCTION upd_overallRatings_gk_handling()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.gk_handling - OLD.gk_handling)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_gk_handling 
AFTER UPDATE OF gk_handling
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_gk_handling();

--update overall ratings on updating gk_kicking
CREATE OR REPLACE FUNCTION upd_overallRatings_gk_kicking()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.gk_kicking - OLD.gk_kicking)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_gk_kicking 
AFTER UPDATE OF gk_kicking
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_gk_kicking();

--update overall ratings on updating gk_positioning
CREATE OR REPLACE FUNCTION upd_overallRatings_gk_positioning()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.gk_positioning - OLD.gk_positioning)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_gk_positioning 
AFTER UPDATE OF gk_positioning
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_gk_positioning();

--update overall ratings on updating gk_reflexes
CREATE OR REPLACE FUNCTION upd_overallRatings_gk_reflexes()
RETURNS trigger AS
$$
BEGIN
NEW.overall_rating = (((NEW.gk_reflexes - OLD.gk_reflexes)+100)/100)*OLD.overall_rating; 
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER upd_player_gk_reflexes 
AFTER UPDATE OF gk_reflexes
ON Player_Attributes
FOR EACH ROW
EXECUTE PROCEDURE upd_overallRatings_gk_reflexes();
