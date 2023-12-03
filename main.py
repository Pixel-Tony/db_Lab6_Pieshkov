with open('query.sql', 'r', encoding='UTF-8') as q_file:
    queries = q_file.read().split(';')
assert len(queries) == 3

view_names = (
    'AveragePizzaPrices',
    'MostExpensiveOrders',
    'Pizzas_IngredientCounts'
)


def main(output_filename: str, skip_create=False):
    from visualization import main as visualize

    if skip_create:
        return visualize(output_filename)

    from db_config import DB_NAME, DB_PASSWORD, DB_USER
    import psycopg2 as pg

    with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
        conn.autocommit = True

        for query, view_name in zip(queries, view_names):
            with conn.cursor() as cur:
                cur.execute(f"DROP VIEW IF EXISTS {view_name};"
                            f"CREATE VIEW {view_name} AS {query}")
                print(cur.statusmessage)

    visualize(output_filename)


if __name__ == '__main__':
    from sys import argv
    skip_create = '-v' in argv[1:]
    main("graphs.png", skip_create)
