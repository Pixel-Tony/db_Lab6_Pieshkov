UPDATE orders
SET
    total_price = sub.total_price
FROM
    (
        SELECT
            order_id,
            SUM(pizzas.pizza_price * orders_pizzas.quantity) AS total_price
        FROM
            orders
            NATURAL JOIN orders_pizzas
            NATURAL JOIN pizzas
        GROUP BY
            order_id
    ) AS sub
WHERE
    orders.order_id = sub.order_id;