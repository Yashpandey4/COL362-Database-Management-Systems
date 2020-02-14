--PREAMBLE--
CREATE MATERIALIZED VIEW ee1170938_fulltable AS  --venue.name excluded
SELECT Paper.PaperId, Paper.Title, Paper.year,Venue.VenueId, Venue.type, Author.AuthorId, Author.name, Venue.name as vname
FROM Author JOIN PaperByAuthors
ON Author.AuthorId = PaperByAuthors.AuthorId
JOIN Paper ON
Paper.PaperId = PaperByAuthors.PaperId
JOIN Venue ON
Venue.VenueId = Paper.VenueId;

CREATE VIEW ee1170938_Q1 AS --papervenue
SELECT Paper.paperId, Venue.type FROM Paper, Venue
WHERE Paper.VenueId = Venue.VenueId;

CREATE MATERIALIZED VIEW ee1170938_Q2 AS
SELECT PaperId, COUNT(PaperId) 
FROM PaperByAuthors
GROUP BY 1;

CREATE VIEW ee1170938_Q4 AS --singleAuthorId
SELECT DISTINCT AuthorId
FROM PaperByAuthors
WHERE AuthorId IN
(
    SELECT PaperByAuthors.AuthorId
    FROM PaperByAuthors
    JOIN ee1170938_Q2
    ON PaperByAuthors.PaperId = ee1170938_Q2.PaperId AND ee1170938_Q2.COUNT = 1
);

CREATE VIEW ee1170938_Q4_1 AS --nonsingleAuthorId
SELECT DISTINCT AuthorId
FROM PaperByAuthors
EXCEPT
SELECT AuthorId FROM ee1170938_Q4;

CREATE VIEW ee1170938_Q5 AS
SELECT AuthorId, COUNT(*) 
FROM PaperByAuthors
GROUP BY AuthorId;

CREATE VIEW ee1170938_Q6 AS
SELECT PaperByAuthors.AuthorId, COUNT(*)
FROM PaperByAuthors
JOIN ee1170938_Q2
ON PaperByAuthors.PaperId = ee1170938_Q2.PaperId AND ee1170938_Q2.COUNT = 1
GROUP BY 1;

CREATE VIEW ee1170938_Q9_1 AS -- Author by year 2012 papersnum2012
WITH temp AS
(
    select paper.paperid, paperbyauthors.authorid
	from paper, paperbyauthors
	where paper.year = 2012
	and paper.paperid = paperbyauthors.paperid
)
SELECT AuthorId, COUNT(AuthorId)
FROM temp
GROUP BY 1;

CREATE VIEW ee1170938_Q9_2 AS -- Author by year 2013 paperin2013
WITH temp AS
(
    select paper.paperid, paperbyauthors.authorid
	from paper, paperbyauthors
	where paper.year = 2013
	and paper.paperid = paperbyauthors.paperid
)
SELECT AuthorId, COUNT(AuthorId)
FROM temp
GROUP BY 1;

CREATE VIEW ee1170938_Q10_1 AS --papersincorr
select paper.paperid, paperbyauthors.authorid, paper.year
from paper, paperbyauthors
where paper.venueid in (
    select venueid 
    from venue
    where name = 'corr' 
    and type = 'journals'	
)
and paper.paperid = paperbyauthors.paperid
order by paperbyauthors.authorid;

CREATE VIEW ee1170938_Q10_2 AS --papersnumcorr
select authorid, count(authorid)
from ee1170938_Q10_1
group by 1
order by 2 desc;

CREATE VIEW ee1170938_Q12_1 AS --paperss in ieicet
WITH temp AS
(
    select paper.paperid, paperbyauthors.authorid, paper.year
	from paper, paperbyauthors
	where paper.venueid in (
		select venueid 
		from venue
		where name = 'ieicet' 
		and type = 'journals'	
	)
	and paper.paperid = paperbyauthors.paperid
)
select authorid, count(authorid)
from temp
group by authorid
order by count desc;

