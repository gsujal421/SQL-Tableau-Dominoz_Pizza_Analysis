create database dominoz;

CREATE TABLE pizzas (
    pizza_id INT NOT NULL PRIMARY KEY,
    pizza_type_id INT NOT NULL,
    size TEXT NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE pizza_types (
    pizza_type_id INT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    ingredients TEXT NOT NULL
);


CREATE TABLE order_details (
    order_details_id INT NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);



-- 1.Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders; 


-- 2.Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(p.price * o.quantity), 2) AS total_revenue
FROM
    order_details o
        JOIN
    pizzas p ON p.pizza_id = o.pizza_id;
    
    

-- 3.Identify the highest-priced pizza.

SELECT 
    p.name, pi.price
FROM
    pizza_types p
        JOIN
    pizzas pi ON p.pizza_type_id = pi.pizza_type_id
WHERE
    pi.price = (SELECT 
            MAX(price)
        FROM
            pizzas);
            
            

-- 4.Identify the most common pizza size ordered.
SELECT 
    p.size, COUNT(o.order_details_id) AS common
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY p.size
ORDER BY common DESC;



-- 5.List the top 5 most ordered pizza types along with their quantities.

SELECT 
    p.name, SUM(o.quantity) AS top_quantity
FROM
    pizzas pi
        JOIN
    order_details o ON pi.pizza_id = o.pizza_id
        JOIN
    pizza_types p ON p.pizza_type_id = pi.pizza_type_id
GROUP BY p.name
ORDER BY top_quantity DESC
LIMIT 5;



-- 6.find the total quantity of each pizza category ordered.
SELECT 
    p.category, SUM(o.quantity) AS total_quantity
FROM
    pizzas pi
        JOIN
    order_details o ON pi.pizza_id = o.pizza_id
        JOIN
    pizza_types p ON p.pizza_type_id = pi.pizza_type_id
GROUP BY category
ORDER BY total_quantity DESC;




-- 7.Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS time_of_order,
    COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY HOUR(order_time)	;




-- 8.find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(pizza_type_id) AS no_of_pizzas
FROM
    pizza_types
GROUP BY category;



-- 9.Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(total_order), 0) AS avg_pizza
FROM
    (SELECT 
        od.order_date, SUM(o.quantity) AS total_order
    FROM
        orders od
    JOIN order_details o ON o.order_id = od.order_id
    GROUP BY od.order_date) AS daily_orders;
    
    


-- 10.Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pi.name, SUM(o.quantity * p.price) AS revenue
FROM
    pizzas p
        JOIN
    pizza_types pi ON p.pizza_type_id = pi.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;


-- 11.Calculate the percentage contribution of each pizza type to total revenue.	

SELECT 
    pi.category,
    ROUND(SUM(o.quantity * p.price), 1) / (SELECT 
            ROUND(SUM(p.price * o.quantity), 1)
        FROM
            order_details o
                JOIN
            pizzas p ON p.pizza_id = o.pizza_id) * 100 AS percentage
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pi ON pi.pizza_type_id = p.pizza_type_id
GROUP BY pi.category
ORDER BY percentage DESC;



-- 12.Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
    pi.name, ROUND(SUM(p.price * o.quantity), 1) AS revenue
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pi ON p.pizza_type_id = pi.pizza_type_id
GROUP BY pi.name
ORDER BY revenue DESC
LIMIT 3;
    
    

-- 13.Analyze the cumulative revenue generated over time.

select order_date , sum(revenue) over (order by order_date) as rn
from (
select o.order_date , round(sum(od.quantity * p.price),2) as revenue 
from pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
        JOIN
        orders o 
        on o.order_id= od.order_id
        group by o.order_date) as sales;
        
        

-- 14.least selling pizza 

SELECT 
    pi.name, ROUND(SUM(p.price * o.quantity), 1) AS revenue
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pi ON p.pizza_type_id = pi.pizza_type_id
GROUP BY pi.name
ORDER BY revenue ASC
LIMIT 5;


-- 15.most selling pizzas 
SELECT 
    pi.name, ROUND(SUM(p.price * o.quantity), 1) AS revenue
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pi ON p.pizza_type_id = pi.pizza_type_id
GROUP BY pi.name
ORDER BY revenue DESC
LIMIT 5;


-- 16.Any low-quantity but high-revenue pizza?
SELECT 
    pi.name,
    SUM(o.quantity) AS quantity,
    ROUND(SUM(o.quantity * p.price), 2) AS revenue
FROM
    order_details o
        JOIN
    pizzas p ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pi ON pi.pizza_type_id = p.pizza_type_id
GROUP BY pi.name
ORDER BY quantity ASC , revenue DESC
LIMIT 5;


 
-- 17.Peak time of the day
SELECT 
    HOUR(o.order_time) AS time_of_day, SUM(od.quantity) AS sold
FROM
    orders o
        JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY HOUR(o.order_time)
ORDER BY HOUR(o.order_time) DESC
LIMIT 1;