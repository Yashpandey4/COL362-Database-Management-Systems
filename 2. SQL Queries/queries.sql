--PREAMBLE--

create view cs5160398_papervenue as 
	select paper.paperid, venue.type 
	from paper, venue
	where paper.venueid = venue.venueid;

create view cs5160398_papernum as
	select paperId, count(paperid)
	from paperbyauthors 
	group by paperid
	order by paperid;

create view cs5160398_paper1author as
	select distinct paperbyauthors.authorid, paperbyauthors.paperid
	from cs5160398_papernum, paperbyauthors
	where cs5160398_papernum.count = 1 
		and paperbyauthors.paperid = cs5160398_papernum.paperid
	order by paperbyauthors.authorid;

create view cs5160398_authornum as
	select authorid, count(authorid)
	from paperbyauthors
	group by authorid
	order by count desc;

create view cs5160398_authornumof1paper as
	select authorid, count(authorid) 
	from cs5160398_paper1author 
	group by authorid;

create view cs5160398_papersin2012 as
	select paper.paperid, paperbyauthors.authorid
	from paper, paperbyauthors
	where paper.year = 2012
	and paper.paperid = paperbyauthors.paperid
	order by paperbyauthors.authorid;

create view cs5160398_papersnum2012 as
	select authorid, count(authorid)
	from cs5160398_papersin2012
	group by authorid;

create view cs5160398_papersin2013 as
	select paper.paperid, paperbyauthors.authorid
	from paper, paperbyauthors
	where paper.year = 2013
	and paper.paperid = paperbyauthors.paperid
	order by paperbyauthors.authorid;

create view cs5160398_papersnum2013 as
	select authorid, count(authorid)
	from cs5160398_papersin2013
	group by authorid;

create view cs5160398_papersincorr as
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

create view cs5160398_papersnumcorr as
	select authorid, count(authorid)
	from cs5160398_papersincorr
	group by authorid
	order by count desc;

create view cs5160398_papersinamc as
	select paper.paperid, paperbyauthors.authorid
	from paper, paperbyauthors
	where paper.venueid in (
		select venueid 
		from venue
		where name = 'amc' 
		and type = 'journals'	
	)
	and paper.paperid = paperbyauthors.paperid
	order by paperbyauthors.authorid;

create view cs5160398_papersnumamc as
	select authorid, count(authorid)
	from cs5160398_papersinamc
	group by authorid
	order by count desc;

create view cs5160398_papersinieicet as
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

create view cs5160398_papersnumieicet as
	select authorid, count(authorid)
	from cs5160398_papersinieicet
	group by authorid
	order by count desc;

create view cs5160398_papersintcs as
	select paper.paperid, paperbyauthors.authorid
	from paper, paperbyauthors
	where paper.venueid in (
		select venueid 
		from venue
		where name = 'tcs' 
		and type = 'journals'	
	)
	and paper.paperid = paperbyauthors.paperid
	order by paperbyauthors.authorid;

create view cs5160398_papersnumtcs as
	select authorid, count(authorid)
	from cs5160398_papersintcs
	group by authorid
	order by count desc;

create view cs5160398_numcitations as
	select paper2id, count(paper2id)
	from citation
	group by paper2id
	order by count desc;

create view cs5160398_numcites as
	select paper1id, count(paper1id)
	from citation
	group by paper1id
	order by count desc;

create view cs5160398_nocitations as
	select paper.paperid 
	from paper 
	except
	select cs5160398_numcitations.paper2id
	from cs5160398_numcitations;

create view cs5160398_nevercited as
	select paper.paperid 
	from paper 
	except
	select cs5160398_numcites.paper1id
	from cs5160398_numcites;

-- create view cs5160398_paperauthorconference as 
-- 	select paper.paperid, venue.name, paper.year
-- 	from paper, venue
-- 	where paper.venueid = venue.venueid
-- 	and venue.type = 'journals';

create view cs5160398_paperauthorconference as 
	select paper.paperid, venue.name, paper.year, paperbyauthors.authorid
	from paper, venue, paperbyauthors
	where paper.venueid = venue.venueid
	and paperbyauthors.paperid = paper.paperid
	and venue.type = 'journals';


create view cs5160398_maxjournalsyear as
	select name, year,  count((name, year))
	from cs5160398_paperauthorconference
	group by name, year
	order by name, year;

create view cs5160398_maxcountyear as
	select year, max(count)
	from cs5160398_maxjournalsyear
	group by year
	order by year;


create view cs5160398_authornumjournal as
	select authorid, name, count((name, authorid))
	from cs5160398_paperauthorconference
	group by name, authorid
	order by name, authorid;

