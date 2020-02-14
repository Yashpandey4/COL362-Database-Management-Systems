
-- Top Winning Teams per season

SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        season,
        CASE WHEN home_team_goal > away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Winning_team, 
        COUNT(*) as num_wins            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Winning_team, Country.name, League.name, season
ORDER BY num_wins DESC, Country.name, League.name, season DESC
LIMIT 20
;


-- Top Winning Teams of all times

SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        CASE WHEN home_team_goal > away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Winning_team, 
        COUNT(*) as num_wins            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Winning_team, Country.name, League.name
ORDER BY num_wins DESC, Country.name, League.name
LIMIT 20
;


-- Top Losing Teams per season

SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        season,
        CASE WHEN home_team_goal < away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Losing_team, 
        COUNT(*) as num_loss            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Losing_team, Country.name, League.name, season
ORDER BY num_loss DESC, Country.name, League.name, season DESC
LIMIT 20
;


-- Top Winning Teams of all times

SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        CASE WHEN home_team_goal < away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Losing_team, 
        COUNT(*) as num_loss            
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY Losing_team, Country.name, League.name
ORDER BY num_loss DESC, Country.name, League.name
LIMIT 20
;

-- Top Draw Teams per season

SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        season,
        CASE WHEN home_team_goal = away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Draw_team, 
        COUNT(*) as num_draw          
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY draw_team, Country.name, League.name, season
ORDER BY num_draw DESC, Country.name, League.name, season DESC
LIMIT 20
;

-- Top Draw Teams of all time

SELECT  
        Country.name AS country_name, 
        League.name AS league_name,
        CASE WHEN home_team_goal = away_team_goal then HT.team_long_name
            ELSE AT.team_long_name
            END AS Draw_team, 
        COUNT(*) as num_draw          
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name = 'Spain'
--WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
GROUP BY draw_team, Country.name, League.name
ORDER BY num_draw DESC, Country.name, League.name
LIMIT 20
;