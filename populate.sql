CREATE OR REPLACE FUNCTION get_order_total_price(needle orders.order_id%TYPE)
RETURNS orders.total_price%TYPE
LANGUAGE plpgsql
AS $$
    DECLARE total_price orders.total_price%TYPE;
    BEGIN
        SELECT SUM(pizza_price * quantity)
        INTO total_price
        FROM (
                SELECT pizza_id, quantity
                FROM orders_pizzas
                WHERE order_id = needle
            ) JOIN pizzas USING (pizza_id);

        RETURN total_price;
    END;
$$;

CREATE OR REPLACE PROCEDURE update_order_total(needle ORDERS.ORDER_ID%TYPE)
LANGUAGE PLPGSQL
AS $$
BEGIN
    UPDATE orders
    SET total_price = get_order_total_price(needle)
    WHERE orders.ORDER_ID = needle;
END;
$$;

CREATE OR REPLACE FUNCTION tr_update_order_total() RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS $$
    BEGIN
        CALL update_order_total(NEW.order_id);
        RETURN null;
    END;
    $$;

CREATE OR REPLACE TRIGGER OnOrderAppend AFTER INSERT
    ON orders_pizzas
    FOR EACH ROW
    EXECUTE FUNCTION tr_update_order_total();

TRUNCATE TABLE Pizzas_Ingredients, Orders_Pizzas, Pizzas, Orders, Ingredients, Categories;

INSERT INTO
    Categories (category_id, category_name)
VALUES
    (1, 'Veggie'),
    (2, 'Supreme'),
    (3, 'Chicken'),
    (4, 'Classic');

INSERT INTO
    Ingredients (ingredient_id, ingredient_name)
VALUES
    (1, 'Romano Cheese'),
    (2, 'Smoked Gouda Cheese'),
    (3, 'Blue Cheese'),
    (4, 'Mozzarella Cheese'),
    (5, 'Garlic'),
    (6, 'Provolone Cheese'),
    (7, 'Tomato Sauce'),
    (8, 'Capocollo'),
    (9, 'Calabrese Salami'),
    (10, 'Tomatoes'),
    (11, 'Red Onions'),
    (12, 'Green Olives'),
    (13, 'Mushrooms'),
    (14, 'Fontina Cheese'),
    (15, 'Soppressata Salami'),
    (16, 'Pesto Sauce'),
    (17, 'Red Peppers'),
    (18, 'Eggplant'),
    (19, 'Zucchini'),
    (20, 'Artichokes'),
    (21, 'Spinach'),
    (22, 'Green Peppers'),
    (23, 'Barbecued Chicken'),
    (24, 'Barbecue Sauce'),
    (25, 'Pepperoni'),
    (26, 'Bacon'),
    (27, 'Sliced Ham'),
    (28, 'Pineapple'),
    (29, 'Corn'),
    (30, 'Chipotle Sauce'),
    (31, 'Jalapeno Peppers'),
    (32, 'Cilantro'),
    (33, 'Chicken'),
    (34, 'Coarse Sicilian Salami'),
    (35, 'Luganega Sausage'),
    (36, 'Onions');

INSERT INTO
    Pizzas (pizza_id, pizza_name, pizza_size, pizza_price, category_id)
VALUES
    ('five_cheese_l', 'The Five Cheese Pizza', 'L', 18.5, 1),
    ('ital_supr_l', 'The Italian Supreme Pizza', 'L', 20.75, 2),
    ('soppressata_m', 'The Soppressata Pizza', 'M', 16.5, 2),
    ('ital_veggie_m', 'The Italian Vegetables Pizza', 'M', 16.75, 1),
    ('veggie_veg_l', 'The Vegetables + Vegetables Pizza', 'L', 20.25, 1),
    ('veggie_veg_m', 'The Vegetables + Vegetables Pizza', 'M', 16, 1),
    ('bbq_ckn_l', 'The Barbecue Chicken Pizza', 'L', 20.75, 3),
    ('classic_dlx_m', 'The Classic Deluxe Pizza', 'M', 16, 4),
    ('hawaiian_l', 'The Hawaiian Pizza', 'L', 16.5, 4),
    ('southw_ckn_l', 'The Southwest Chicken Pizza', 'L', 20.75, 3),
    ('sicilian_s', 'The Sicilian Pizza', 'S', 12.25, 2);

