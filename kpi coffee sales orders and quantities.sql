SELECT * FROM sales;

-- Total sales for each respective month
select month(transaction_date),concat(round(sum(transaction_qty*unit_price))/1000,'K') as total_sales
from sales
group by month(transaction_date)
order by month(transaction_date) ;

-- Month on month increase and decrease in sales
select month(transaction_date) as month,
round(sum(transaction_qty*unit_price)) as total_sales,
(sum(transaction_qty*unit_price)-lag(sum(transaction_qty*unit_price),1) -- difference between the current and prev month sales
over(order by month(transaction_date)))/lag(sum(transaction_qty*unit_price),1) -- divided by the prev month sales 
over(order by month(transaction_date))*100 as percentage -- percentage of increase or decrease
from sales
where month(transaction_date) in (4,5) -- where 5 is the present month and 4 is the prev month
group by month(transaction_date);

-- Total no. of orders for each respective month
select month(transaction_date),count(transaction_id) as number_of_orders
from sales
group by month(transaction_date)
order by month(transaction_date) ;

-- Month on month increase and decrease in orders
select month(transaction_date) as month,
count(transaction_id) as total_orders,
(count(transaction_id)-lag(count(transaction_id),1) -- difference between the current and prev month no. of orders
over(order by month(transaction_date)))/lag(count(transaction_id),1) -- divided by the prev month no. of orders 
over(order by month(transaction_date))*100 as percentage -- percentage of increase or decrease
from sales
where month(transaction_date) in (4,5) -- where 5 is the present month and 4 is the prev month
group by month(transaction_date);

-- Total quantity sold for each respective month
select month(transaction_date),sum(transaction_qty) as total_quantity_sold
from sales
group by month(transaction_date)
order by month(transaction_date) ;

-- Month on month increase and decrease in quantity
select month(transaction_date) as month,
sum(transaction_qty) as total_quantity,
(sum(transaction_qty)-lag(sum(transaction_qty),1) -- difference between the current and prev month no. of orders
over(order by month(transaction_date)))/lag(sum(transaction_qty),1) -- divided by the prev month no. of orders 
over(order by month(transaction_date))*100 as percentage -- percentage of increase or decrease
from sales
where month(transaction_date) in (4,5) -- where 5 is the present month and 4 is the prev month
group by month(transaction_date);