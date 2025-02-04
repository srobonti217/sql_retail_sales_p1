
--sql_sales_retail_analysis- p1



--create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
  (
    transactions_id	INT PRIMARY KEY,
    sale_date	DATE,
    sale_time	TIME,
    customer_id	 INT,
    gender	VARCHAR(10),
    age	 INT,
    category	VARCHAR(15),
    quantiy	 INT,
    price_per_unit	FLOAT,
    cogs	FLOAT,
    total_sale FLOAT

   );
SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*)
FROM retail_sales

--data cleaning

SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

   DELETE FROM retail_sales
   WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

	--data exploration
	
	--how many sales we have?
	SELECT COUNT(*) AS total_sale FROM retail_sales

	--how many UNIQUE customers we have?
	SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales
    --how many UNIQUE cATEGORY we have?
	SELECT COUNT(DISTINCT category) AS total_sale FROM retail_sales
	SELECT DISTINCT category FROM retail_sales

	-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
sum(total_sale)as net_sale,
COUNT(*)as total_orders
from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(avg(age),2)AS avarage_age
from retail_sales
WHERE category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
from retail_sales
Where total_sale > '1000'

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,
gender,
count(*)as total_trans
from retail_sales
group by category, gender
order by 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


select 
year,
month,
avg_sale
from (select 
extract (year from sale_date) as year,
extract (month from sale_date) as month,
avg(total_sale) as avg_sale,
rank()over(partition by extract (year from sale_date) order by avg(total_sale)desc)as rank
from retail_sales
GROUP By 1,2) as t1
where rank=1;
--ORDER BY 1,3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
customer_id,
sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category,
count(distinct customer_id)
from retail_sales
group by 1
 
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale
as
(select * ,
case
     when extract (hour from sale_time) < 12 then 'morning'
	 when extract (hour from sale_time) between 12 and 17 then 'afternoon'
	 else 'Evening'
end as shift
from retail_sales)
select 
shift,
count(*)as total_order
from hourly_sale 
group by shift

--End of Project
