import csv
from pipeline import *
import sys


def main(count: int = ...):
    if count is ...:
        count = 9

    with open('data.csv') as file:
        lines = file.readlines()

    rows = [*csv.DictReader(lines)]

    CLEANED_DATA = DataExtractor(rows).process(count=count)
    DATA = DataProcessor(CLEANED_DATA).process()
    POPULATE = PopulateQueryGenerator(DATA).process()

    with open('populate.sql', 'r') as file:
        UPDATE_TOTAL_PRICES_QUERY = file.read()

    content = '\n\n'.join(POPULATE + [UPDATE_TOTAL_PRICES_QUERY])

    import psycopg2 as pg
    from db_config import DB_NAME, DB_PASSWORD, DB_USER

    with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
        conn.autocommit = True
        with conn.cursor() as cur:
            cur.execute(content)
            print(cur.statusmessage)


if __name__ == '__main__':
    argv = sys.argv[1:]

    count = [
        opt.split('=', 1)[1]
        for opt in argv
        if opt.startswith('-C=')
        or opt.startswith('--count=')
    ] + ['\0']
    count = int(count[0]) if count[0].isnumeric() else ...

    main(count)