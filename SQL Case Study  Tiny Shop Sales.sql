-- Case Study Questions

--1) Which product has the highest price? Only return a single row.

SELECT TOP 1 product_name,price FROM products
ORDER BY price DESC


--2) Which customer has made the most orders?

SELECT TOP 1 CUST.customer_id, (CUST.first_name + CUST.last_name) AS CUSTOMER,OI.quantity FROM order_items AS OI
JOIN orders AS ORD
ON OI.order_id = ORD.order_id 
JOIN customers AS CUST 
ON CUST.customer_id = ORD.customer_id

ORDER BY OI.quantity DESC

--3) What’s the total revenue per product?

SELECT PRO.product_name,(SUM (PRO.price * OI.quantity)) AS [TOTAL REVENUE] FROM products AS PRO
JOIN order_items AS OI
ON PRO.product_id = OI.product_id
GROUP BY product_name

--4) Find the day with the highest revenue.

SELECT TOP 1 ORD.order_date, (SUM (PRO.price * OI.quantity)) AS [TOTAL REVENUE] FROM products AS PRO
JOIN order_items AS OI
ON PRO.product_id = OI.product_id
JOIN ORDERS AS ORD 
ON ORD.order_id = OI.order_id
GROUP BY  ORD.order_date
ORDER BY [TOTAL REVENUE] DESC

--5) Find the first order Find the first order (by date) for each customer for each customer.

WITH CTE_DATE AS 
(SELECT (CUST.first_name + ' ' + CUST.last_name) AS CUSTOMER, ORD.order_date AS DATE FROM customers AS CUST
JOIN ORDERS AS ORD 
ON CUST.customer_id = ORD.customer_id
JOIN order_items AS OI
ON OI.order_id = ORD.order_id
)
SELECT  CUSTOMER,MIN(DATE) AS [FIRST ORDER (by date)] FROM CTE_DATE
GROUP BY CUSTOMER

--6) Find the top 3 customers who have ordered the most distinct products

WITH CTE_PRODUCT AS
(SELECT (CUST.first_name + ' ' + last_name) AS CUSTOMER, product_name,quantity FROM customers AS CUST
JOIN orders AS OD 
ON CUST.customer_id = OD.customer_id
JOIN order_items AS OI
ON OI.order_id = OD.order_id
JOIN products AS PRO
ON PRO.product_id = OI.product_id
)
SELECT TOP 3   CUSTOMER,SUM(quantity) AS [TOTAL QUANTITY]  FROM CTE_PRODUCT
GROUP BY CUSTOMER,product_name 
ORDER BY [TOTAL QUANTITY]  DESC

--7) Which product has been bought the least in terms of quantity?

SELECT product_name,SUM(quantity) AS QUANTITY FROM order_items AS OI
JOIN products AS PRO
ON OI.product_id = PRO.product_id
GROUP BY product_name
ORDER BY QUANTITY

--8) What is the median order total?

SELECT DISTINCT PERCENTILE_CONT(.5) WITHIN GROUP (ORDER BY SUM(OI.quantity * PRO.price)) OVER (PARTITION BY 1) AS MEDIAN
FROM order_items AS OI
JOIN products AS PRO
ON OI.product_id = PRO.product_id
GROUP BY ORDER_ID
--9) For each order, determine if it was ‘Expensive’ (total over 300), ‘Affordable’ (total over 100), or ‘Cheap’.

SELECT ORDER_ID, SUM(OI.quantity * PRO.price) AS [ORDER TOTAL],
CASE WHEN 
 SUM(OI.quantity * PRO.price)  > '300' THEN 'EXPENSIVE'
 WHEN
 SUM (OI.quantity * PRO.price)  > '100' THEN 'AFFORDABLE'
ELSE 'CHEAP' END AS [ORDER CATEGORY]
FROM order_items AS OI
JOIN products AS PRO
ON OI.product_id = PRO.product_id
GROUP BY ORDER_ID
ORDER BY [ORDER TOTAL]


--10) Find customers who have ordered the product with the highest price.

WITH CTE_PRODUCT AS
(SELECT (CUST.first_name + ' ' + last_name) AS CUSTOMER, product_name,PRICE FROM customers AS CUST
JOIN orders AS OD 
ON CUST.customer_id = OD.customer_id
JOIN order_items AS OI
ON OI.order_id = OD.order_id
JOIN products AS PRO
ON PRO.product_id = OI.product_id
)
SELECT  TOP 10  CUSTOMER, product_name,PRICE FROM CTE_PRODUCT
ORDER BY PRICE DESC

