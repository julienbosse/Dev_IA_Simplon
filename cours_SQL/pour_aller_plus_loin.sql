use sakila;

# 1. Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée).

SELECT cu.last_name as nom, cu.first_name as prenom, f.title as film, ci.city as video_club, TIMEDIFF(r.return_date, r.rental_date) as durée
FROM rental as r
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN film as f
	ON i.film_id = f.film_id
JOIN staff as sta
	ON r.staff_id = sta.staff_id
JOIN store as sto
	ON sta.store_id = sto.store_id
JOIN address as a
	ON sto.address_id = a.address_id
JOIN city as ci
	ON a.city_id = ci.city_id
JOIN customer as cu
	ON r.customer_id = cu.customer_id
WHERE TIMEDIFF(r.return_date, r.rental_date) IS NOT NULL
ORDER BY TIMEDIFF(r.return_date, r.rental_date) DESC
LIMIT 10;

# 2. Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé).

SELECT c.last_name, c.first_name, SUM(p.amount)
FROM customer as c
JOIN rental as r
	ON c.customer_id = r.customer_id
JOIN payment as p
	ON r.rental_id = p.rental_id
GROUP BY r.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 10;

# 3. Afficher la durée moyenne de location par film triée de manière descendante.

SELECT f.title, AVG(TIMESTAMPDIFF(DAY, r.rental_date, r.return_date)) as duree_moyenne
FROM film as f
JOIN inventory as i
	ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY AVG(TIMESTAMPDIFF(DAY, r.rental_date, r.return_date)) DESC;