create view cs5160398_maxjournalauthor as
	select name, max(count)
	from cs5160398_authornumjournal
	group by name
	order by name;

create view cs5160398_papersin2009 as
	select paper.paperid
	from paper, paperbyauthors
	where paper.year = 2009
	and paper.paperid = paperbyauthors.paperid;

create view cs5160398_journal0708 as
	select venue.venueid, count(venue.venueid)
	from venue, paper
	where venue.venueid = paper.venueid
	and (paper.year = 2007 or paper.year = 2008)
	group by venue.venueid;

create view cs5160398_numcited09 as
	select citation.paper2id, count(citation.paper2id)
	from citation
	where citation.paper1id in (
		select paperid from paper
		where year = 2009)
	and citation.paper2id in (
		select paperid from paper
		where year=2008 or year = 2007)
	group by citation.paper2id;

create view cs5160398_alldata24 as
	select cs5160398_journal0708.venueid, cs5160398_journal0708.count as pcount, cs5160398_numcited09.count as ccount
	from cs5160398_journal0708, cs5160398_numcited09, paper
	where paper.paperid = cs5160398_numcited09.paper2id
	and cs5160398_journal0708.venueid = paper.venueid;

create view cs5160398_alwayspaper as
	select name from cs5160398_maxjournalsyear
	where year = 2009
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2010
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2011
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2012
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2013;


--1--

select cs5160398_papervenue.type, count(cs5160398_papervenue.type) 
from cs5160398_papervenue 
group by type
order by count desc, type asc;

--2--

select avg(count) 
from cs5160398_papernum;

--3--

select distinct paper.title 
from paper, cs5160398_papernum
where paper.paperid = cs5160398_papernum.paperid 
	  and cs5160398_papernum.count > 20
order by paper.title;

--4--

select author.name 
from author

except 
select author.name
from author, cs5160398_paper1author
where author.authorid = cs5160398_paper1author.authorid order by name;

--5--

select author.name
from author, cs5160398_authornum
where author.authorid in (select authorid from cs5160398_authornum limit 20) 
	and cs5160398_authornum.authorid = author.authorid
order by cs5160398_authornum.count desc, author.name;

--6--

select author.name
from author
where authorid in 
	(select authorid 
	from cs5160398_authornumof1paper
	where count>50)
order by author.name;	

--7--

select author.name
from author
except
select distinct author.name 
from cs5160398_papervenue, author, paperbyauthors
where cs5160398_papervenue.type='journals' 
and paperbyauthors.paperid = cs5160398_papervenue.paperId
and author.authorid = paperbyauthors.authorid
order by name;

--8--

select author.name
from author
except
select distinct author.name 
from cs5160398_papervenue, author, paperbyauthors
where cs5160398_papervenue.type!='journals' 
and paperbyauthors.paperid = cs5160398_papervenue.paperId
and author.authorid = paperbyauthors.authorid
order by name;

--9--

select author.name
from author, cs5160398_papersnum2012, cs5160398_papersnum2013
where cs5160398_papersnum2012.count > 1
and cs5160398_papersnum2013.count > 2
and cs5160398_papersnum2012.authorid = cs5160398_papersnum2013.authorid
and author.authorid = cs5160398_papersnum2013.authorid
order by author.name;

--10--

select author.name
from author, cs5160398_papersnumcorr
where author.authorid = cs5160398_papersnumcorr.authorid
order by cs5160398_papersnumcorr.count desc, author.name
limit 20;

--11--

select author.name
from author, cs5160398_papersnumamc
where author.authorid = cs5160398_papersnumamc.authorid
and cs5160398_papersnumamc.count >= 4
order by author.name;

--12--

select author.name
from author, cs5160398_papersnumieicet
where cs5160398_papersnumieicet.count>=10
and author.authorid = cs5160398_papersnumieicet.authorid

except 
select author.name
from author, cs5160398_papersnumtcs
where author.authorid = cs5160398_papersnumtcs.authorid;

--13--

select year, count(year) 
from paper
where year > 2003 and year < 2014
group by year
order by year;

--14--
----Wrong Answer
select count(distinct author.name)
from author, paper, paperbyauthors
where paper.title like '%query optimization%'
and paper.paperid = paperbyauthors.paperid
and paperbyauthors.authorid = author.authorid;

--15--

select paper.title
from paper, cs5160398_numcitations
where paper.paperid = cs5160398_numcitations.paper2id
order by cs5160398_numcitations.count desc, paper.title;

--16--

select paper.title
from paper, cs5160398_numcitations
where cs5160398_numcitations.count > 10
and paper.paperid = cs5160398_numcitations.paper2id
order by paper.title;

