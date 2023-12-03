import csv
import psycopg2 as pg
from db_config import *

tables = (
    'pizzas',
    'pizzas_ingredients',
    'ingredients',
    'orders_pizzas',
    'orders',
    'categories'
)

with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
    for table in tables:
        with open(f'exported/{table}.csv', 'w', encoding='UTF-8') as fout:
            with conn.cursor() as cur:
                cur.execute(f"SELECT * FROM {table}")
                fields = [col.name for col in cur.description]
                writer = csv.DictWriter(fout, fields, lineterminator='\n')
                writer.writeheader()
                writer.writerows([
                    dict(zip(fields, [str(item).strip() for item in row]))
                    for row in cur.fetchall()
                ])