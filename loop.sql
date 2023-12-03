DELETE FROM orders
WHERE order_id >= 100000;

DO $$
    DECLARE
        order_id orders.order_id%TYPE;


    BEGIN
        order_id := 100000;
        FOR counter IN 1..20
            LOOP
                INSERT INTO orders (order_id, accepted_at, total_price)
                VALUES (counter + order_id, current_date - counter + 1, 0);
            END LOOP;
    END;
$$