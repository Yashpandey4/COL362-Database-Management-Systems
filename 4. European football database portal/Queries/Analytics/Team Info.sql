-- Team Information

SELECT * FROM Team, Team_Attributes
WHERE Team.team_api_id = Team_Attributes.team_api_id
ORDER BY Team.team_long_name;