CREATE VIEW ee1170938_Q12_2 AS --paperss in tcs
WITH temp AS
(
    select paper.paperid, paperbyauthors.authorid, paper.year
	from paper, paperbyauthors
	where paper.venueid in (
		select venueid 
		from venue
		where name = 'tcs' 
		and type = 'journals'	
	)
	and paper.paperid = paperbyauthors.paperid
)
select authorid, count(authorid)
from temp
group by authorid
order by count desc;

create view ee1170938_Q14
as select PaperByAuthors.authorid, count(distinct paper.paperid) as likepaper
from paperbyauthors, paper
where paperbyauthors.paperId=paper.paperId
and lower(paper.Title) like '%query%optimization%'
group by PaperByAuthors.authorid;

CREATE MATERIALIZED VIEW ee1170938_Q15 AS -- count cited paper2
SELECT Paper2Id, COUNT(*)
FROM Citation
GROUP BY Paper2Id
ORDER BY COUNT(*) DESC;

CREATE VIEW ee1170938_Q16 AS -- Count cited paper2 >10 times
SELECT Paper2Id, COUNT(*)
FROM Citation
GROUP BY Paper2Id
HAVING COUNT(*) > 10;

CREATE MATERIALIZED VIEW ee1170938_Q19 AS -- count citing paper1
SELECT Paper1Id, COUNT(*)
FROM Citation
GROUP BY Paper1Id;

CREATE VIEW ee1170938_Q17 AS
SELECT Paper.PaperId
FROM Paper
EXCEPT
SELECT ee1170938_Q19.Paper1Id
FROM ee1170938_Q19;

create view ee1170938_Q18_2 as --numcitations
select paper2id, count(paper2id)
from citation
group by paper2id
order by count desc;

create view ee1170938_Q18_1 as --nocitations
select paper.paperid 
from paper 
except
select ee1170938_Q18_2.paper2id
from ee1170938_Q18_2;

create view ee1170938_Q20_1 as --papersincorr
select paper.paperid, paperbyauthors.authorid, paper.year
from paper, paperbyauthors
where paper.venueid in (
    select venueid 
    from venue
    where name = 'corr' 
    and type = 'journals'	
)
and paper.paperid = paperbyauthors.paperid
order by paperbyauthors.authorid;

create view ee1170938_Q20_2 as --papersinieicet
select paper.paperid, paperbyauthors.authorid, paper.year
from paper, paperbyauthors
where paper.venueid in (
    select venueid 
    from venue
    where name = 'ieicet' 
    and type = 'journals'	
)
and paper.paperid = paperbyauthors.paperid
order by paperbyauthors.authorid;

create view ee1170938_Q21_1
as select venue.name, paper.year, count(distinct paper.paperId) as num_journal2009
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
and paper.year=2009
group by venue.name, paper.year;

create view ee1170938_Q21_2
as select venue.name, paper.year, count(distinct paper.paperId) as num_journal2010
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
and paper.year=2010
group by venue.name, paper.year;

create view ee1170938_Q21_3
as select venue.name, paper.year, count(distinct paper.paperId) as num_journal2011
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
and paper.year=2011
group by venue.name, paper.year;

create view ee1170938_Q21_4
as select venue.name, paper.year, count(distinct paper.paperId) as num_journal2012
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
and paper.year=2012
group by venue.name, paper.year;


create view ee1170938_Q21_5
as select venue.name, paper.year, count(distinct paper.paperId) as num_journal2013
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
and paper.year=2013
group by venue.name, paper.year;

create view ee1170938_Q21
as select ee1170938_Q21_1.name, ee1170938_Q21_1.num_journal2009, ee1170938_Q21_2.num_journal2010, ee1170938_Q21_3.num_journal2011,
ee1170938_Q21_4.num_journal2012, ee1170938_Q21_5.num_journal2013
from ee1170938_Q21_1, ee1170938_Q21_2, ee1170938_Q21_3, ee1170938_Q21_4, ee1170938_Q21_5
where ee1170938_Q21_1.name=ee1170938_Q21_2.Name
and ee1170938_Q21_1.num_journal2009 <= ee1170938_Q21_2.num_journal2010
and ee1170938_Q21_1.name=ee1170938_Q21_3.Name
and ee1170938_Q21_2.num_journal2010 <= ee1170938_Q21_3.num_journal2011
and ee1170938_Q21_1.name=ee1170938_Q21_4.Name
and ee1170938_Q21_3.num_journal2011 <= ee1170938_Q21_4.num_journal2012
and ee1170938_Q21_1.name=ee1170938_Q21_5.Name
and ee1170938_Q21_4.num_journal2012 <= ee1170938_Q21_5.num_journal2013
group by ee1170938_Q21_1.name, ee1170938_Q21_1.num_journal2009, ee1170938_Q21_2.num_journal2010, ee1170938_Q21_3.num_journal2011,
ee1170938_Q21_4.num_journal2012, ee1170938_Q21_5.num_journal2013;

