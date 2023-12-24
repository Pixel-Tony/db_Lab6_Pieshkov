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