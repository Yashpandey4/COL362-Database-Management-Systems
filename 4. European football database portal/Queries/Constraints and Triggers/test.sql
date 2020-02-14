ALTER TABLE Team_Attributes
DROP CONSTRAINT team_check,
ADD CONSTRAINT team_check CHECK (
    buildUpPlaySpeed >=0 AND buildUpPlaySpeed <=100
AND buildUpPlaySpeed >=0 AND buildUpPlaySpeed <=100
AND buildUpPlayDribbling >=0 AND buildUpPlayDribbling <=100
AND buildUpPlayPassing >=0 AND buildUpPlayPassing <=100
AND chanceCreationPassing >=0 AND chanceCreationPassing <=100
AND chanceCreationCrossing >=0 AND chanceCreationCrossing <=100
AND chanceCreationShooting >=0 AND chanceCreationShooting <=100
AND defencePressure >=0 AND defencePressure <=100
AND defenceAggression >=0 AND defenceAggression <=100
AND defenceTeamWidth >=0 AND defenceTeamWidth <=100
AND (buildUpPlayDribblingClass IN ('Lots','Little','Normal'))
AND (buildUpPlayPassingClass IN ('Long','Short','Mixed'))
AND (buildUpPlayPositioningClass IN ('Free Form','Organised'))
AND (chanceCreationPassingClass IN ('Safe','Risky', 'Normal'))
AND (chanceCreationCrossingClass IN ('Lots','Little','Normal'))
AND (chanceCreationShootingClass IN ('Lots','Little','Normal'))
AND (chanceCreationPositioningClass IN ('Free Form','Organised'))
AND (defencePressureClass IN ('High','Deep','Medium'))
AND (defenceAggressionClass IN ('Contain','Double','Press'))
AND (defenceTeamWidthClass IN ('Narrow','Normal','Wide'))
AND (defenceDefenderLineClass IN ('Cover','Offside Trap'))
)
;