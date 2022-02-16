USE Banking;

-- 1. For each product, show the product name "Product" and the product type name "Type".
SELECT NAME, PRODUCT_TYPE_CD AS 'TYPE' FROM product;

-- 2. For each branch, list the branch name and city, plus the last name and title of each employee who works in that branch.
SELECT b.NAME, b.CITY, e.LAST_NAME AS 'LAST NAME', e.TITLE FROM branch b
INNER JOIN employee e ON ASSIGNED_BRANCH_ID=BRANCH_ID;

-- 3. Show a list of each unique employee title.
SELECT TITLE FROM employee e
GROUP BY TITLE;

-- 4. Show the last name and title of each employee, along with the last name and title of that employee's boss.
SELECT e.LAST_NAME AS 'LAST NAME', e.title, m.LAST_NAME AS 'MANAGER NAME', m.title FROM employee e 
LEFT JOIN employee m ON e.SUPERIOR_EMP_ID=m.EMP_ID;

-- 5. For each account, show the name of the account's product, the available balance, and the customer's last name.
SELECT p.NAME, a.AVAIL_BALANCE AS 'AVAILABLE BALANCE', i.LAST_NAME  AS 'LAST NAME' FROM product p
RIGHT JOIN account a ON a.PRODUCT_CD=p.PRODUCT_CD
LEFT JOIN individual i ON i.CUST_ID=a.CUST_ID;

-- 6. List all account transaction details for individual customers whose last name starts with 'T'.
SELECT at2.* FROM acc_transaction at2 
JOIN account a ON a.ACCOUNT_ID = at2.ACCOUNT_ID
JOIN individual i ON i.CUST_ID=a.CUST_ID
WHERE i.LAST_NAME LIKE 't%';

