--Data Cleaning 
select * 
from retail_sales
where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null
or age is null 
or category is null 
or quantiy is null 
or price_per_unit is null 
or cogs is null 
or total_sale is null 


--------------------

Delete from retail_sales
where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null
or age is null 
or category is null 
or quantiy is null 
or price_per_unit is null 
or cogs is null 
or total_sale is null 
-- Data Exploration 

-- Total Sales 
select 
count(*) as total_sales 
from retail_sales


--Unique customer 
select 
count(distinct customer_id) as Unique_customer
from retail_sales


-- Data Analysis & Business Key Problems & Answers


-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select 
* 
from retail_sales
where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select 
*
from retail_sales 
where category = 'Clothing' 
and quantity >= 4
and sale_date >= '2022-11-01' and sale_date < '2022-11-30'


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
category ,
sum(total_sale) as total_Sale
from retail_sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
category,
avg(age) as Avg_age 
from retail_sales
where category = 'Beauty'
group by category


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
* 
from retail_sales
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
gender,
category,
count(transactions_id) as total_transaction
from retail_sales
group by gender, category
order by category, total_transaction desc


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
* from (
select 
year(sale_date) as Year,
month(sale_date) as Month,
CAST(AVG(CAST(total_sale AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Avg_sale,
rank() over(partition by Year(sale_date) order by CAST(AVG(CAST(total_sale AS DECIMAL(10,2))) AS DECIMAL(10,2)) desc) as num_rank
from retail_sales
group by Year(sale_date), Month(sale_date)
)t 
where num_rank = 1



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select top 5
customer_id ,
sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select
category,
count(distinct customer_id) as unique_customer
from retail_sales
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
case 
	when sale_time <= '12:00' then 'Morning'
	when sale_time between '12:00:00' and '17:00:00' then 'Afternoon'
	else 'Evening'
	end as Shift_Time,
count(*) as count_of_orders 
from retail_sales
group by case 
	when sale_time <= '12:00' then 'Morning'
	when sale_time between '12:00:00' and '17:00:00' then 'Afternoon'
	else 'Evening'
	end
order by Shift_Time
