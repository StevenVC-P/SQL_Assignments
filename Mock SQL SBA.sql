use mock_sba_db;


-- 1. Create a query to return all orders made by users with the first name of “Marion” 
SELECT ORDER_ID, o.USER_ID, o.STORE_ID  FROM orders o
LEFT JOIN users u ON o.USER_ID=u.USER_ID 
LEFT JOIN stores s ON o.STORE_ID=s.STORE_ID WHERE u.FIRST_NAME='Marion'
GROUP BY o.ORDER_ID ;

-- 2. Create a query to select all users that have not made an order 
SELECT * FROM users
WHERE USER_ID NOT IN (SELECT USER_ID FROM orders);

-- 3. Create a Query to select the names and prices of all items that have been part of 2 or more separate orders. 
SELECT * FROM items i
JOIN order_items oi ON oi.ITEM_ID=i.ITEM_ID
WHERE (SELECT COUNT(order_items.ORDER_ID)) >= 2
GROUP BY oi.ITEM_ID;

SELECT * FROM items i
JOIN order_items oi ON oi.ITEM_ID=i.ITEM_ID
GROUP BY oi.ORDER_ID;


SELECT * FROM order_items oi
RIGHT JOIN items i ON oi.ITEM_ID=i.ITEM_ID;
GROUP BY oi.ORDER_ID;

HAVING COUNT(oi.ITEM_ID) >= 2
HAVING COUNT(oi.ORDER_ID) >= 2;
WHERE COUNT(oi.ORDER_ID) >= 2
WHERE oi.QUANTITY >= 2

LEFT JOIN orders o ON o.USER_ID=u.USER_ID
GROUP BY u.USER_ID

-- 4. Create a query to return the Order Id, Item name, Item Price, and Quantity from orders made at stores in the city “New York”. Order by Order Id in ascending order. 

SELECT o.ORDER_ID, i.NAME 'NAME', i.PRICE 'Item Price', oi.QUANTITY 'Quantity' 
FROM orders o 
JOIN order_items oi ON oi.ORDER_ID=o.ORDER_ID
JOIN items i ON i.ITEM_ID=oi.ITEM_ID 
JOIN stores s ON s.STORE_ID=o.STORE_ID  WHERE s.CITY ="New York"
ORDER BY o.ORDER_ID;

-- 5. Your boss would like you to create a query that calculates the total revenue generated by each item. 
-- Revenue for an item can be found as (Item Price * Total Quantity Ordered). 
-- Please return the first column as ‘ITEM_NAME’ and the second column as ‘REVENUE’. 

SELECT i.NAME, SUM(i.PRICE*oi.QUANTITY) 'Revenue'
FROM order_items oi 
JOIN items i ON i.ITEM_ID=oi.ITEM_ID
GROUP BY i.ITEM_ID ORDER BY `Revenue`DESC;

-- 6. Create a query with the following output: 
-- a. Column 1 - Store Name 
-- 	i. The name of each store 
-- b. Column 2 - Order Quantity 
-- 	i. The number of times an order has been made in this store 
-- c. Column 3 - Sales Figure 
-- 	i. If the store has been involved in more than 3 orders, mark as ‘High’ 
-- 	ii. If the store has been involved in less than 3 orders but more than 1 order, 
-- 		mark as ‘Medium’ 
-- 	iii. If the store has been involved with 1 or less orders, mark as ‘Low’ 
-- d. Should be ordered by the Order Quantity in Descending Order 

SELECT s.Name, COUNT(ORDER_ID) 'ORDER_QUANTITY', 
	IF(COUNT(ORDER_ID) > 3, 'High', IF(COUNT(ORDER_ID) <= 3 AND COUNT(ORDER_ID)>1, 'Medium', 'Low')) 'SALES_FIGURE'
FROM orders o 
JOIN stores s ON s.STORE_ID=o.STORE_ID
GROUP BY s.STORE_ID
ORDER BY COUNT(ORDER_ID) DESC;
