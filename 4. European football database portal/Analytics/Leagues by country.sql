-- Participating League and their Countries

SELECT Country.id, League.name AS League_name, Country.name AS Country_name
FROM League, Country
WHERE Country.id=League.country_id;

-- SELECT * FROM League
-- JOIN Country ON Country.id = League.country_id;