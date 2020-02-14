
--MATCHES PLAYED IN EACH LEAGUE BY SEASON

SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        season, 
        COUNT(distinct Match.id) AS Matches_Played              
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Country.name, League.name, season
ORDER by Country.name, League.name, season
LIMIT 20
;

-- Teams ordered by number of home matches played (Season)
SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        HT.team_long_name AS home_team,
        season,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name, season
ORDER by Matches_Played DESC, Country.name, League.name, season, HT.team_long_name
LIMIT 20
;


-- Teams ordered by number of home matches played (ALL TIME)
SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        HT.team_long_name AS home_team,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY HT.team_long_name, Country.name, League.name
ORDER by Matches_Played DESC, Country.name, League.name, HT.team_long_name
LIMIT 20
;

-- Teams ordered by number of away matches played (Season)

SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        AT.team_long_name AS away_team,
        season,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name, season
ORDER by Matches_Played DESC, Country.name, League.name, season, AT.team_long_name
LIMIT 20
;


-- Teams ordered by number of away matches played (ALL TIME)
SELECT  
        Country.name AS country_name, 
        League.name AS league_name, 
        AT.team_long_name AS away_team,
        COUNT(distinct Match.id) AS Matches_Played         
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
--WHERE country.name = 'Spain'
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY AT.team_long_name, Country.name, League.name
ORDER by Matches_Played DESC, Country.name, League.name, AT.team_long_name
LIMIT 20
;