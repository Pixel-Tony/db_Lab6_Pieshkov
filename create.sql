CREATE TABLE
    Orders (
        order_id INT NOT NULL,
        accepted_at TIMESTAMP NOT NULL,
        total_price NUMERIC(8, 2) NOT NULL,
        PRIMARY KEY (order_id)
    );

CREATE TABLE
    Ingredients (
        ingredient_name VARCHAR(100) NOT NULL,
        ingredient_id INT NOT NULL,
        PRIMARY KEY (ingredient_id)
    );

CREATE TABLE
    Categories (
        category_name VARCHAR(16) NOT NULL,
        category_id INT NOT NULL,
        PRIMARY KEY (category_id)
    );

CREATE TABLE
    Pizzas (
        pizza_id VARCHAR(20) NOT NULL,
        pizza_name VARCHAR(150) NOT NULL,
        pizza_size CHAR(10) NOT NULL,
        pizza_price NUMERIC(8, 2) NOT NULL,
        category_id INT NOT NULL,
        PRIMARY KEY (pizza_id),
        FOREIGN KEY (category_id) REFERENCES Categories (category_id)
    );

CREATE TABLE
    Orders_Pizzas (
        quantity INT NOT NULL,
        order_id INT NOT NULL,
        pizza_id VARCHAR(20) NOT NULL,
        PRIMARY KEY (order_id, pizza_id),
        FOREIGN KEY (order_id) REFERENCES Orders (order_id),
        FOREIGN KEY (pizza_id) REFERENCES Pizzas (pizza_id)
    );

CREATE TABLE
    Pizzas_Ingredients (
        pizza_id VARCHAR(20) NOT NULL,
        ingredient_id INT NOT NULL,
        PRIMARY KEY (pizza_id, ingredient_id),
        FOREIGN KEY (pizza_id) REFERENCES Pizzas (pizza_id),
        FOREIGN KEY (ingredient_id) REFERENCES Ingredients (ingredient_id)
    );