/*Create the table*/
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders 
values(1,100,CAST('20220101' as int),2000)
,(2,200,CAST('20220101' as int),2500)
,(3,300,CAST('20220101' as int),2100)
,(4,100,CAST('20220102' as int),2000)
,(5,400,cast('20220102' as int),2200)
,(6,500,cast('20220102' as int),2700)
,(7,100,cast('20220103' as int),3000)
,(8,400,cast('20220103' as int),1000)
,(9,600,cast('20220103' as int),3000)
;

--select * from customer_orders

/*output*/


with min_order_date_cte as (
select customer_id
,min(order_date) as min_order_dt
from customer_orders
group by customer_id
),
joined_table as
(select co.order_date
,co.customer_id
,co.order_amount
,modc.min_order_dt
,case when co.order_date = modc.min_order_dt then 1 else 0 end as flag_n
,case when co.order_date != modc.min_order_dt then 1 else 0 end as flag_r 
from customer_orders as co
left join min_order_date_cte as modc
on co.customer_id = modc.customer_id)  

  
select tbl1.order_date
,tbl1.new_cust_count
,tbl1.repeat_cust_count
,tbl2.new_cust_order
,tbl3.repeat_cust_order
from
--this calculates the count of new & repeat customers
(select t1.order_date
,sum(t1.flag_n) as new_cust_count
,sum(t1.flag_r) as repeat_cust_count
from joined_table as t1
group by t1.order_date) as tbl1
--this calculates the sum of order of new customers
LEFT JOIN
(select t1.order_date
,sum(t1.order_amount) as new_cust_order
from joined_table as t1
where t1.flag_n = 1
group by t1.order_date) as tbl2
ON tbl1.order_date = tbl2.order_date
--this calculates the sum of order of repeat customers
LEFT JOIN
(select t1.order_date
,sum(t1.order_amount) as repeat_cust_order
from joined_table as t1
where t1.flag_r = 1
group by t1.order_date) as tbl3
ON tbl1.order_date = tbl3.order_date



