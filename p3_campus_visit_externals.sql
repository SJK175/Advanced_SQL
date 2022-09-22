/*create input table*/
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor varchar(20),
resources varchar(10));
insert into entries 
values ('subhajit','kolkata','s.gmail.com','F1','CPU'),('subhajit','kolkata','s.yahoo.com','F1','CPU'),('subhajit','kolkata','s.hmail.com','F2','DESKTOP'),
('jaydeep','Bangalore','j.yahoo.com','F2','DESKTOP'),('jaydeep','Bangalore','j.yahoo.com','F2','DESKTOP'),('jaydeep','Bangalore','j.gmail.com','F1','MONITOR');



/*output*/
select a.name, a.tot_visit, b.floor, c.resources_used
from
--counting total visit 
(select name 
,count(name) as tot_visit
from entries
group by name) as a
--counting the max used floor
left join
(select name, floor from
(select name
,floor
,floor_visit 
,rank() over(partition by name order by floor_visit desc) as rnk
from
(select name
,floor
,count(1) as floor_visit
from entries
group by name, floor) as t3) as t4
where rnk = 1) as b
on a.name = b.name
--distinct resources used
left join
(select name
,GROUP_CONCAT(resources,",") as resources_used
from
(select distinct name, resources
from entries) t4
group by name) as c
on a.name = c.name
