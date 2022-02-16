USE classicmodels;

SELECT c.customerName AS 'Customer Name', CONCAT(e.lastName, ', ', e.firstName) AS 'Sales Rep' FROM customers c
JOIN employees e WHERE e.employeeNumber = c.salesRepEmployeeNumber
ORDER BY c.customerName ASC;

SELECT p.productName AS 'NAME', SUM(o.quantityOrdered) AS 'Total # Ordered', SUM(o.quantityOrdered*o.priceEach) AS 'Total Sale'
FROM orderdetails o
JOIN products p WHERE o.productCode=p.productCode
GROUP BY o.productCode ORDER BY `Total Sale` DESC;

SELECT o.status AS 'Order Status', COUNT(o.status) AS '# Ordered' FROM orders o 
GROUP BY o.status;

SELECT productLine 'Product Line', SUM(o.quantityOrdered) '# Sold' FROM products p
JOIN orderdetails o WHERE p.productCode=o.productCode
GROUP BY p.productLine ;

SELECT CONCAT(e.lastName, ', ', e.firstName) 'Sales Rep', COUNT(o.orderNumber) '# Orders', IF(od.quantityOrdered IS NULL, '0.00',SUM(od.quantityOrdered*od.priceEach)) AS 'Total Sales'
FROM employees e 
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o ON c.customerNumber = o.customerNumber 
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber  WHERE e.jobTitle ='Sales Rep'
GROUP BY e.employeeNumber ORDER BY SUM(od.quantityOrdered*od.priceEach) DESC;


SELECT MONTHNAME(paymentDate) 'Month', CAST(Year(paymentdate) AS VARCHAR(4)) AS 'YEAR', FORMAT(SUM(amount),2) AS 'Payments Recieved'
	FROM payments
	GROUP BY 2 ,1
	ORDER BY paymentDate;
	
SELECT * FROM payments;