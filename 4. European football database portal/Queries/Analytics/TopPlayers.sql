-- Top Players by overall_rating

SELECT player_name, AVG(overall_rating) AS ratings
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND overall_rating > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by potential

SELECT player_name, AVG(potential) AS potential_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND potential > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by crossing

SELECT player_name, AVG(crossing) AS crossing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND crossing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by finishing

SELECT player_name, AVG(finishing) AS finishing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND finishing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by heading_accuracy

SELECT player_name, AVG(heading_accuracy) AS heading_accuracy_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND heading_accuracy > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by short_passing

SELECT player_name, AVG(short_passing) AS short_passing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND short_passing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by volleys

SELECT player_name, AVG(volleys) AS volleys_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND volleys > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by dribbling

SELECT player_name, AVG(dribbling) AS dribbling_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND dribbling > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by curve

SELECT player_name, AVG(curve) AS curve_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND curve > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by free_kick_accuracy

SELECT player_name, AVG(free_kick_accuracy) AS free_kick_accuracy_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND free_kick_accuracy > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by long_passing

SELECT player_name, AVG(long_passing) AS long_passing_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND long_passing > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by ball_control

SELECT player_name, AVG(ball_control) AS ball_control_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND ball_control > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by acceleration

SELECT player_name, AVG(acceleration) AS acceleration_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND acceleration > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by sprint_speed

SELECT player_name, AVG(sprint_speed) AS sprint_speed_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND sprint_speed > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by agility

SELECT player_name, AVG(agility) AS agility_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND agility > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by reactions

SELECT player_name, AVG(reactions) AS reactions_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND reactions > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by balance

SELECT player_name, AVG(balance) AS balance_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND balance > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by shot_power

SELECT player_name, AVG(shot_power) AS shot_power_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND shot_power > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by jumping

SELECT player_name, AVG(jumping) AS jumping_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND jumping > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by stamina

SELECT player_name, AVG(stamina) AS stamina_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND stamina > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by strength

SELECT player_name, AVG(strength) AS strength_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND strength > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by long_shots

SELECT player_name, AVG(long_shots) AS long_shots_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND long_shots > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by aggression

SELECT player_name, AVG(aggression) AS aggression_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND aggression > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by interceptions

SELECT player_name, AVG(interceptions) AS interceptions_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND interceptions > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by positioning

SELECT player_name, AVG(positioning) AS positioning_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND positioning > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by vision

SELECT player_name, AVG(vision) AS vision_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND vision > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by penalties

SELECT player_name, AVG(penalties) AS penalties_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND penalties > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by marking

SELECT player_name, AVG(marking) AS marking_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND marking > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by standing_tackle

SELECT player_name, AVG(standing_tackle) AS standing_tackle_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND standing_tackle > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by sliding_tackle

SELECT player_name, AVG(sliding_tackle) AS sliding_tackle_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND sliding_tackle > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by gk_diving

SELECT player_name, AVG(gk_diving) AS gk_diving_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_diving > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by gk_handling

SELECT player_name, AVG(gk_handling) AS gk_handling_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_handling > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by gk_kicking

SELECT player_name, AVG(gk_kicking) AS gk_kicking_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_kicking > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by gk_positioning

SELECT player_name, AVG(gk_positioning) AS gk_positioning_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_positioning > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

--Top Players by gk_reflexes

SELECT player_name, AVG(gk_reflexes) AS gk_reflexes_avg
FROM Player, Player_Attributes
WHERE Player.player_api_id = Player_Attributes.player_api_id AND gk_reflexes > 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;
