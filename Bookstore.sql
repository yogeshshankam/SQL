sql
SELECT 
    first_name, 
    last_name, 
    street_number, 
    street_name, 
    city, 
    country_name, 
    email
FROM (
    SELECT 
        c.first_name, 
        c.last_name, 
        a.street_number, 
        a.street_name, 
        a.city, 
        co.country_name, 
        c.email,
        SUM(ol.price) AS total_price,
        ROW_NUMBER() OVER (PARTITION BY co.country_id ORDER BY SUM(ol.price) DESC) AS row_num
    FROM 
        customer c
    JOIN 
        cust_order coo ON c.customer_id = coo.customer_id
    JOIN 
        order_line ol ON coo.order_id = ol.order_id
    JOIN 
        address a ON coo.dest_address_id = a.address_id
    JOIN 
        country co ON a.country_id = co.country_id
    WHERE 
        coo.order_date > DATE('now', '-2 years')
    GROUP BY 
        co.country_id, 
        c.customer_id
) AS subquery
WHERE 
    row_num <= 5
ORDER BY 
    country_name, 
    total_price DESC