INSERT INTO
    Orders (order_id, accepted_at, total_price)
VALUES
    (1, '20.01.2015 15:15:26', 0),
    (2, '27.04.2015 16:34:51', 0),
    (3, '17.10.2015 17:11:59', 0),
    (4, '22.11.2015 16:19:38', 0),
    (5, '14.12.2015 13:02:01', 0);

INSERT INTO
    Orders_Pizzas (order_id, pizza_id, quantity)
VALUES
    (1, 'five_cheese_l', 1),
    (1, 'ital_supr_l', 1),
    (2, 'soppressata_m', 1),
    (3, 'ital_veggie_m', 1),
    (3, 'veggie_veg_l', 1),
    (3, 'veggie_veg_m', 1),
    (4, 'bbq_ckn_l', 1),
    (4, 'classic_dlx_m', 1),
    (4, 'hawaiian_l', 1),
    (4, 'southw_ckn_l', 1),
    (5, 'sicilian_s', 1);

INSERT INTO
    Pizzas_Ingredients (pizza_id, ingredient_id)
VALUES
    ('five_cheese_l', 1),
    ('five_cheese_l', 2),
    ('five_cheese_l', 3),
    ('five_cheese_l', 4),
    ('five_cheese_l', 5),
    ('five_cheese_l', 6),
    ('five_cheese_l', 7),
    ('ital_supr_l', 8),
    ('ital_supr_l', 9),
    ('ital_supr_l', 10),
    ('ital_supr_l', 11),
    ('ital_supr_l', 4),
    ('ital_supr_l', 5),
    ('ital_supr_l', 12),
    ('ital_supr_l', 7),
    ('soppressata_m', 13),
    ('soppressata_m', 4),
    ('soppressata_m', 14),
    ('soppressata_m', 5),
    ('soppressata_m', 15),
    ('soppressata_m', 7),
    ('ital_veggie_m', 5),
    ('ital_veggie_m', 16),
    ('ital_veggie_m', 17),
    ('ital_veggie_m', 10),
    ('ital_veggie_m', 4),
    ('ital_veggie_m', 18),
    ('ital_veggie_m', 19),
    ('ital_veggie_m', 20),
    ('veggie_veg_l', 17),
    ('veggie_veg_l', 21),
    ('veggie_veg_l', 10),
    ('veggie_veg_l', 4),
    ('veggie_veg_l', 11),
    ('veggie_veg_l', 5),
    ('veggie_veg_l', 13),
    ('veggie_veg_l', 19),
    ('veggie_veg_l', 22),
    ('veggie_veg_l', 7),
    ('veggie_veg_m', 17),
    ('veggie_veg_m', 21),
    ('veggie_veg_m', 10),
    ('veggie_veg_m', 4),
    ('veggie_veg_m', 11),
    ('veggie_veg_m', 5),
    ('veggie_veg_m', 13),
    ('veggie_veg_m', 19),
    ('veggie_veg_m', 22),
    ('veggie_veg_m', 7),
    ('bbq_ckn_l', 17),
    ('bbq_ckn_l', 10),
    ('bbq_ckn_l', 23),
    ('bbq_ckn_l', 11),
    ('bbq_ckn_l', 4),
    ('bbq_ckn_l', 22),
    ('bbq_ckn_l', 24),
    ('classic_dlx_m', 17),
    ('classic_dlx_m', 13),
    ('classic_dlx_m', 25),
    ('classic_dlx_m', 26),
    ('classic_dlx_m', 11),
    ('classic_dlx_m', 4),
    ('classic_dlx_m', 7),
    ('hawaiian_l', 27),
    ('hawaiian_l', 28),
    ('hawaiian_l', 4),
    ('hawaiian_l', 7),
    ('southw_ckn_l', 17),
    ('southw_ckn_l', 10),
    ('southw_ckn_l', 29),
    ('southw_ckn_l', 30),
    ('southw_ckn_l', 11),
    ('southw_ckn_l', 31),
    ('southw_ckn_l', 4),
    ('southw_ckn_l', 32),
    ('southw_ckn_l', 33),
    ('sicilian_s', 10),
    ('sicilian_s', 4),
    ('sicilian_s', 34),
    ('sicilian_s', 35),
    ('sicilian_s', 12),
    ('sicilian_s', 5),
    ('sicilian_s', 36),
    ('sicilian_s', 7);