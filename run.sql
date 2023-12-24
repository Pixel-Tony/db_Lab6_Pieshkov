DO $$
DECLARE rec RECORD;

BEGIN
    FOR rec in (select * from orders)
    LOOP
        RAISE NOTICE 'Замовлення % - %$', rec.order_id, rec.total_price;
    END LOOP;

    RAISE NOTICE 'Сумарна вартість замовлень: %$',
        (SELECT SUM(total)
            FROM (SELECT get_order_total_price(order_id) as total
                FROM orders) AS sub
        );

    RAISE NOTICE 'Оновимо запис №2: додамо по одній піцці кожного типу;';

    INSERT INTO orders_pizzas(order_id, pizza_id, quantity)
    (
        SELECT 2 as order_id, pizza_id, 1 AS quantity
        FROM pizzas
        WHERE pizza_id NOT IN (
            SELECT pizza_id
            FROM orders_pizzas
            WHERE order_id = 2
        )
    );

    RAISE NOTICE 'Замовлення 2 - %$', (select total_price from orders where order_id = 2);
    RAISE NOTICE 'Сумарна вартість замовлень: %$',
        (SELECT SUM(total)
            FROM (SELECT get_order_total_price(order_id) as total
                FROM orders) AS sub
        );

ROLLBACK;
END;
$$;
