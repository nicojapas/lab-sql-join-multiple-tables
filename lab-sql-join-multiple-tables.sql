-- # Lab | SQL Joins on multiple tables

-- In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

-- 1. Write a query to display for each store its store ID, city, and country.
select
	st.store_id,
	ci.city,
	co.country
from sakila.store as st
join sakila.address as ad using (address_id)
join sakila.city as ci using (city_id)
join sakila.country as co using (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.
select
sto.store_id,
sum(py.amount) as total_amount
from sakila.store as sto
join sakila.staff as sta using(store_id)
join sakila.payment as py using(staff_id)
group by sto.store_id
order by total_amount desc;

-- 3. What is the average running time of films by category?
select
	cy.name,
	avg(fl.length) as average_length
from sakila.film as fl
join sakila.film_category as ca using (film_id)
join sakila.category as cy using (category_id)
group by cy.name;

-- 4. Which film categories are longest?
select
	cy.name,
	avg(fl.length) as average_length
from sakila.film as fl
join sakila.film_category as ca using (film_id)
join sakila.category as cy using (category_id)
group by cy.name
order by average_length desc;

-- 5. Display the most frequently rented movies in descending order.
select
	fi.title,
	count(fi.film_id) as count
from sakila.rental as re
join sakila.inventory as inv using (inventory_id)
join sakila.film as fi using (film_id)
group by fi.film_id
order by count desc;

-- 6. List the top five genres in gross revenue in descending order.
select
	cy.name,
	sum(py.amount) as total_amount
from sakila.payment as py
join sakila.rental using (rental_id) 
join sakila.inventory using (inventory_id)
join sakila.film using (film_id)
join sakila.film_category as ca using (film_id)
join sakila.category as cy using (category_id)
group by ca.category_id
order by total_amount desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select
	fl.title,
    inv.store_id
from sakila.film as fl
join sakila.inventory as inv using (film_id)
where fl.title = 'Academy Dinosaur'
group by inv.store_id
having inv.store_id = 1;