--17--

select paper.title
from paper, cs5160398_numcitations, cs5160398_numcites
where cs5160398_numcitations.paper2id = cs5160398_numcites.paper1id
and cs5160398_numcitations.count - cs5160398_numcites.count >= 10
and paper.paperid = cs5160398_numcites.paper1id;

-- union

-- select paper.title
-- from paper, cs5160398_numcitations, cs5160398_nevercited
-- where cs5160398_numcitations.paper2id = cs5160398_nevercited.paperId
-- and cs5160398_numcitations.count >= 10
-- and paper.paperid = cs5160398_numcitations.paper2id
-- order by title;

--18--

select paper.title
from paper, cs5160398_nocitations
where paper.paperid = cs5160398_nocitations.paperid
order by paper.title;

--19--

select distinct author.name 
from author, paperbyauthors, citation, paperbyauthors as p2
where citation.paper1id = paperbyauthors.paperid
and citation.paper1id != citation.paper2id
and citation.paper2id = p2.paperId
and paperbyauthors.authorid = p2.authorid
and author.authorid = paperbyauthors.authorid;


--20--

select author.name
from author, cs5160398_papersincorr
where cs5160398_papersincorr.year >=2009 
and cs5160398_papersincorr.year <=2013
and author.authorid = cs5160398_papersincorr.authorid

except

select author.name
from author, cs5160398_papersinieicet
where cs5160398_papersinieicet.year = 2009
and author.authorid = cs5160398_papersinieicet.authorid

order by name;

--21--
--recheck--


select distinct y1.name 
from cs5160398_maxjournalsyear as y1,
	 cs5160398_maxjournalsyear as y2,
	 cs5160398_maxjournalsyear as y3,
	 cs5160398_maxjournalsyear as y4,
	 cs5160398_maxjournalsyear as y5

where y1.name in (
	select name from cs5160398_maxjournalsyear
	where year = 2009
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2010
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2011
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2012
	intersect
	select name from cs5160398_maxjournalsyear
	where year = 2013
)
and y1.year = 2009
and y2.year = 2010
and y3.year = 2011
and y4.year = 2012
and y5.year = 2013
and y1.name = y2.name
and y1.name = y3.name
and y1.name = y4.name
and y1.name = y5.name
and y1.count < y2.count
and y2.count < y3.count
and y3.count < y4.count
and y4.count < y5.count;



--22--

select cs5160398_maxjournalsyear.name, cs5160398_maxcountyear.year
from cs5160398_maxcountyear, cs5160398_maxjournalsyear
where cs5160398_maxjournalsyear.year = cs5160398_maxcountyear.year
and cs5160398_maxjournalsyear.count = cs5160398_maxcountyear.max
order by year, name;

--23--

select cs5160398_authornumjournal.name, author.name
from cs5160398_maxjournalauthor, cs5160398_authornumjournal, author
where cs5160398_maxjournalauthor.name = cs5160398_authornumjournal.name
and cs5160398_authornumjournal.count = cs5160398_maxjournalauthor.max 
and author.authorid = cs5160398_authornumjournal.authorid
order by cs5160398_maxjournalauthor.name, author.name;

--24--

select venue.name, cast(cs5160398_alldata24.ccount as decimal)/cast(cs5160398_alldata24.pcount as decimal) as IF
from venue, cs5160398_alldata24
where cs5160398_alldata24.venueid = venue.venueid;

--25--





--CLEANUP--

drop view cs5160398_alldata24;
drop view cs5160398_numcited09;
drop view cs5160398_journal0708;
drop view cs5160398_papersin2009;
drop view cs5160398_maxjournalauthor;
drop view cs5160398_authornumjournal;
drop view cs5160398_maxcountyear;
drop view cs5160398_maxjournalsyear;
drop view cs5160398_paperauthorconference;
drop view cs5160398_nocitations;
drop view cs5160398_nevercited;
drop view cs5160398_numcites;
drop view cs5160398_numcitations;
drop view cs5160398_papersnumtcs;
drop view cs5160398_papersintcs;
drop view cs5160398_papersnumieicet;
drop view cs5160398_papersinieicet;
drop view cs5160398_papersnumamc;
drop view cs5160398_papersinamc;
drop view cs5160398_papersnumcorr;
drop view cs5160398_papersincorr;
drop view cs5160398_papersnum2013;
drop view cs5160398_papersin2013;
drop view cs5160398_papersnum2012;
drop view cs5160398_papersin2012;
drop view cs5160398_authornumof1paper;
drop view cs5160398_authornum;
drop view cs5160398_paper1author;
drop view cs5160398_papernum;
drop view cs5160398_papervenue;



























