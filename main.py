import csv
import sys
import psycopg2 as pg

from util import *
from db_config import DB_NAME, DB_PASSWORD, DB_USER


def read_file(fname: str, encoding='utf8'):
    with open(fname, 'r', encoding=encoding) as f:
        return f.read()

def main(count: int = ...):
    if count is ...:
        count = 9

    with open('data.csv') as file:
        lines = file.readlines()

    rows = [*csv.DictReader(lines)]

    CLEANED_DATA = DataExtractor(rows).process(count=count)
    DATA = DataProcessor(CLEANED_DATA).process()
    POPULATE = PopulateQueryGenerator(DATA).process()

    TOTAL_PRICES_FUNCTION = read_file('function.sql')
    PRICE_UPDATE_PROCEDURES = read_file('procedure.sql')
    TRIGGERS = read_file('trigger.sql')

    content = '\n\n'.join(
        [TOTAL_PRICES_FUNCTION, PRICE_UPDATE_PROCEDURES, TRIGGERS]
        + POPULATE
    )

    with open('populate.sql', 'w', encoding='utf8') as file:
        file.write(content)

    with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
        conn.autocommit = True
        with conn.cursor() as cur:
            cur.execute(content)
            print(cur.statusmessage)


if __name__ == '__main__':
    argv = sys.argv[1:]
    count = argv[0] if argv else None

    if count and count.isnumeric():
        main(int(count))
    else:
        main()
