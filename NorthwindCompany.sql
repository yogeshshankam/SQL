sql
WITH CustomerEmail2223 AS
(
    SELECT so.entityId, c.contactName, so.shipCountry, c.email
    FROM Customer c
    LEFT JOIN SalesOrder so ON so.customerId = c.entityId
    WHERE c.email is not NULL  
    AND  (strftime('%Y',so.orderDate) = '2022' OR strftime('%Y',so.orderDate) = '2023')
)

SELECT ce.shipCountry, count(ce.email)
FROM CustomerEmail2223 ce
LEFT JOIN OrderDetail od ON od.orderID = ce.entityId
LEFT JOIN Product p ON p.entityId = od.productId
LEFT JOIN Supplier s ON s.entityId = p.supplierId
WHERE od.discount > 5.0
AND s.country <> ce.shipCountry
GROUP BY ce.shipCountry;
