CREATE OR REPLACE PROCEDURE update_order_total(needle ORDERS.ORDER_ID%TYPE)
LANGUAGE PLPGSQL
AS $$
BEGIN
    UPDATE orders
    SET total_price = get_order_total_price(needle)
    WHERE orders.ORDER_ID = needle;
END;
$$;