TRUNCATE TABLE Pizzas_Ingredients, Orders_Pizzas, Pizzas, Orders, Ingredients, Categories;
INSERT INTO
    Categories (category_id, category_name)
VALUES
    (1, 'Classic'),
    (2, 'Supreme'),
    (3, 'Chicken');
INSERT INTO
    Ingredients (ingredient_id, ingredient_name)
VALUES
    (1, 'Goat Cheese'),
    (2, 'Red Peppers'),
    (3, 'Capocollo'),
    (4, 'Tomatoes'),
    (5, 'Garlic'),
    (6, 'Mozzarella Cheese'),
    (7, 'Oregano'),
    (8, 'Tomato Sauce'),
    (9, 'Anchovies'),
    (10, 'Red Onions'),
    (11, 'Green Olives'),
    (12, 'Pepperoni'),
    (13, 'Artichokes'),
    (14, 'Asiago Cheese'),
    (15, 'Kalamata Olives'),
    (16, 'Spinach'),
    (17, 'Genoa Salami'),
    (18, 'Chipotle Sauce'),
    (19, 'Corn'),
    (20, 'Chicken'),
    (21, 'Cilantro'),
    (22, 'Jalapeno Peppers'),
    (23, 'Alfredo Sauce'),
    (24, 'Mushrooms');
INSERT INTO
    Pizzas (pizza_id, pizza_name, pizza_size, pizza_price, category_id)
VALUES
    ('ital_cpcllo_m', 'The Italian Capocollo Pizza', 'M', 16, 1),
    ('napolitana_m', 'The Napolitana Pizza', 'M', 16, 1),
    ('spinach_supr_m', 'The Spinach Supreme Pizza', 'M', 16.5, 2),
    ('peppr_salami_l', 'The Pepper Salami Pizza', 'L', 20.75, 2),
    ('ital_cpcllo_l', 'The Italian Capocollo Pizza', 'L', 20.5, 1),
    ('southw_ckn_l', 'The Southwest Chicken Pizza', 'L', 20.75, 3),
    ('ckn_alfredo_s', 'The Chicken Alfredo Pizza', 'S', 12.75, 3);
INSERT INTO
    Orders (order_id, accepted_at, total_price)
VALUES
    (1, '16.03.2015 20:29:39', 0),
    (2, '09.06.2015 12:07:47', 0),
    (3, '02.07.2015 12:38:12', 0),
    (4, '29.07.2015 16:55:41', 0),
    (5, '04.12.2015 17:02:51', 0);
INSERT INTO
    Orders_Pizzas (order_id, pizza_id, quantity)
VALUES
    (1, 'ital_cpcllo_m', 1),
    (1, 'napolitana_m', 1),
    (1, 'spinach_supr_m', 1),
    (2, 'peppr_salami_l', 1),
    (3, 'ital_cpcllo_l', 1),
    (3, 'southw_ckn_l', 1),
    (4, 'napolitana_m', 1),
    (5, 'ckn_alfredo_s', 1);
INSERT INTO
    Pizzas_Ingredients (pizza_id, ingredient_id)
VALUES
    ('ital_cpcllo_m', 1),
    ('ital_cpcllo_m', 2),
    ('ital_cpcllo_m', 3),
    ('ital_cpcllo_m', 4),
    ('ital_cpcllo_m', 5),
    ('ital_cpcllo_m', 6),
    ('ital_cpcllo_m', 7),
    ('ital_cpcllo_m', 8),
    ('napolitana_m', 9),
    ('napolitana_m', 10),
    ('napolitana_m', 4),
    ('napolitana_m', 5),
    ('napolitana_m', 6),
    ('napolitana_m', 11),
    ('napolitana_m', 8),
    ('spinach_supr_m', 12),
    ('spinach_supr_m', 10),
    ('spinach_supr_m', 13),
    ('spinach_supr_m', 6),
    ('spinach_supr_m', 5),
    ('spinach_supr_m', 14),
    ('spinach_supr_m', 15),
    ('spinach_supr_m', 16),
    ('spinach_supr_m', 4),
    ('spinach_supr_m', 8),
    ('peppr_salami_l', 12),
    ('peppr_salami_l', 17),
    ('peppr_salami_l', 3),
    ('peppr_salami_l', 14),
    ('peppr_salami_l', 5),
    ('peppr_salami_l', 6),
    ('peppr_salami_l', 4),
    ('peppr_salami_l', 8),
    ('ital_cpcllo_l', 1),
    ('ital_cpcllo_l', 2),
    ('ital_cpcllo_l', 3),
    ('ital_cpcllo_l', 4),
    ('ital_cpcllo_l', 5),
    ('ital_cpcllo_l', 6),
    ('ital_cpcllo_l', 7),
    ('ital_cpcllo_l', 8),
    ('southw_ckn_l', 18),
    ('southw_ckn_l', 10),
    ('southw_ckn_l', 2),
    ('southw_ckn_l', 19),
    ('southw_ckn_l', 6),
    ('southw_ckn_l', 20),
    ('southw_ckn_l', 21),
    ('southw_ckn_l', 22),
    ('southw_ckn_l', 4),
    ('ckn_alfredo_s', 10),
    ('ckn_alfredo_s', 2),
    ('ckn_alfredo_s', 23),
    ('ckn_alfredo_s', 14),
    ('ckn_alfredo_s', 24),
    ('ckn_alfredo_s', 6),
    ('ckn_alfredo_s', 20);

UPDATE orders
SET
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
    ) AS sub
WHERE
    orders.order_id = sub.order_id;
