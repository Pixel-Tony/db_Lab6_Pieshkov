from typing import Literal


ModelLike = dict[str, str | int]
ModelList = list[ModelLike]
RowColumns = Literal[
    'order_id',
    'pizza_id',
    'quantity',
    'order_date',
    'order_time',
    'unit_price',
    'total_price',
    'pizza_size',
    'pizza_category',
    'pizza_ingredients',
    'pizza_name',
]

PizzaModel = dict[Literal[
    'pizza_id',
    'pizza_name',
    'pizza_size',
    'pizza_price',
    'category_id',
], str | int]

OrderModel = dict[Literal[
    'order_id',
    'accepted_at',
    'total_price'
], str | int]

IngredientModel = dict[Literal[
    'ingredient_name',
    'ingredient_id'
], str | int]

CategoryModel = dict[Literal[
    'category_name',
    'category_id',
], str | int]

OrderPizzaModel = dict[Literal[
    'pizza_id',
    'order_id',
    'quantity'
], str | int]

PizzaIngredientModel = dict[Literal[
    'pizza_id',
    'ingredient_id'
], str | int]


RowList = list[dict[RowColumns, str | int]]

TableNames = Literal[
    'Categories',
    'Pizzas',
    'Orders',
    'Ingredients',
    'Orders_Pizzas',
    'Pizzas_Ingredients',
]