CREATE VIEW ee1170938_Q22 AS --paperauthorconference
SELECT Paper.PaperId, Venue.name, Paper.year, PaperByAuthors.AuthorId
FROM Paper, Venue, PaperByAuthors
WHERE Paper.VenueId = Venue.VenueId
AND PaperByAuthors.PaperId = Paper.PaperId
AND Venue.type = 'journals';

create view ee1170938_Q22_1
as select venue.name, paper.year, count(distinct paper.paperId) as num_jounralandyear
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
group by venue.name, paper.year;

create view ee1170938_Q22_2
as select max(num_jounralandyear) from ee1170938_Q22_1;

create view ee1170938_Q22_3
as select name, year, num_jounralandyear
from ee1170938_Q22_1, ee1170938_Q22_2
where num_jounralandyear=ee1170938_Q22_2.max
group by name, year, num_jounralandyear;

create view ee1170938_Q23_1 as --authornumjournal
select authorid, name, count((name, authorid))
from ee1170938_Q22
group by name, authorid
order by name, authorid;

create view ee1170938_Q23_2 as --maxjournalauthor
select name, max(count)
from ee1170938_Q23_1
group by name
order by name;

create view ee1170938_Q24_1
as select venue.name, count(distinct paper.paperId) + 0.0 as num_jounral20078
from venue, paper
where paper.VenueId=venue.VenueId
and venue.type ='journals'
and (paper.year=2008 or paper.year=2007)
group by venue.name;

create view ee1170938_Q24_2
as select name,  ee1170938_Q24_1.num_jounral20078 as num_journal20078
from ee1170938_Q24_1
where ee1170938_Q24_1.num_jounral20078>0;

create view ee1170938_Q24_6
as select * from paper;

create view ee1170938_Q24_3
as select venue.name, count(distinct citation.paper1id) as num_citation
from venue, paper, citation
where paper.VenueId=venue.VenueId
and venue.type='journals'
and paper.paperid=citation.paper2id
and (paper.year=2007 or paper.year=2008)
and exists (select 1
from ee1170938_Q24_6
where ee1170938_Q24_6.paperid=citation.paper1id
and (ee1170938_Q24_6.year=2009))
group by venue.name;

create view ee1170938_Q24_4
as select ee1170938_Q24_2.name, 0.0 as num_citation
from ee1170938_Q24_2
where not exists (select 1
from ee1170938_Q24_3
where ee1170938_Q24_3.name=ee1170938_Q24_2.name)
group by ee1170938_Q24_2.name;

create view ee1170938_Q24_5
as select * from ee1170938_Q24_4
union
select *  from ee1170938_Q24_3;

create view ee1170938_Q24
as select ee1170938_Q24_5.name, (ee1170938_Q24_5.num_citation/ee1170938_Q24_2.num_journal20078) as impact_value
from ee1170938_Q24_5, ee1170938_Q24_2
where ee1170938_Q24_5.name=ee1170938_Q24_2.name
group by ee1170938_Q24_5.name,ee1170938_Q24_5.num_citation, ee1170938_Q24_2.num_journal20078;

create view ee1170938_Q25_2 as
select paper2id, count(paper2id)
from citation
group by paper2id
order by count desc;

create view ee1170938_Q25_1 as
select paperbyauthors.authorid, paperbyauthors.paperid, ee1170938_Q25_2.count, row_number() over(
partition by paperbyauthors.authorId
order by count desc
)
from paperbyauthors, ee1170938_Q25_2
where paperbyauthors.paperid = ee1170938_Q25_2.paper2id
order by 1, 3 desc;

