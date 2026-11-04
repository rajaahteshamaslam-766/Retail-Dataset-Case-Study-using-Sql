#1. Display all columns from 'customers'.
select * from customers;

#2. Show the product name, category, and unit price for all products costing more than 5,000.
select product_name,category,unit_price
from products 
where unit_price>5000;

#3. List orders placed during January 2025, ordered from earliest to latest.
select *
from orders
where year(order_date)=2025 and monthname(order_date)='January'
order by order_date desc;

#method2
select *
from orders
where order_date>'2025-01-01' and order_date<'2025-02-01'
order by order_date desc;

#4. Find all customers who live in the AJK region.
select* 
from customers
where region='Ajk';

#5. Show products whose stock quantity is between 10 and 25, inclusive.
select *
from products
where stock_quantity between 10 and 25;

#6. List orders that are Pending or Cancelled.
select * from 
orders 
where status  in ('pending' ,'cancelled');

#7. Count the total number of customers.
select count(*) as total_customers from 
customers ;

#8. Find the average product price, rounded to two decimal places.
select round(avg(unit_price) ,2)as avg_price from 
products;

#9. Count orders by status.
select status,count(status) as no_of_orders
from orders
group by status;

#10. Find the total quantity sold for each product across all order items.
select * from order_items limit 5 ;
select * from products limit 5;
select p.product_id,p.product_name,p.category,sum(o.quantity) total_quantity_sold
from products p
inner join 
order_items o on 
p.product_id=o.product_id
group by p.product_id,p.product_name,p.category
order by total_quantity_sold desc;

#10.1 Total quantities sold by category
select p.category,sum(o.quantity) total_quantity_sold
from products p
inner join 
order_items o on 
p.product_id=o.product_id
group by p.category
order by total_quantity_sold desc;

#11. Find total completed-order revenue.
select round(sum(oi.unit_price* oi.quantity),2) as total_revenue
from order_items oi 
inner join 
orders o 
on oi.order_id=o.order_id
where o.status='completed';

#12. Show categories with an average product price greater than 6,000
select category ,avg(unit_price) as avg_price 
from products 
group by category
having avg(unit_price)>6000;

#13.13. Display each order with the customer's name, order date, and status.
select c.customer_name,o.order_id,o.order_date,o.status
from customers c
inner join 
orders o 
on c.customer_id=o.customer_id
inner join 
order_items oi
on o.order_id=oi.order_id
group by c.customer_name,o.order_id,o.order_date,o.status
order by o.order_id;

#14. Show each order item with product name, quantity, unit price, and line total.
select p.product_name,oi.quantity,oi.unit_price,(oi.quantity*oi.unit_price) as line_total
from order_items oi inner join products p on oi.product_id=p.product_id;

#15. Calculate completed revenue by product, highest revenue first.
select p.product_name,round(sum(oi.unit_price*oi.quantity),2)as revenue
from products p inner join 
order_items oi
on p.product_id=oi.product_id
inner join orders o
on oi.order_id=o.order_id
where o.status='completed'
group by p.product_name
order by revenue desc;

#16. Calculate completed revenue by customer, showing customer name and city.
select c.customer_name,c.city,round(sum(oi.unit_price*oi.quantity),2) as revenue from customers c
inner join orders o 
on c.customer_id=o.customer_id
inner join 
order_items  oi 
on oi.order_id=o.order_id
where o.status="completed"
group by c.customer_name,c.city
order by revenue desc;

#17. Find customers who have never placed an order.
select c.customer_id, c.customer_name
from customers c
left join 
orders o 
on c.customer_id=o.customer_id
where c.customer_id != o.customer_id;

#18. Show products that have never appeared in any order item.
select * 
from products p
left join order_items oi
on p.product_id=oi.product_id
where oi.order_item_id is null;

#19. Find the top 5 customers by completed-order revenue.
with top_customer as(
select c.customer_name as customer,c.customer_id as id,round(sum(oi.quantity * oi.unit_price)) as revenue ,dense_rank() over(partition by c.customer_name,c.customer_id order by round(sum(oi.quantity * oi.unit_price)) desc ) as ranking
from customers c
inner join 
orders o 
on c.customer_id=o.customer_id
inner join 
order_items oi
on oi.order_id=o.order_id
where o.status='completed' 
group by c.customer_id,c.customer_name
order by revenue desc
)
select id,customer,revenue from top_customer 
where ranking <6 
order by revenue asc;


select c.customer_name as customer,c.customer_id as id,round(sum(oi.quantity * oi.unit_price)) as revenue
from customers c
inner join 
orders o
on c.customer_id=o.order_id

inner join 
order_items oi
on oi.order_id=o.order_id
where o.status='completed' 
group by c.customer_id,c.customer_name
order by revenue desc
limit 5;

#20. Calculate monthly completed revenue for 2025, ordered by month.
select date_format(o.order_date,'%y-%m') as sales_month,round(sum(oi.quantity*oi.unit_price)) as completed_revenue_by_month
from orders o 
inner join 
order_items oi 
on o.order_id=oi.order_id
where year(o.order_date)=2025 
group by date_format(o.order_date,'%y-%m')
order by sales_month asc;

#21. Find the number of completed orders and total completed revenue for each region.
select c.region,count(o.status) as completed_orders,round(sum(oi.quantity*oi.unit_price),2) as total_revenue
from customers c
inner join 
orders o 
on c.customer_id=o.customer_id
inner join 
order_items oi 
on 
oi.order_id=o.order_id
where o.status='completed'
group by c.region
order by completed_orders desc;

#22. Find products with stock below 20 and display their category.
select product_name,category,sum(stock_quantity) as stock
from products 
where stock_quantity<20
group by category,product_name
order by stock;

-- 23. For each category, calculate total completed revenue and number of distinct completed orders.
select p.category,round(sum(oi.quantity * oi.unit_price)) as revenue,count(distinct o.order_id) as distinct_completed_order
from products p 
join 
order_items oi 
 on
p.product_id =oi.product_id
 join orders o
on oi.order_id=o.order_id
where o.status='completed'
group by p.category
order by revenue;

-- 24. Find customers whose completed-order revenue is greater than 20,000.
select c.customer_id,c.customer_name,round(sum(oi.quantity * oi.unit_price)) as revenue
from customers c
join 
orders o
 on
c.customer_id =o.customer_id
 join order_items oi
on oi.order_id=o.order_id
where o.status='completed' 
group by c.customer_id,c.customer_name
having round(sum(oi.quantity * oi.unit_price)) >20000
order by revenue desc;

