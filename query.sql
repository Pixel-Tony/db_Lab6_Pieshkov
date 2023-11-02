/*
 * Запит 1 - Вартість, яку заплатили за кожен заказ.
 * (цей же запит використовується в populate.sql для початкового заповнення
 *  поля total_price)
 */
SELECT
    order_id,
    accepted_at,
    SUM(pizza_price) AS total_price
FROM
    orders
    NATURAL JOIN orders_pizzas
    NATURAL JOIN pizzas
GROUP BY
    order_id,
    accepted_at
ORDER BY
    order_id;

/* Запит 2 - Розподіл середньої кількості інгредієнтів за розміром піцци. */
SELECT
    pizza_size,
    ROUND(AVG(ingredient_count), 4) AS avg_ingredient_count
FROM
    pizzas
    NATURAL JOIN (
        SELECT
            pizza_id,
            COUNT(ingredient_id) AS ingredient_count
        FROM
            pizzas_ingredients
        GROUP BY
            pizza_id
    )
GROUP BY
    pizza_size;

/*
 * Запит 3 - піцци, їх ціна та кількість інгредієнтів у кожній,
 * відсортовані за зростанням ціни
 */
SELECT
    pizza_id,
    pizza_price,
    COUNT(pizzas_ingredients) as ingredient_count
FROM
    pizzas
    NATURAL JOIN pizzas_ingredients
GROUP BY
    pizza_id,
    pizza_price
ORDER BY
    pizza_price,
    ingredient_count;