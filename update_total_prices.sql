UPDATE orders
SET
    order_id = sub.order_id,
    accepted_at = sub.accepted_at,
    total_price = sub.total_price
FROM
    (
        SELECT
            order_id,
            accepted_at,
            SUM(pizza_price) AS total_price
        FROM
            orders
            NATURAL JOIN orders_pizzas
            NATURAL JOIN pizzas
        GROUP BY
            order_id
        ORDER BY
            order_id
    ) AS sub
WHERE
    orders.order_id = sub.order_id;