//CREATE TABLE TrainSchedule(Train_ID  integer, Source varchar, Destination varchar, Distance integer,Departure_Time time, Arrival_Time time);

//Q1
                                
WITH RECURSIVE citiesconnectedwithdelhi AS 
(
    SELECT source,Destination FROM TrainSchedule WHERE source = 'Delhi'
    UNION 
    SELECT train.source,train.Destination 
    FROM TrainSchedule train INNER JOIN citiesconnectedwithdelhi route on 
    train.source = route.Destination
    ) SELECT distinct Destination as Cities_Reachable FROM citiesconnectedwithdelhi ORDER BY Destination;

//Q2
										
WITH RECURSIVE citiesconnectedwithdelhi AS (
    SELECT source,Destination,Departure_Time, Arrival_Time 
    FROM TrainSchedule WHERE source = 'Delhi'
    UNION 
    SELECT train.source,train.Destination,train.Departure_Time, train.Arrival_Time 
    FROM TrainSchedule train INNER JOIN citiesconnectedwithdelhi route on 
        train.source = route.Destination and (EXTRACT(epoch FROM ((train.Departure_Time - route.Arrival_Time))) + 86400) :: integer % 86400 <= 3600)
         SELECT distinct Destination  FROM citiesconnectedwithdelhi ORDER BY Destination;

//Q3									

WITH RECURSIVE delhitoMum AS (
        SELECT destination, arrival_time, EXTRACT(epoch FROM (-Departure_Time + Arrival_Time)) as total_time
        FROM TrainSchedule WHERE source = 'Delhi'
        UNION 
        SELECT train.Destination,train.arrival_time, route.total_time + EXTRACT(epoch FROM (-train.Departure_Time+train.Arrival_Time)) + ((EXTRACT(epoch FROM (train.Departure_Time - route.Arrival_Time))) + 86400):: integer% 86400 
        FROM TrainSchedule train INNER JOIN delhitoMum route  ON train.source = route.Destination) SELECT MIN (total_time)* interval '1 sec' from delhitoMum 
        WHERE Destination ='Mumbai';

//Q4									
										
WITH RECURSIVE citiesconnectedwithdelhi AS (
                                    SELECT source,Destination from TrainSchedule WHERE source = 'Delhi'
                                    UNION SELECT train.source,train.Destination FROM TrainSchedule train INNER JOIN citiesconnectedwithdelhi route on 
                                        train.source = route.Destination) SELECT Train_ID FROM TrainSchedule WHERE 
                                        TrainSchedule.Source <> 'Delhi' AND
                                        TrainSchedule.Source NOT IN (SELECT Destination FROM citiesconnectedwithdelhi) order by Train_ID;

//Q5

WITH RECURSIVE increasingjourneytime AS (SELECT  train.source,train.Destination, EXTRACT(epoch FROM (-train.Departure_Time+train.Arrival_Time)) AS journey_time FROM TrainSchedule train
					UNION ALL SELECT route.source,train.Destination, EXTRACT(epoch FROM (-train.Departure_Time+train.Arrival_Time))  AS journey_time FROM TrainSchedule train
                                     INNER JOIN increasingjourneytime route ON train.source = route.Destination AND EXTRACT(epoch FROM (-train.Departure_Time+train.Arrival_Time)) >= 
						route.journey_time) SELECT distinct Source,Destination FROM increasingjourneytime order by Source,destination;

//Q6

WITH RECURSIVE decreasingjourneytime AS (SELECT  train.source,train.Destination,1 as depth_, EXTRACT(epoch FROM  (-train.Departure_Time+train.Arrival_Time)) as journey_time FROM TrainSchedule train
					UNION ALL select route.source,train.Destination,depth_ +1 AS depth_ ,(1 - mod(depth_,2) ) * EXTRACT(epoch FROM 
						(-train.Departure_Time+train.Arrival_Time)) + mod(depth_,2)*route.journey_time  AS journey_time FROM TrainSchedule train
                                     	INNER JOIN decreasingjourneytime route ON train.source = route.Destination AND (EXTRACT(epoch FROM (-train.Departure_Time+train.Arrival_Time)) <= 
							route.journey_time OR mod(depth_,2) = 1)) SELECT distinct Source,Destination FROM decreasingjourneytime order by Source, Destination;

//Q7

((SELECT city1.city as source ,city2.city as destination FROM (SELECT source as city FROM TrainSchedule UNION
	SELECT destination FROM TrainSchedule) as city1,(SELECT source as city FROM TrainSchedule UNION
	SELECT destination FROM TrainSchedule) as city2 WHERE city1.city!=city2.city)

	EXCEPT 
    
    (WITH RECURSIVE citiesconnected AS (SELECT train.source,train.Destination FROM TrainSchedule train UNION ALL SELECT route.source,train.Destination FROM TrainSchedule train
                                INNER JOIN citiesconnected route on 
                                      train.source = route.Destination) SELECT source,destination FROM citiesconnected order by source, destination)) order by source,destination;

//Q8

WITH RECURSIVE total_routes AS (SELECT source,'' AS path_,Destination FROM TrainSchedule WHERE source = 'Delhi' UNION ALL
                                    SELECT route.source, path_||','||train.source  AS path_, train.Destination FROM TrainSchedule train
                                    INNER JOIN total_routes route ON
                                        train.source = route.Destination)  SELECT count(distinct path_) FROM total_routes WHERE destination = 'Mumbai';

//Q9
WITH RECURSIVE total_routes AS (SELECT distinct source,Destination FROM TrainSchedule WHERE source = 'Delhi'
                                    UNION ALL
                                    SELECT distinct route.source,train.Destination FROM TrainSchedule train
                                    INNER JOIN total_routes route ON 
                                        train.source = route.Destination)  SELECT distinct destination AS cities_havingExactly_onePath FROM total_routes GROUP BY destination HAVING count(destination)=1  order by destination;


//Q10

WITH RECURSIVE total_routes AS (SELECT source,'' AS path_,Destination FROM TrainSchedule WHERE source = 'Delhi' UNION ALL
                                    SELECT route.source, path_||','||train.source  AS path_, train.Destination FROM TrainSchedule train
                                    INNER JOIN total_routes route ON
                                        train.source = route.Destination)  SELECT count(distinct path_) FROM total_routes WHERE path_ LIKE '%Bhopal%' and destination = 'Hyderabad';
