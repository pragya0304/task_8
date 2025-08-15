use e_commerce;
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

-- Call the procedure
CALL GetCustomerOrders(1);

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

-- Use the function
SELECT OrderID, GetOrderTotal(OrderID) AS Total_Amount
FROM Orders;

