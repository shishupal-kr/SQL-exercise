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
    select count(distinct order_id) as unique_customer_order
    from customer_orders;
-- How many successful orders were delivered by each runner?
    select runner_id,count(order_id)
    from runner_orders
    where cancellation is null or cancellation = ''
    group by runner_id;
-- How many of each type of pizza was delivered?
    select pn.pizza_name,count(co.order_id) as total_delivered
    from customer_orders co
    join pizza_names pn
    on co.pizza_id = pn.pizza_id
    join runner_orders ro
    on co.order_id = ro.order_id
    where cancellation is null or cancellation = ''
    group by pn.pizza_name;

-- How many Vegetarian and Meatlovers were ordered by each customer?
    select co.customer_id,pn.pizza_name,count(co.pizza_id) as total_orders
    from customer_orders co
    join pizza_names pn on co.pizza_id = pn.pizza_id
    where pn.pizza_name in ("vegetarian" and "meatlovers")
    group by co.customer_id,pn.pizza_name;

-- What was the maximum number of pizzas delivered in a single order?
    select max(co.order_id)
    from customer_order co
    join runner_orders ro on co.order_id = ro.order_id;

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
-- How many pizzas were delivered that had both exclusions and extras?
select count(co.order_id) as deliver_with_exclusion_extra
from customer_orders co
         join runner_orders ro on co.order_id = ro.order_id
WHERE co.exclusions IS NOT NULL AND co.extras IS NOT NULL
  AND (ro.cancellation IS NULL OR ro.cancellation = '');
-- What was the total volume of pizzas ordered for each hour of the day?
SELECT HOUR(order_time) AS order_hour, COUNT(order_id) AS total_pizzas_ordered
FROM customer_orders
GROUP BY HOUR(order_time);
-- What was the volume of orders for each day of the week?
SELECT DAYNAME(order_time) AS order_day, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY DAYNAME(order_time);

-- B. Runner and Customer Experience

-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
-- Is there any relationship between the number of pizzas and how long the order takes to prepare?
-- What was the average distance travelled for each customer?
    select co.customer_id,round(avg(ro.distance),3) -- limit decimal digit
    from customer_orders co
    join runner_orders ro
    on co.order_id = ro.order_id
    group by co.customer_id;
-- What was the difference between the longest and shortest delivery times for all orders?
select co.order_id,ro.duration
from customer_orders co
         join runner_orders ro
              on co.order_id = ro.order_id;

SELECT MAX(TIMESTAMPDIFF(MINUTE, pickup_time, duration)) - MIN(TIMESTAMPDIFF(MINUTE, pickup_time, duration)) AS delivery_time_difference
FROM runner_orders;
-- What was the average speed for each runner for each delivery and do you notice any trend for these values?
-- What is the successful delivery percentage for each runner?