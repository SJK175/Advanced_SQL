--generating the data
create table product_sale
(product_id varchar(20),
sale integer  );
insert into product_sale values ("P1", 209);
insert into product_sale values ("P2", 332);
insert into product_sale values ("P3", 34);
insert into product_sale values ("P4", 673);
insert into product_sale values ("P5", 102);
insert into product_sale values ("P6", 187);
insert into product_sale values ("P7", 509);
insert into product_sale values ("P8", 442);
insert into product_sale values ("P9", 32);
insert into product_sale values ("P10", 69);
insert into product_sale values ("P11", 67);
insert into product_sale values ("P12", 99);


/*selecting top products that cover 80% of sales*/
with cte1 as 
(select product_id,sale
--calculating running_total and total_sale within query
,sum(sale) over(order by sale desc) as running_tot 
,sum(sale) over() as total_sale   
from
(select product_id
,sale
from product_sale
order by sale desc
) as t0
)

select product_id, sale, sale_pct from 
(select product_id, sale, running_tot, total_sale,
round((running_tot*1.00/total_sale),4) as sale_pct
from cte1)
where sale_pct <= 0.8
