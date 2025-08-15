# Task 8 – Stored Procedures and Functions
# Objective

To learn how to create and use Stored Procedures and Functions in MySQL for reusable SQL logic.

# Tools Used

MySQL 8.0 (Community Server)

MySQL Workbench

OS: Windows 11

# Database Used

Database Name: e_commerce

# Tables:

customers – Stores customer details

categories – Stores product categories

products – Stores product details

orders – Stores order information

orderdetails – Stores product details per order

payments – Stores payment details

# Stored Procedure – GetCustomerOrders

Purpose: To retrieve all orders placed by a specific customer along with payment details.

DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT 
        o.OrderID,
        o.OrderDate,
        o.Status,
        p.PaymentMethod,
        p.Amount
    FROM Orders o
    LEFT JOIN Payments p ON o.OrderID = p.OrderID
    WHERE o.Customer_ID = cust_id;
END $$

DELIMITER ;

-- Call Procedure
CALL GetCustomerOrders(1);


Explanation:

IN cust_id → Takes customer ID as input.

Joins Orders and Payments to show order details and payment info for that customer.

Sample Output:

OrderID	     OrderDate	Status	PaymentMethod	Amount
1	2025-08-01 10:30:00	  Shipped	      UPI     80997.00
# Function – GetOrderTotal

Purpose: To calculate the total price of an order based on quantity and price at purchase.

DELIMITER $$

CREATE FUNCTION GetOrderTotal(ord_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_amount DECIMAL(10,2);

    SELECT SUM(Quantity * PriceATPurchase)
    INTO total_amount
    FROM OrderDetails
    WHERE OrderID = ord_id;

    RETURN total_amount;
END $$

DELIMITER ;

-- Use Function
SELECT OrderID, GetOrderTotal(OrderID) AS Total_Amount
FROM Orders;


Explanation:

Takes ord_id (Order ID) as input.

Multiplies each product’s quantity by price and returns the total sum.

Sample Output:

OrderID	Total_Amount
1	      80997.00
2     	350.00


# Outcome

By completing this task, I learned to:

Create and execute Stored Procedures with parameters.

Create and use Functions to return calculated values.

Understand the difference between procedures and functions.

Work with joins, parameters, and aggregate functions in MySQL.
