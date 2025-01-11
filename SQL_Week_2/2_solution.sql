USE pizza_runner;
show tables;
SELECT * FROM customer_orders; -- order_id @, customer_id, pizza_id *, exclusions, extras, order_time
SELECT * FROM pizza_names; -- pizza_id *, pizza_name
SELECT * FROM pizza_recipes; -- pizza_id *, toppings
SELECT * FROM pizza_toppings; -- topping_id, topping_name
SELECT * FROM runner_orders;  -- order_id @, runner_id ^, pickup_time, distance, duration, cancellation
SELECT * FROM runners; -- runner_id ^, registration_date

-- A. Pizza Metrics

-- How many pizzas were ordered?
select count(order_id) as total_order
from customer_orders;
-- How many unique customer orders were made?
-- How many successful orders were delivered by each runner?
-- How many of each type of pizza was delivered?
-- How many Vegetarian and Meatlovers were ordered by each customer?
-- What was the maximum number of pizzas delivered in a single order?
-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
-- How many pizzas were delivered that had both exclusions and extras?
-- What was the total volume of pizzas ordered for each hour of the day?
-- What was the volume of orders for each day of the week?