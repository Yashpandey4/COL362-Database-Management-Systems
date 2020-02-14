-- best teams in a league season wise

SELECT Country.name AS country_name, 
        League.name AS league_name,
        HT.team_long_name,
        season,
        count(distinct stage) AS number_of_stages,
        -- count(distinct HT.team_long_name) AS number_of_teams,
        avg(home_team_goal) AS avg_home_team_goals, 
        avg(away_team_goal) AS avg_away_team_goals, 
        avg(home_team_goal-away_team_goal) AS avg_goal_dif, 
        avg(home_team_goal+away_team_goal) AS avg_goals, 
        sum(home_team_goal+away_team_goal) AS total_goals                                       
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
--WHERE league.name in () --best teams in a given league
--WHERE season in () --best teams in a given season
GROUP BY HT.team_long_name, Country.name, League.name, season
--HAVING count(distinct stage) > 10
ORDER BY total_goals DESC, Country.name, League.name, season DESC
LIMIT 10
;

-- best teams in a league absolutely of all times

SELECT Country.name AS country_name, 
        League.name AS league_name,
        HT.team_long_name,
        --season,
        count(distinct stage) AS number_of_stages,
        -- count(distinct HT.team_long_name) AS number_of_teams,
        avg(home_team_goal) AS avg_home_team_goals, 
        avg(away_team_goal) AS avg_away_team_goals, 
        avg(home_team_goal-away_team_goal) AS avg_goal_dif, 
        avg(home_team_goal+away_team_goal) AS avg_goals, 
        sum(home_team_goal+away_team_goal) AS total_goals                                       
FROM Match
JOIN Country on Country.id = Match.country_id
JOIN League on League.id = Match.league_id
LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
WHERE country.name in ('Spain', 'Germany', 'France', 'Italy', 'England')
--WHERE league.name in () --best teams in a given league
GROUP BY HT.team_long_name, Country.name, League.name
--HAVING count(distinct stage) > 10
ORDER BY total_goals DESC, Country.name, League.name
LIMIT 10
;