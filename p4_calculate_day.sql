/*write a query to provide a date of "n"th occurrence of Sunday from a given date*/

/*inputs*/
create table icc_world_cup
(id varchar(20),
given_date date);
insert into icc_world_cup values ("1","2022-09-21");
declare @n int
set @n = 3

/*output*/
select DATEADD(week, @n-1, calc_days) from 
(select DATEADD(day, 8-day_off_week, given_date) as calc_days from
(select DATEPART(weekday, '2022-09-21') as day_of_week
from icc_world_cup
where id = "1") as t1
) as t2

