SELECT * FROM sales;

-- sales data by different store location
select store_location, concat(round(sum(transaction_qty*unit_price)/1000,2),'K') as total_sales
from sales
where month(transaction_date)=5 -- we are getting the sales analysis for the may month of the differebt stores
group by store_location
order by sum(transaction_qty*unit_price) desc;

-- Month on month increase and decrease in sales for different store location
SELECT
store_location,
month(transaction_date) AS sale_month,
round(sum(transaction_qty * unit_price)) AS total_sales,
(SUM(transaction_qty * unit_price) - LAG(SUM(transaction_qty * unit_price), 1)
OVER (ORDER BY month(transaction_date))) / LAG(SUM(transaction_qty * unit_price), 1) 
OVER (ORDER BY month(transaction_date)) * 100 AS percent_change
FROM sales
WHERE month(transaction_date) IN (4, 5)-- where 5 is the present month and 4 is the prev month
GROUP BY  month(transaction_date),store_location
order by store_location,month(transaction_date);

