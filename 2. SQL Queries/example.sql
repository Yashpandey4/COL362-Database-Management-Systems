create table example(id integer, name char(200), address varchar(500));

insert into example values(1,'John','New York');

insert into example values(2,'Smith','New Jersey');

select * from example;

select name from example where address='New York';

drop table example;
