USE sakila;
SELECT f.title, c.first_name, c.last_name, DATEDIFF(r.return_date, r.rental_date) as duree, p.amount, sta.first_name, sta.last_name, a.*, ci.city, co.country
FROM rental as r
JOIN customer as c 
	ON r.customer_id = c.customer_id
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN film as f
	ON i.film_id = f.film_id
JOIN store as s
	ON i.store_id = s.store_id
JOIN address as a
	ON s.address_id = a.address_id
JOIN city as ci
	ON a.city_id = ci.city_id
JOIN country as co
	ON ci.country_id = co.country_id
JOIN payment as p
	ON r.rental_id = p.rental_id
JOIN staff as sta
	ON r.staff_id = sta.staff_id

WHERE (YEAR(rental_date) = 2006 OR YEAR(return_date) = 2006) OR return_date IS NULL ORDER BY rental_date;

