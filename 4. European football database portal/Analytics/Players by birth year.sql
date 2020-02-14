-- Number iof players grouped by birth year year wise

SELECT COUNT(p.player_name) AS number_of_players, 
--strftime('%Y',p.birthday) AS "year_born"
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss')) AS "year_born"
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
GROUP BY year_born;