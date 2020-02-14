-- Search accessing player attributes

SELECT 
--p.player_name,
*,
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born"
--2019-(CAST(coalesce(year_born, '0') AS integer))) AS "player_age",
--2019::int-born AS "player_age" from (select EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int as "born"),
--pa.overall_rating,pa.potential,pa.preferred_foot,pa.attacking_work_rate,pa.defensive_work_rate,pa.crossing,pa.finishing,pa.heading_accuracy,pa.short_passing,pa.volleys,pa.dribbling,pa.curve,pa.free_kick_accuracy,pa.long_passing,pa.ball_control,pa.acceleration,pa.sprint_speed,pa.agility,pa.reactions,pa.balance,pa.shot_power,pa.jumping,pa.stamina,pa.strength,pa.long_shots,pa.aggression,pa.interceptions,pa.positioning,pa.vision,pa.penalties,pa.marking,pa.standing_tackle,pa.sliding_tackle,pa.gk_diving,pa.gk_handling,pa.gk_kicking,pa.gk_positioning,pa.gk_reflexes
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
--WHERE (Insert Sorting Attribute here > Insert threshhold value)
ORDER BY p.player_name
LIMIT 10
;