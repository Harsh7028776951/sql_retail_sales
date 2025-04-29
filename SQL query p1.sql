SELECT * FROM retail_sales

-- Data Exploration
-- How may sales we have?

SELECT COUNT(*) as total_sale FROM retail_Sales

-- Shows hw may unique Costumers are there?
SELECT COUNT(DISTINCT customer_id) as cust_id FROM retail_Sales

SELECT DISTINCT category as catg FROM retail_Sales

-- Data Analysis

-- Q1 write a Sql query to retrive all columns for sales made on '2022-11-05'?
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022?

SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date,'YYYY-MM')= '2022-11'
	AND 
	quantiy >= 4
	
-- Write a SQL query to calculate the total sales (total_sale) for each category?
SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*)total_orders
FROM retail_sales
GROUP BY category

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category?
SELECT
	category,
	SUM(age) as total,
	ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 1

-- Write a SQL query to find all transactions where the total_sale is greater than 1000?

SELECT * FROM retail_sales
WHERE total_sale > 100

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?
SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP BY
	category,gender
ORDER BY 1

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?

SELECT 
	    year,
		month,
		total_sale
FROM 
(
	SELECT
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as total_sale,
		RANK () OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale)DESC) as rank
	FROM retail_sales
	GROUP BY 1,2
) as t1
WHERE rank = 1


-- Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
	customer_id,
	SUM(total_sale) as total_sales	
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Write a SQL query to find the number of unique customers who purchased items from each category?
SELECT
	category,
	COUNT (DISTINCT customer_id) as unique_cust
FROM retail_sales
GROUP BY category

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?

WITH hourly_sale 
AS
(
SELECT *,
	CASE
	WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END as shift	
FROM retail_sales
)
SELECT
	shift,
	COUNT (*) total_sales
FROM hourly_sale
GROUP BY shift
















