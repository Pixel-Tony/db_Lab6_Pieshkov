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