-- Player info aggregates grouped by birth year

SELECT 
COUNT(p.player_name) AS number_of_players, 
EXTRACT(YEAR FROM to_timestamp(p.birthday, 'YYYY-MM-DD hh24:mi:ss'))::int AS "year_born",
MIN(pa.overall_rating) AS min_overall_rating,
MAX(pa.overall_rating) AS max_overall_rating, 
AVG(pa.overall_rating) AS average_overall_rating
FROM Player AS p
INNER JOIN Player_Attributes AS pa 
ON p.player_api_id = pa.player_api_id
GROUP BY year_born;