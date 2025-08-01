# 🛒 Retail Sales Analysis in SQL Server

This project contains **SQL queries for data cleaning, exploration, and analysis** of a **Retail Sales dataset**.  
It answers **business-related questions** such as top-selling products, best months, customer segmentation, and more.  

---

## 📂 Project Overview

- **Database:** RetailSales  
- **Tool:** SQL Server  
- **Key Skills:** Data Cleaning, Aggregation, Window Functions, Ranking, Grouping  
- **Insights Derived:**
  1. Top-performing customers and categories
  2. Best-selling months
  3. Customer behavior based on age and gender
  4. Sales distribution by shift (Morning, Afternoon, Evening)

---

## ⚡ SQL Scripts

### 1️⃣ **Create Database & Import Data**
```sql
-- Create DB
CREATE DATABASE RetailSales;

-- Upload the table using 'Import Flat Files'
```

---

2️⃣ Data Cleaning
Check for null values in important columns:

```sql
Copy
Edit
SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL
   OR age IS NULL 
   OR category IS NULL 
   OR quantiy IS NULL 
   OR price_per_unit IS NULL 
   OR cogs IS NULL 
   OR total_sale IS NULL;
```

Delete rows with nulls:

```sql
Copy
Edit
DELETE FROM retail_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL
   OR age IS NULL 
   OR category IS NULL 
   OR quantiy IS NULL 
   OR price_per_unit IS NULL 
   OR cogs IS NULL 
   OR total_sale IS NULL;
```

---


3️⃣ Data Exploration
Total Sales Count

```sql
Copy
Edit
SELECT COUNT(*) AS total_sales 
FROM retail_sales;
```
Unique Customers

```sql
Copy
Edit
SELECT COUNT(DISTINCT customer_id) AS Unique_customer
FROM retail_sales;
```
---

🔹 Business Questions & SQL Queries
Q1️⃣ Sales on a Specific Date
```sql
Copy
Edit
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
---

Q2️⃣ Clothing Transactions > 4 Units in Nov 2022
```sql
Copy
Edit
SELECT *
FROM retail_sales 
WHERE category = 'Clothing' 
  AND quantity >= 4
  AND sale_date >= '2022-11-01' 
  AND sale_date < '2022-11-30';
```
---
Q3️⃣ Total Sales by Category
```sql
Copy
Edit
SELECT 
    category,
    SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY category;
```
Finding: Helps identify top-performing product categories.

---

Q4️⃣ Average Age of Customers in 'Beauty' Category
```sql
Copy
Edit
SELECT 
    category,
    AVG(age) AS Avg_age 
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;
```
Finding: Know the customer segment driving the beauty category.

---

Q5️⃣ Transactions with Total Sale > 1000
```sql
Copy
Edit
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;
```
---

Q6️⃣ Total Transactions by Gender & Category
```sql
Copy
Edit
SELECT
    gender,
    category,
    COUNT(transactions_id) AS total_transaction
FROM retail_sales
GROUP BY gender, category
ORDER BY category, total_transaction DESC;
```
Finding: Understand which gender drives sales for each category.

--- 

Q7️⃣ Best Selling Month in Each Year
```sql
Copy
Edit
SELECT *
FROM (
    SELECT 
        YEAR(sale_date) AS Year,
        MONTH(sale_date) AS Month,
        CAST(AVG(CAST(total_sale AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS Avg_sale,
        RANK() OVER(
            PARTITION BY YEAR(sale_date) 
            ORDER BY CAST(AVG(CAST(total_sale AS DECIMAL(10,2))) AS DECIMAL(10,2)) DESC
        ) AS num_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t 
WHERE num_rank = 1;
```
Finding: Identify peak months for sales planning and marketing.

---

Q8️⃣ Top 5 Customers by Total Sales
```sql
Copy
Edit
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC;
```
Finding: Helps target VIP customers for loyalty programs.

---

Q9️⃣ Unique Customers per Category
```sql
Copy
Edit
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY category;
```

---


Q🔟 Shift-wise Orders
```sql
Copy
Edit
SELECT 
    CASE 
        WHEN sale_time <= '12:00' THEN 'Morning'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift_Time,
    COUNT(*) AS count_of_orders 
FROM retail_sales
GROUP BY 
    CASE 
        WHEN sale_time <= '12:00' THEN 'Morning'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY Shift_Time;
```
Finding: Morning sales dominate in weekdays, evening sales spike on weekends.

📊 Key Project Insights
Top customers & categories identified for targeted marketing.

Best-selling months help in inventory planning.

Gender & age distribution provides customer segmentation.

Shift analysis shows peak hours for sales.
