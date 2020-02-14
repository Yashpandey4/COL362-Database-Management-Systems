-- Player Information By Height

SELECT CASE
    WHEN ROUND(height)<165 then 165
    WHEN ROUND(height)>195 then 195
    ELSE ROUND(height)
    END AS calc_height, 
    COUNT(height) AS distribution, 
    (avg(PA_Grouped.avg_overall_rating)) AS avg_overall_rating,
    (avg(PA_Grouped.avg_potential)) AS avg_potential,
    AVG(weight) AS avg_weight 
FROM PLAYER
LEFT JOIN (SELECT Player_Attributes.player_api_id, 
    avg(Player_Attributes.overall_rating) AS avg_overall_rating,
    avg(Player_Attributes.potential) AS avg_potential  
    FROM Player_Attributes
    GROUP BY Player_Attributes.player_api_id) 
    AS PA_Grouped ON PLAYER.player_api_id = PA_Grouped.player_api_id
GROUP BY calc_height
ORDER BY calc_height
; 