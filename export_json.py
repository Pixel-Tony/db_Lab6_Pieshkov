import json
import psycopg2 as pg
from db_config import *

def cast(name, v):
    casted = {
        'order_id': int,
        'ingredient_id': int,
        'category_id': int,
        'quantity': int,
        'total_price': float,
        'pizza_price': float,
    }.get(name, str)(v)
    return casted.strip() if type(casted) is str else casted

tables = (
    'pizzas',
    'pizzas_ingredients',
    'ingredients',
    'orders_pizzas',
    'orders',
    'categories'
)
content = {}

with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
    with conn.cursor() as cur:
        for table in tables:
            cur.execute(f"SELECT * from {table}")
            header = [a.name for a in cur.description]
            content[table] = [
                {a: cast(a, b) for a, b in zip(header, row)}
                for row in cur
            ]

with open('exported/all.json', 'w') as file:
    json.dump(content, file, default=str)
