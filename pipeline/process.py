from ._model import *

class DataProcessor:
    def __init__(self, data: RowList) -> None:
        self.categories: list[CategoryModel] = []
        self.pizzas: list[PizzaModel] = []
        self.orders: list[OrderModel] = []
        self.ingredients: list[IngredientModel] = []
        self.orders_pizzas: list[OrderPizzaModel] = []
        self.pizzas_ingredients: list[PizzaIngredientModel] = []

        self._distribute(data)

    def process(self) -> dict[TableNames, ModelList]:
        return {
            'Categories': self.categories,
            'Pizzas': self.pizzas,
            'Orders': self.orders,
            'Ingredients': self.ingredients,
            'Orders_Pizzas': self.orders_pizzas,
            'Pizzas_Ingredients': self.pizzas_ingredients,
        }

    def _add_ingredient(self,
                        pizza_id: str,
                        ingredient_name: str,
                        sauce_present: bool
                        ) -> bool:
        sauce_present = sauce_present or 'sauce' in ingredient_name.lower()
        ingredient = [
            a
            for a in self.ingredients
            if a['ingredient_name'] == ingredient_name
        ]
        if not ingredient:
            ingredient_id = len(self.ingredients) + 1
            self.ingredients.append({
                'ingredient_id': ingredient_id,
                'ingredient_name': ingredient_name
            })
        else:
            ingredient_id = ingredient[0]['ingredient_id']

        if not [
            a
            for a in self.pizzas_ingredients
            if (a['ingredient_id'], a['pizza_id']) == (ingredient_id, pizza_id)
        ]:
            self.pizzas_ingredients.append({
                'pizza_id': pizza_id,
                'ingredient_id': ingredient_id,
            })

        return sauce_present

    def _distribute(self, data: RowList):
        for row in data:
            pizza_id = row['pizza_id']
            order_id = row['order_id']
            if order_id not in [a['order_id'] for a in self.orders]:
                self.orders.append({
                    'order_id': order_id,
                    'accepted_at': f"{row['order_date']} {row['order_time']}",
                    # total price is processed in sql
                    'total_price': 0
                })

            sauce_present = False
            for item in {
                l.strip()
                for l in row['pizza_ingredients'].split(',')
            } | {'Mozzarella Cheese'}:
                sauce_present = self._add_ingredient(
                    pizza_id, item, sauce_present
                )

            if not sauce_present:
                self._add_ingredient(pizza_id, 'Tomato Sauce', True)

            category_name = row['pizza_category']
            category = [
                a
                for a in self.categories
                if a['category_name'] == category_name
            ]
            if not category:
                category_id = len(self.categories) + 1
                self.categories.append({
                    'category_id': category_id,
                    'category_name': category_name
                })
            else:
                category_id = category[0]['category_id']

            pizza = [
                a
                for a in self.pizzas
                if a['pizza_id'] == pizza_id
            ]
            if not pizza:
                self.pizzas.append({
                    'pizza_id': pizza_id,
                    'category_id': category_id,
                    'pizza_name': row['pizza_name'],
                    'pizza_price': row['unit_price'].replace(',', '.'),
                    'pizza_size': row['pizza_size']
                })

            self.orders_pizzas.append({
                'pizza_id': pizza_id,
                'order_id': order_id,
                'quantity': row['quantity']
            })
