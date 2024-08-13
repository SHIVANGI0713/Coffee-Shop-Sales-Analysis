-- SALES ANALYSIS BY PRODUCT CATEGORY
select product_category,
concat(round(sum(transaction_qty*unit_price)/1000,1),'K') as total_sales
from sales 
where month(transaction_date)
group by product_category
order by sum(transaction_qty*unit_price) desc;

-- TOP 10 PRODUCT TYPE
select product_type,
concat(round(sum(transaction_qty*unit_price)/1000,1),'K') as total_sales
from sales 
where month(transaction_date)=5 and product_category='Coffee'
group by product_type
order by sum(transaction_qty*unit_price) desc limit 10;

-- SALES ANALYSIS BY DAYS AND HOURS
select concat('$',round(sum(transaction_qty*unit_price))) as total_sales,
count(transaction_id) as total_orders,
sum(transaction_qty) as total_qty_sold
from sales
where month(transaction_date)=5 
and dayofweek(transaction_date)=1 -- for sunday
and hour(transaction_time)=14;

-- SALES ANALYSIS BY THE TOTAL SALES MADE IN AN HOUR
select hour(transaction_time) as hours, concat(round(sum(transaction_qty*unit_price)/1000,1),'K') as total_sales
from sales
where month(transaction_date)=5
group by hour(transaction_time)
order by sum(transaction_qty*unit_price) desc;

-- SALES ANALYSIS BY THE TOTAL SALES MADE IN A DAY
select 
dayname(transaction_date) as week_dayname,concat(round(sum(transaction_qty*unit_price)/1000,1),'K') as total_sales
from sales
where  month(transaction_date)=5
group by dayname(transaction_date);