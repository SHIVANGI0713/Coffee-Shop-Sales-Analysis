select concat(round(avg(total_sales)/1000,1),'K')as avg_sales
from 
(select sum(transaction_qty*unit_price) as total_sales
from sales
where month(transaction_date)=5
group by transaction_date
) as x;

-- Daily sales analysis with the average line
select day(transaction_date),sum(transaction_qty*unit_price)
from sales
where month(transaction_date)=5
group by transaction_date
order by transaction_date;

-- Daily sales comparison with the average sales of the month
select 
day_of_month,
case 
when total_sales>avg_sales then 'above average'
when total_sales<avg_sales then 'below average'
else 'average'
end as comparison,
total_sales
from
( select day(transaction_date) as day_of_month,
sum(transaction_qty*unit_price) as total_sales,
avg(sum(transaction_qty*unit_price)) over() as avg_sales
from sales
where month(transaction_date)=5
group by day(transaction_date)
) as x
order by day_of_month;
