
-- top teams by home goals (Season Wise)

SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        HT.team_long_name AS home_team,
        SUM(home_team_goal) AS "home_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name, season
ORDER BY home_goals_total DESC, Country.name, League.name, season DESC
LIMIT 20
;


-- top teams by home goals (ALL TIME)

SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        HT.team_long_name AS home_team,
        SUM(home_team_goal) AS "home_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name
ORDER BY home_goals_total DESC, Country.name, League.name
LIMIT 20
;


-- top teams by away goals (Season Wise)

SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        AT.team_long_name AS away_team,
        SUM(away_team_goal) AS "away_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name, season
ORDER BY away_goals_total DESC, Country.name, League.name, season DESC
LIMIT 20
;


-- top teams by away goals (ALL TIME)

SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        AT.team_long_name AS away_team,
        SUM(away_team_goal) AS "away_goals_total"                   
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name
ORDER BY away_goals_total DESC, Country.name, League.name
LIMIT 20
;