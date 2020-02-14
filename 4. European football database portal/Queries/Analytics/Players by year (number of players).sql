-- Number of players born in the same year, which are born after 1990

SELECT 
COUNT(p.player_name) AS number_of_players, 
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born"
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
GROUP BY year_born
HAVING EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int > '1990';