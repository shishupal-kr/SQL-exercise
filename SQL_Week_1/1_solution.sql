use dannys_diner;

-- table names
select * from members; -- customer_id*,join_date
select * from sales;   -- customer_id*,order_date,product_id**
select * from menu;    -- product_id**,product_name,price

-- Each of the following case study questions can be answered using a single SQL statement:

-- What is the total amount each customer spent at the restaurant?
select members.customer_id,count(menu.price) as spent
from members
         join sales
              on members.customer_id = sales.customer_id
         join menu
              on sales.product_id = menu.product_id
group by customer_id;

-- How many days has each customer visited the restaurant?
select m.customer_id,count(distinct s.order_date) as visited
from members m
         join sales as s
              on m.customer_id = s.customer_id
group by m.customer_id;

-- What was the first item from the menu purchased by each customer?
select distinct s.customer_id,m.product_name,min(s.order_date) as first_order_date
from sales as s
         join menu as m
              on s.product_id = m.product_id
group by s.customer_id,m.product_name
order by s.customer_id,first_order_date;
-- What is the most purchased item on the menu and how many times was it purchased by all customers?
select distinct m.product_name,count(s.product_id) as item_count
from sales as s
         join menu as m
              on s.product_id = m.product_id
group by m.product_name
order by item_count desc;
limit 1;
-- Which item was the most popular for each customer?
select distinct s.customer_id,m.product_name,count(s.product_id) as popular_item
from sales as s
         join menu as m
              on s.product_id = m.product_id
group by s.customer_id,m.product_name
order by s.customer_id, popular_item desc;
-- Which item was purchased first by the customer after they became a member?
select distinct s.customer_id,m.product_name ,min(s.order_date) as first_order_date
from sales as s
         join menu as m
              on s.product_id = m.product_id
         join members as me
              on s.customer_id = me.customer_id
where s.order_date >= me.join_date
group by s.customer_id,m.product_name
order by s.customer_id,first_order_date;
-- Which item was purchased just before the customer became a member?
select distinct s.customer_id,m.product_name ,max(s.order_date) as last_order_date
from sales as s
         join menu as m
              on s.product_id = m.product_id
         join members as me
              on s.customer_id = me.customer_id
where s.order_date < me.join_date
group by s.customer_id,m.product_name
order by s.customer_id,last_order_date desc;
-- What is the total items and amount spent for each member before they became a member?
select distinct s.customer_id,count(s.product_id) as total_item ,sum(m.price) as total_spent
from sales as s
         join menu as m on s.product_id = m.product_id
         join members as me on s.customer_id = me.customer_id
where s.order_date < me.join_date
group by s.customer_id;
-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi
-- how many points do customer A and B have at the end of January?