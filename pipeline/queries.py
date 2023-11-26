from ._model import *

class PopulateQueryGenerator:
    def __init__(self, data: dict[TableNames, ModelList]) -> None:
        self.data = data

    def process(self):
        return [
            'TRUNCATE TABLE ' +
            ', '.join((
                'Pizzas_Ingredients',
                'Orders_Pizzas',
                'Pizzas',
                'Orders',
                'Ingredients',
                'Categories;'
            )),
            *self._populate_categories(self.data['Categories']),
            *self._populate_ingredients(self.data['Ingredients']),
            *self._populate_pizzas(self.data['Pizzas']),
            *self._populate_orders(self.data['Orders']),
            *self._populate_orders_pizzas(self.data['Orders_Pizzas']),
            *self._populate_pizzas_ingredients(self.data['Pizzas_Ingredients'])
        ]

    def _populate_categories(self, models: list[CategoryModel]):
        return self._populate_default(
            'Categories',
            'category_id, category_name',
            "{category_id}, '{category_name}'",
            models
        )

    def _populate_ingredients(self, models: list[IngredientModel]):
        return self._populate_default(
            'Ingredients',
            'ingredient_id, ingredient_name',
            "{ingredient_id}, '{ingredient_name}'",
            models
        )

    def _populate_orders(self, models: list[OrderModel]):
        return self._populate_default(
            'Orders',
            'order_id, accepted_at, total_price',
            "{order_id}, '{accepted_at}', {total_price}",
            models
        )

    def _populate_pizzas(self, models: list[PizzaModel]):
        return self._populate_default(
            'Pizzas',
            'pizza_id, pizza_name, pizza_size, pizza_price, category_id',
            "'{pizza_id}', '{pizza_name}', '{pizza_size}', {pizza_price}, {category_id}",
            models
        )

    def _populate_orders_pizzas(self, models: list[OrderPizzaModel]):
        return self._populate_default(
            'Orders_Pizzas',
            'order_id, pizza_id, quantity',
            "{order_id}, '{pizza_id}', {quantity}",
            models
        )

    def _populate_pizzas_ingredients(self, models: list[PizzaIngredientModel]):
        return self._populate_default(
            'Pizzas_Ingredients',
            'pizza_id, ingredient_id',
            "'{pizza_id}', {ingredient_id}",
            models
        )

    def _populate_default(self,
                          table: str,
                          fields: str,
                          s_format: str,
                          models: list[dict]):
        return [
            f'INSERT INTO\n    {table} ({fields})\nVALUES\n    '
            + ',\n    '.join(f"({s_format})".format(**a) for a in models)
            + ';'
        ]
