TRUNCATE TABLE Pizzas_Ingredients, Orders_Pizzas, Pizzas, Orders, Ingredients, Categories;

INSERT INTO
    Categories (category_id, category_name)
VALUES
    (1, 'Classic'),
    (2, 'Supreme'),
    (3, 'Chicken'),
    (4, 'Veggie');

INSERT INTO
    Ingredients (ingredient_id, ingredient_name)
VALUES
    (1, 'Pepperoni'),
    (2, 'Mozzarella Cheese'),
    (3, 'Tomato Sauce'),
    (4, 'Garlic'),
    (5, 'Kalamata Olives'),
    (6, 'Feta Cheese'),
    (7, 'Tomatoes'),
    (8, 'Beef Chuck Roast'),
    (9, 'Red Onions'),
    (10, 'Green Olives'),
    (11, 'Calabrese Salami'),
    (12, 'Capocollo'),
    (13, 'Green Peppers'),
    (14, 'Barbecue Sauce'),
    (15, 'Red Peppers'),
    (16, 'Barbecued Chicken'),
    (17, 'Chipotle Sauce'),
    (18, 'Chicken'),
    (19, 'Cilantro'),
    (20, 'Corn'),
    (21, 'Jalapeno Peppers'),
    (22, 'Artichokes'),
    (23, 'Pesto Sauce'),
    (24, 'Spinach'),
    (25, 'Sun-dried Tomatoes'),
    (26, 'Mushrooms'),
    (27, 'Bacon'),
    (28, 'Onions'),
    (29, 'Coarse Sicilian Salami'),
    (30, 'Luganega Sausage');

INSERT INTO
    Pizzas (pizza_id, pizza_name, pizza_size, pizza_price, category_id)
VALUES
    ('pepperoni_m', 'The Pepperoni Pizza', 'M', 12.5, 1),
    ('the_greek_m', 'The Greek Pizza', 'M', 16, 1),
    ('ital_supr_m', 'The Italian Supreme Pizza', 'M', 16.5, 2),
    ('bbq_ckn_l', 'The Barbecue Chicken Pizza', 'L', 20.75, 3),
    ('southw_ckn_m', 'The Southwest Chicken Pizza', 'M', 16.75, 3),
    ('spin_pesto_s', 'The Spinach Pesto Pizza', 'S', 12.5, 4),
    ('ckn_pesto_s', 'The Chicken Pesto Pizza', 'S', 12.75, 3),
    ('classic_dlx_s', 'The Classic Deluxe Pizza', 'S', 12, 1),
    ('ital_supr_l', 'The Italian Supreme Pizza', 'L', 20.75, 2),
    ('mexicana_l', 'The Mexicana Pizza', 'L', 20.25, 4),
    ('sicilian_l', 'The Sicilian Pizza', 'L', 20.25, 2);

INSERT INTO
    Orders (order_id, accepted_at, total_price)
VALUES
    (1, '24.04.2015 19:55:03', 0),
    (2, '11.08.2015 20:28:28', 0),
    (3, '27.11.2015 16:54:20', 0),
    (4, '28.11.2015 18:16:17', 0),
    (5, '11.12.2015 20:45:31', 0);

INSERT INTO
    Orders_Pizzas (order_id, pizza_id, quantity)
VALUES
    (1, 'pepperoni_m', 1),
    (1, 'the_greek_m', 1),
    (2, 'ital_supr_m', 1),
    (3, 'bbq_ckn_l', 1),
    (3, 'southw_ckn_m', 1),
    (3, 'spin_pesto_s', 1),
    (4, 'ckn_pesto_s', 1),
    (4, 'classic_dlx_s', 1),
    (4, 'ital_supr_l', 1),
    (5, 'mexicana_l', 1),
    (5, 'sicilian_l', 1);

INSERT INTO
    Pizzas_Ingredients (pizza_id, ingredient_id)
VALUES
    ('pepperoni_m', 1),
    ('pepperoni_m', 2),
    ('pepperoni_m', 3),
    ('the_greek_m', 4),
    ('the_greek_m', 5),
    ('the_greek_m', 6),
    ('the_greek_m', 7),
    ('the_greek_m', 8),
    ('the_greek_m', 9),
    ('the_greek_m', 2),
    ('the_greek_m', 3),
    ('ital_supr_m', 10),
    ('ital_supr_m', 4),
    ('ital_supr_m', 9),
    ('ital_supr_m', 11),
    ('ital_supr_m', 12),
    ('ital_supr_m', 7),
    ('ital_supr_m', 2),
    ('ital_supr_m', 3),
    ('bbq_ckn_l', 13),
    ('bbq_ckn_l', 2),
    ('bbq_ckn_l', 14),
    ('bbq_ckn_l', 9),
    ('bbq_ckn_l', 15),
    ('bbq_ckn_l', 7),
    ('bbq_ckn_l', 16),
    ('southw_ckn_m', 17),
    ('southw_ckn_m', 9),
    ('southw_ckn_m', 15),
    ('southw_ckn_m', 7),
    ('southw_ckn_m', 18),
    ('southw_ckn_m', 19),
    ('southw_ckn_m', 20),
    ('southw_ckn_m', 21),
    ('southw_ckn_m', 2),
    ('spin_pesto_s', 22),
    ('spin_pesto_s', 4),
    ('spin_pesto_s', 23),
    ('spin_pesto_s', 24),
    ('spin_pesto_s', 25),
    ('spin_pesto_s', 7),
    ('spin_pesto_s', 2),
    ('ckn_pesto_s', 4),
    ('ckn_pesto_s', 24),
    ('ckn_pesto_s', 23),
    ('ckn_pesto_s', 15),
    ('ckn_pesto_s', 18),
    ('ckn_pesto_s', 7),
    ('ckn_pesto_s', 2),
    ('classic_dlx_s', 26),
    ('classic_dlx_s', 27),
    ('classic_dlx_s', 9),
    ('classic_dlx_s', 15),
    ('classic_dlx_s', 1),
    ('classic_dlx_s', 2),
    ('classic_dlx_s', 3),
    ('ital_supr_l', 10),
    ('ital_supr_l', 4),
    ('ital_supr_l', 9),
    ('ital_supr_l', 11),
    ('ital_supr_l', 12),
    ('ital_supr_l', 7),
    ('ital_supr_l', 2),
    ('ital_supr_l', 3),
    ('mexicana_l', 17),
    ('mexicana_l', 4),
    ('mexicana_l', 9),
    ('mexicana_l', 15),
    ('mexicana_l', 7),
    ('mexicana_l', 19),
    ('mexicana_l', 20),
    ('mexicana_l', 21),
    ('mexicana_l', 2),
    ('sicilian_l', 28),
    ('sicilian_l', 10),
    ('sicilian_l', 4),
    ('sicilian_l', 29),
    ('sicilian_l', 30),
    ('sicilian_l', 7),
    ('sicilian_l', 2),
    ('sicilian_l', 3);

UPDATE orders
SET
    total_price = sub.total_price
FROM
    (
        SELECT
            order_id,
            SUM(pizza_price * orders_pizzas.quantity) AS total_price
        FROM
            orders
            NATURAL JOIN orders_pizzas
            NATURAL JOIN pizzas
        GROUP BY
            order_id
    ) AS sub
WHERE
    orders.order_id = sub.order_id;
