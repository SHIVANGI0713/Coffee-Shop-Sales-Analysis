SELECT * FROM sales;

-- All the info about the particular date
select concat(round(sum(transaction_qty*unit_price)/1000,1),'K') as total_sales,
concat(round(count(transaction_id)/1000,1),'K') as total_orders,
concat(round(sum(transaction_qty)/1000,1),'K') as total_quantity_sold
from sales
where transaction_date='2023-05-18';

-- Sales analysis by weekdays and weekends
select
case
when dayofweek(transaction_date) in (1,7) then 'weekends'
else ' weekdays'
end as day_type,
concat(round(sum(transaction_qty*unit_price)/1000,1),'K')
from sales
where month(transaction_date)=2
group by
 case
when dayofweek(transaction_date) in (1,7) then 'weekends'
else ' weekdays'
end;