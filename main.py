with open('query.sql', 'r', encoding='UTF-8') as q_file:
    queries = q_file.read().split(';')
assert len(queries) == 3


q_infos = (
    'Запит 1: Розмір та середня ціна піцц такого розміру,\n'
    '         відсортовані за його зростанням',
    'Запит 2: Ідентифікатори та вартості кожного з 5 найдорожчих замовлень,\n'
    '         відсортовані за спаданням вартості',
    'Запит 3: Кількості інгредієнтів та середня ціна відповідних піцц,\n'
    '         відсортовані за зростанням кількості інгредієнтів'
)


def main():
    from db_config import DB_NAME, DB_PASSWORD, DB_USER
    try:
        import psycopg2 as pg
    except ImportError as ierr:
        print(f'Помилка: для роботи необхідно встановити модуль "{ierr.name}"')
        return -1

    assert DB_NAME and DB_USER and DB_PASSWORD, \
        "Неправильно введено дані з'єднання"

    with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
        for query, q_info in zip(queries, q_infos):
            input('\n' + q_info + '\n[Натисніть Enter] ')
            with conn.cursor() as cur:
                cur.execute(query)
                print(*cur.fetchall(), sep='\n')


if __name__ == '__main__':
    try:
        quit(main())
    except KeyboardInterrupt:
        pass
