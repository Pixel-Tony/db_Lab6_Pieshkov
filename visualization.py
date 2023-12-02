try:
    import psycopg2 as pg
    import matplotlib.pyplot as plt
    from matplotlib.axes import Axes
    from matplotlib.typing import ColorType
except ImportError as ierr:
    print(f'Помилка: для роботи необхідно встановити модуль "{ierr.name}"')
    quit(1)

from db_config import *
from main import queries


def _set_edgecolor(ax: Axes, color: ColorType):
    [spine.set_edgecolor(color) for spine in ax.spines.values()]


def _first(result: list[tuple[int, float]], bar_ax: Axes):
    '''
    Запит 1 - Середня ціна та розмір піцци, відсортовані за зростанням розміру.
    Візуалізація - стовпчикова діаграма
    '''
    sizes, avg_price = zip(*result)
    x_range = range(len(result))

    bar = bar_ax.bar(x_range, avg_price, label='Total')

    bar_ax.bar_label(bar)
    bar_ax.set_xticks(x_range)
    bar_ax.set_xticklabels(sizes)
    bar_ax.set_xlabel('Розмір')
    bar_ax.set_ylabel('Середня вартість, $')
    bar_ax.set_title('Розподіл середньої вартості піцци\nза її розміром')
    _set_edgecolor(bar_ax, '#0005')


def _second(result: list[tuple[str, float]], pie_ax: Axes):
    '''
    Запит 2 - Вартість кожного з 5 найдорожчих замовлень.
    Візуалізація - кругова діаграма
    '''
    total_prices, order_ids = zip(*result)

    pie_ax.pie(total_prices, autopct='%1.1f%%',)
    pie_ax.set_title('Частка вартостей кожного\nз 5 найдорожчих замовлень')
    pie_ax.legend(labels=[f'Зам. №{a}' for a in order_ids],
                  bbox_to_anchor=(0, -0.26, 1, 1))


def _third(result: list[tuple[float, int]], graph_ax: Axes):
    '''
    Запит 3 - Кількість інгредієнтів та середня ціна піцц з цією їх кількістю.
    Візуалізація - графік залежності
    '''
    counts, prices = zip(*result)

    graph_ax.plot(counts, prices, color='#088f', marker='o')

    for p_id, price in zip(counts, prices):
        graph_ax.annotate(price, xy=(p_id, price), color='black',
                          xytext=(3, -14),
                          textcoords='offset points',
                          size=11
                          )

    _set_edgecolor(graph_ax, '#0004')
    graph_ax.set_xlabel('Кількість інгредієнтів, шт')
    graph_ax.set_ylabel('Середня ціна за піццу, $')
    graph_ax.set_ylim(0, int(max(prices) + 2))
    graph_ax.set_title('Графік залежності ціни піцци\n'
                       'від кількості інгредієнтів')


def main():
    assert DB_NAME and DB_USER and DB_PASSWORD, \
        "Неправильно введено дані з'єднання"

    figure, axes = plt.subplots(1, 3)
    handlers = (_first, _second, _third)

    with pg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD) as conn:
        for query, handler, ax in zip(queries, handlers, axes):
            with conn.cursor() as cur:
                cur.execute(query)
                handler(cur.fetchall(), ax)

    mng = plt.get_current_fig_manager()
    mng.resize(1400, 600)
    plt.show()


if __name__ == '__main__':
    main()
