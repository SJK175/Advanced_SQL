/*Create the input table*/
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

/*output*/
select team_name
, sum(played) as total_played
, sum(win_count) as total_win
from
(select Team_1 as team_name
,case when Team_1 = Winner then 1 else 0 end as win_count
,1 as played  
from icc_world_cup
union all
select Team_2 as team_name
,case when Team_2 = Winner then 1 else 0 end as win_count
,1 as played  
from icc_world_cup) as t1
group by team_name
