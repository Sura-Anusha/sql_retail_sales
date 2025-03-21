CREATE TABLE "Retail Analysis"(
transactions_id INT PRIMARY KEY,
Sale_date DATE,
Sale_time TIME,
Customer_id INT,
gender VARCHAR(15),
age INT,
Category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT

);

SELECT*FROM "Retail Analysis";

--DATA CLEANING
UPDATE "Retail Analysis"
SET "age" = (
    SELECT ROUND(AVG("age")) 
    FROM "Retail Analysis"
    WHERE "age" IS NOT NULL
)
WHERE "age" IS NULL;

UPDATE "Retail Analysis"
SET "age" = -1
WHERE "age" IS NULL;

SELECT * FROM "Retail Analysis"
WHERE "age" != -1;


DELETE FROM "Retail Analysis"
WHERE 
    "quantiy" IS NULL
    OR "price_per_unit" IS NULL
    OR "cogs" IS NULL
    OR "total_sale" IS NULL;

SELECT COUNT(*) FROM "Retail Analysis";

--DATA EXPLORATION
--HOW MANY SALES WE HAVE??

SELECT COUNT(*) AS total_sale FROM "Retail Analysis"



--HOW MANY  UNIQUE CUSTOMERS WE HAVE??
SELECT COUNT(DISTINCT customer_id)  AS total_sale FROM "Retail Analysis"

SELECT DISTINCT(category) FROM "Retail Analysis"

--DATA ANALYSIS & BUSINEES KEY PROBLEMS

1)--WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'??
SELECT * 
FROM "Retail Analysis" 
WHERE "sale_date" = '2022-11-05';

2)--WRITE A SQL  QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS "CLOTHING" AND THE QUANTITY IS SOLD MORE THAN 10 IN THE 
--4 IN THE MONTH  OF NOV-2022??


SELECT *
FROM "Retail Analysis"
WHERE 
  category = 'Clothing'
  AND 
  TO_CHAR(sale_date,'YYYY-MMM')='2022-11'
  AND
  quantity>=4



3--Write a sql query to calculate the total sales(total sale) for each category?
SELECT 
  "category",
  SUM(total_sale) AS "net sales",
  COUNT(*) AS "total orders"
FROM 
  "Retail Analysis"
GROUP BY 
  "category";

--4)Write a sql query to find the average age of customers who purchased items from the beauty 'category'.

SELECT
 ROUND(AVG(age),2) AS avg_age
FROM "Retail Analysis"
WHERE 
   category ='Beauty';
 
--5)Write a sql query to find all transactions where the total sale is greater than 1000?
SELECT *
FROM "Retail Analysis"
WHERE total_sale >= 1000;

--6)write a sql query to find the total number of transactions(transaction_id) made by each gender in each category?
SELECT 
category,
gender,
COUNT(*) as total_trans
FROM "Retail Analysis"
GROUP BY category,gender;

	   
--7)write a sql query to calculate the average sale for each month .Find out best selling month in each year?
SELECT
year, month, avg_total_sale,
RANK() OVER(PARTITION BY year ORDER BY avg_total_sale DESC) AS rank
FROM
(
SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_total_sale
FROM
"Retail Analysis"
GROUP BY
year, month
) AS subquery;

--8)write a sql query to find the top 5 customers based on the highest total sales?
SELECT
customer_id,
SUM(total_sale) AS total_Sales
FROM "Retail Analysis"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--9)write a sql query to find the number of unique customers who purchased items for each category?
SELECT
category,
COUNT(DISTINCT(customer_id)) AS cus_unique_cs
FROM "Retail Analysis"
GROUP BY category