create view ee1170938_Q25 as
select authorid, count, row_number
from ee1170938_Q25_1
where count >= row_number;
	

--1--
SELECT type, COUNT(*)
FROM ee1170938_Q1
GROUP BY type
ORDER BY COUNT(*) DESC;

--2--
SELECT AVG(COUNT)
FROM ee1170938_Q2;

--3--
SELECT DISTINCT Paper.Title
FROM ee1170938_Q2, Paper
WHERE Paper.PaperId = ee1170938_Q2.PaperId
AND ee1170938_Q2.COUNT > 20
ORDER BY 1;

--4--
SELECT Author.name
FROM Author
JOIN ee1170938_Q4_1
ON Author.AuthorId = ee1170938_Q4_1.AuthorId
ORDER BY Author.name;

--5--
SELECT Author.name 
FROM ee1170938_Q5
JOIN Author
ON Author.AuthorId = ee1170938_Q5.AuthorId 
ORDER BY ee1170938_Q5.COUNT DESC, Author.name
LIMIT 20;

--6--
SELECT Author.name
FROM ee1170938_Q6
JOIN Author
ON ee1170938_Q6.AuthorId = Author.AuthorId 
WHERE ee1170938_Q6.COUNT > 50
ORDER BY 1;

--7--
SELECT DISTINCT name
FROM Author
EXCEPT 
SELECT DISTINCT name 
FROM ee1170938_fulltable
WHERE type = 'journals'
ORDER BY 1;

--8--
SELECT DISTINCT name
FROM Author
EXCEPT 
SELECT DISTINCT name 
FROM ee1170938_fulltable
WHERE type != 'journals'
ORDER BY 1;

--9--
SELECT Author.name
FROM Author, ee1170938_Q9_1, ee1170938_Q9_2
WHERE ee1170938_Q9_1.COUNT > 1
AND ee1170938_Q9_2.COUNT > 2
AND ee1170938_Q9_1.AuthorId = ee1170938_Q9_2.AuthorId
AND Author.AuthorId = ee1170938_Q9_2.AuthorId
ORDER BY 1;

--10--
select author.name
from author, ee1170938_Q10_2
where author.authorid = ee1170938_Q10_2.authorid
order by ee1170938_Q10_2.COUNT desc, author.name
limit 20;

--11-- 
WITH temp AS
(   
    SELECT name, COUNT(*)
    FROM ee1170938_fulltable
    WHERE vname = 'amc' AND type = 'journals'
    GROUP BY 1
    HAVING COUNT(*) >= 4
    ORDER BY 1
)
SELECT DISTINCT temp.name
FROM temp
ORDER BY 1;

--12--
select author.name
from author, ee1170938_Q12_1
where ee1170938_Q12_1.count>=10
and author.authorid = ee1170938_Q12_1.authorid
except 
select author.name
from author, ee1170938_Q12_2
where author.authorid = ee1170938_Q12_2.authorid
order by 1;

--13--
SELECT year, COUNT(*)
FROM Paper
WHERE year > 2003 and year < 2014
GROUP BY 1
ORDER BY 1;

--14--
select count(*) from ee1170938_Q14;

--15--
SELECT Paper.Title
FROM ee1170938_Q15 JOIN Paper
ON ee1170938_Q15.Paper2Id = Paper.PaperId
ORDER BY 1;

--16--
SELECT Paper.Title
FROM ee1170938_Q16 JOIN Paper
ON ee1170938_Q16.Paper2Id = Paper.PaperId
ORDER BY 1;

--17--
SELECT Paper.Title
FROM Paper, ee1170938_Q15, ee1170938_Q19
WHERE ee1170938_Q15.Paper2Id = ee1170938_Q19.Paper1Id
AND ee1170938_Q15.COUNT - ee1170938_Q19.COUNT >=10
AND Paper.PaperId = ee1170938_Q19.Paper1Id
order by 1;

-- UNION

