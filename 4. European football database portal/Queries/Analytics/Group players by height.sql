-- group players by height (Category providing)

SELECT player_name, height,
    CASE
        WHEN height < 170.00 THEN 'Short'
        WHEN height BETWEEN 170.00 AND 185.00 THEN 'Medium'
        WHEN height > 185.00 THEN 'Tall'    
    END AS height_class
FROM Player;