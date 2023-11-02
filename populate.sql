TRUNCATE TABLE Pizzas_Ingredients, Orders_Pizzas, Pizzas, Orders, Ingredients, Categories;
INSERT INTO
    Categories (category_id, category_name)
VALUES
    (1, 'Classic'),
    (2, 'Supreme'),
    (3, 'Veggie');
INSERT INTO
    Ingredients (ingredient_id, ingredient_name)
VALUES
    (1, 'Mozzarella Cheese'),
    (2, 'Pepperoni'),
    (3, 'Tomato Sauce'),
    (4, 'Coarse Sicilian Salami'),
    (5, 'Green Olives'),
    (6, 'Luganega Sausage'),
    (7, 'Tomatoes'),
    (8, 'Onions'),
    (9, 'Garlic'),
    (10, 'Pineapple'),
    (11, 'Sliced Ham'),
    (12, 'Bacon'),
    (13, 'Chorizo Sausage'),
    (14, 'Italian Sausage'),
    (15, 'Smoked Gouda Cheese'),
    (16, 'Provolone Cheese'),
    (17, 'Romano Cheese'),
    (18, 'Blue Cheese'),
    (19, 'Ricotta Cheese'),
    (20, 'Gorgonzola Piccante Cheese'),
    (21, 'Parmigiano Reggiano Cheese'),
    (22, 'Calabrese Salami'),
    (23, 'Capocollo'),
    (24, 'Red Onions');
INSERT INTO
    Pizzas (pizza_id, pizza_name, pizza_size, pizza_price, category_id)
VALUES
    ('pepperoni_l', 'The Pepperoni Pizza', 'L', 15.25, 1),
    ('sicilian_m', 'The Sicilian Pizza', 'M', 16.25, 2),
    ('hawaiian_s', 'The Hawaiian Pizza', 'S', 10.5, 1),
    ('big_meat_s', 'The Big Meat Pizza', 'S', 12, 1),
    ('five_cheese_l', 'The Five Cheese Pizza', 'L', 18.5, 3),
    ('four_cheese_l', 'The Four Cheese Pizza', 'L', 17.95, 3),
    ('ital_supr_l', 'The Italian Supreme Pizza', 'L', 20.75, 2);
INSERT INTO
    Orders (order_id, accepted_at, total_price)
VALUES
    (1, '09.01.2015 11:16:21', 0),
    (2, '23.07.2015 13:35:09', 0),
    (3, '28.10.2015 17:09:28', 0),
    (4, '09.11.2015 12:20:39', 0),
    (5, '31.12.2015 19:02:33', 0);
INSERT INTO
    Orders_Pizzas (order_id, pizza_id, quantity)
VALUES
    (1, 'pepperoni_l', 1),
    (1, 'sicilian_m', 1),
    (2, 'hawaiian_s', 1),
    (3, 'big_meat_s', 1),
    (4, 'five_cheese_l', 1),
    (5, 'four_cheese_l', 1),
    (5, 'ital_supr_l', 1);
INSERT INTO
    Pizzas_Ingredients (pizza_id, ingredient_id)
VALUES
    ('pepperoni_l', 1),
    ('pepperoni_l', 2),
    ('pepperoni_l', 3),
    ('sicilian_m', 4),
    ('sicilian_m', 5),
    ('sicilian_m', 6),
    ('sicilian_m', 7),
    ('sicilian_m', 1),
    ('sicilian_m', 8),
    ('sicilian_m', 9),
    ('sicilian_m', 3),
    ('hawaiian_s', 1),
    ('hawaiian_s', 10),
    ('hawaiian_s', 11),
    ('hawaiian_s', 3),
    ('big_meat_s', 12),
    ('big_meat_s', 2),
    ('big_meat_s', 1),
    ('big_meat_s', 13),
    ('big_meat_s', 14),
    ('big_meat_s', 3),
    ('five_cheese_l', 15),
    ('five_cheese_l', 16),
    ('five_cheese_l', 17),
    ('five_cheese_l', 1),
    ('five_cheese_l', 18),
    ('five_cheese_l', 9),
    ('five_cheese_l', 3),
    ('four_cheese_l', 19),
    ('four_cheese_l', 1),
    ('four_cheese_l', 20),
    ('four_cheese_l', 21),
    ('four_cheese_l', 9),
    ('four_cheese_l', 3),
    ('ital_supr_l', 5),
    ('ital_supr_l', 22),
    ('ital_supr_l', 23),
    ('ital_supr_l', 7),
    ('ital_supr_l', 24),
    ('ital_supr_l', 1),
    ('ital_supr_l', 9),
    ('ital_supr_l', 3);

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