-- SELECT Paper.Title
-- FROM Paper, ee1170938_Q15, ee1170938_Q17
-- WHERE ee1170938_Q15.Paper2Id = ee1170938_Q17.PaperId
-- AND ee1170938_Q15.COUNT >=10
-- AND Paper.PaperId = ee1170938_Q15.Paper2Id
-- ORDER BY 1;

--18--
select paper.title
from paper, ee1170938_Q18_1
where paper.paperid = ee1170938_Q18_1.paperid
order by paper.title;

--19--
select distinct author.name 
from author, paperbyauthors, citation, paperbyauthors as p2
where citation.paper1id = paperbyauthors.paperid
and citation.paper1id != citation.paper2id
and citation.paper2id = p2.paperId
and paperbyauthors.authorid = p2.authorid
and author.authorid = paperbyauthors.authorid
order by 1;

--20--
select author.name
from author, ee1170938_Q20_1
where ee1170938_Q20_1.year >=2009 
and ee1170938_Q20_1.year <=2013
and author.authorid = ee1170938_Q20_1.authorid

except

select author.name
from author, ee1170938_Q20_2
where ee1170938_Q20_2.year = 2009
and author.authorid = ee1170938_Q20_2.authorid
order by name;

--21--
select name
from ee1170938_Q21
order by name;

--22--
select name, year
from ee1170938_Q22_3
order by year, name;

--23--
select ee1170938_Q23_1.name, author.name
from ee1170938_Q23_2, ee1170938_Q23_1, author
where ee1170938_Q23_2.name = ee1170938_Q23_1.name
and ee1170938_Q23_1.count = ee1170938_Q23_2.max 
and author.authorid = ee1170938_Q23_1.authorid
order by ee1170938_Q23_2.name, author.name;

--24--
select * from ee1170938_Q24
order by impact_value desc, name;

--25--
select author.name, max(ee1170938_Q25.row_number) as index
from author, ee1170938_Q25
where author.authorid = ee1170938_Q25.authorid
group by author.name
order by index desc, author.name; 

--CLEANUP--
DROP VIEW ee1170938_Q25;
DROP VIEW ee1170938_Q25_1;
DROP VIEW ee1170938_Q25_2;
DROP VIEW ee1170938_Q24;
DROP VIEW ee1170938_Q24_5;
DROP VIEW ee1170938_Q24_4;
DROP VIEW ee1170938_Q24_3;
DROP VIEW ee1170938_Q24_6;
DROP VIEW ee1170938_Q24_2;
DROP VIEW ee1170938_Q24_1;
DROP VIEW ee1170938_Q23_2;
DROP VIEW ee1170938_Q23_1;
DROP VIEW ee1170938_Q22_3;
DROP VIEW ee1170938_Q22_2;
DROP VIEW ee1170938_Q22_1;
DROP VIEW ee1170938_Q22;
DROP VIEW ee1170938_Q21;
DROP VIEW ee1170938_Q21_5;
DROP VIEW ee1170938_Q21_4;
DROP VIEW ee1170938_Q21_3;
DROP VIEW ee1170938_Q21_2;
DROP VIEW ee1170938_Q21_1;
DROP VIEW ee1170938_Q20_2;
DROP VIEW ee1170938_Q20_1;
DROP VIEW ee1170938_Q18_1;
DROP VIEW ee1170938_Q18_2;
DROP VIEW ee1170938_Q17;
DROP MATERIALIZED VIEW ee1170938_Q19;
DROP VIEW ee1170938_Q16;
DROP MATERIALIZED VIEW ee1170938_Q15;
DROP VIEW ee1170938_Q14;
DROP VIEW ee1170938_Q12_2;
DROP VIEW ee1170938_Q12_1;
DROP VIEW ee1170938_Q10_2;
DROP VIEW ee1170938_Q10_1;
DROP VIEW ee1170938_Q9_2;
DROP VIEW ee1170938_Q9_1;
DROP VIEW ee1170938_Q6;
DROP VIEW ee1170938_Q5;
DROP VIEW ee1170938_Q4_1;
DROP VIEW ee1170938_Q4;
DROP MATERIALIZED VIEW ee1170938_Q2;
DROP VIEW ee1170938_Q1;
DROP MATERIALIZED VIEW ee1170938_fulltable;