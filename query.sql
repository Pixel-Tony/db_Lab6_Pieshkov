SELECT
    UPPER(TRIM(pizza_size)) AS pizza_size,
    ROUND(AVG(pizza_price), 2)
FROM
    pizzas
    JOIN (
        VALUES
            ('S', 0),
            ('M', 1),
            ('L', 2),
            ('XL', 3),
            ('XXL', 4)
    ) AS Size_Order (pizza_size, pizza_index) USING (pizza_size)
GROUP BY
    pizza_size,
    pizza_index
ORDER BY
    pizza_index;

SELECT
    SUM(pizza_price) AS total_price,
    order_id
FROM
    orders
    NATURAL JOIN orders_pizzas
    NATURAL JOIN pizzas
GROUP BY
    order_id
ORDER BY
    total_price DESC
LIMIT
    5;

SELECT
    ingredient_count,
    ROUND(AVG(pizza_price), 2) AS avg_price
FROM
    (
        SELECT
            pizza_price,
            COUNT(ingredient_id) AS ingredient_count
        FROM
            pizzas
            JOIN pizzas_ingredients USING (pizza_id)
        GROUP BY
            pizza_id
    )
GROUP BY
    ingredient_count
ORDER BY
    ingredient_count