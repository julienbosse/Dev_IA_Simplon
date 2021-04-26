use sakila;

# 1. Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée).

SELECT cu.last_name as nom, cu.first_name as prenom, f.title as film, ci.city as video_club, TIMEDIFF(r.return_date, r.rental_date) as duree_heures
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

# 4. Afficher tous les films n'ayant jamais été empruntés

SELECT f.title
FROM film as f
WHERE f.title 
NOT IN (
	SELECT f.title
    FROM rental as r
    JOIN inventory as i
		ON r.inventory_id = i.inventory_id
	JOIN film as f
		ON i.film_id = f.film_id);

# 5. Afficher le nombre d'employés (staff) par video club

SELECT sto.store_id, count(sta.staff_id) as nombre_d_employes
FROM staff as sta
JOIN store as sto
	ON sta.store_id = sto.store_id
GROUP BY store_id;

# 6. Afficher les 10 villes avec le plus de vidéos clubs

SELECT c.city, count(store_id)
FROM store as sto
JOIN address as a
	ON sto.address_id = a.address_id
JOIN city as c
	ON a.city_id = c.city_id
GROUP BY c.city
ORDER BY count(store_id) DESC
LIMIT 10;

# 7. Afficher le film le plus dans lequel a joué "JOHNNY LOLLOBRIGIDA".alter

SELECT f.title as film_avec_JL, f.length
FROM film as f
JOIN film_actor as fa
	ON f.film_id = fa.film_id
JOIN actor as a
	ON fa.actor_id = a.actor_id
JOIN film_category as fc
	ON f.film_id = fc.film_id
JOIN category as c
	ON fc.category_id = c.category_id
WHERE a.last_name = "LOLLOBRIGIDA" AND a.last_name = "LOLLOBRIGIDA"
ORDER BY f.length DESC
LIMIT 1;

SELECT f.title as film_avec_JL, f.length
FROM film as f
JOIN film_actor as fa
	ON f.film_id = fa.film_id
JOIN actor as a
	ON fa.actor_id = a.actor_id
JOIN film_category as fc
	ON f.film_id = fc.film_id
JOIN category as c
	ON fc.category_id = c.category_id
WHERE a.last_name = "LOLLOBRIGIDA" AND a.last_name = "LOLLOBRIGIDA"
ORDER BY f.length DESC
LIMIT 1;

# 8. Afficher le temps moyen de location du film "ACADEMY DINOSAUR"

SELECT f.title, AVG(TIMESTAMPDIFF(DAY, r.rental_date, r.return_date)) as duree_moyenne
FROM film as f
JOIN inventory as i
	ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
WHERE f.title = "ACADEMY DINOSAUR";

# 9. Afficher les films avec plus de deux exemplaires en inventaire (store id, titre du film, nombre d'exemplaires)

SELECT  i.store_id, f.title, count(i.inventory_id) as nombre_exemplaires
FROM inventory as i
JOIN film as f
	ON i.film_id = f.film_id
GROUP BY f.title, i.store_id
HAVING count(i.inventory_id) > 2;

# 10. Lister les films contenant "din" dans le titre

SELECT title
FROM film
WHERE title LIKE "%DIN%";

# 11. Lister les 5 films les plus empruntés

SELECT f.title, count(r.rental_id)
FROM film as f
JOIN inventory as i
	ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY count(r.rental_id) DESC
LIMIT 5;

# 12. Lister les films sortis en 2003, 2005 et 2006

SELECT f.title, f.release_year
FROM film as f
WHERE f.release_year = 2003 OR f.release_year = 2005 OR f.release_year = 2006;

# 13. Afficher les films ayant été empruntés mais pas encore restitués, triés par date d'emprunt. Afficher les 10 premiers

SELECT f.title, r.rental_date
from rental as r
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN film as f
	ON i.film_id = f.film_id
WHERE r.return_date IS NULL
ORDER BY r.rental_date
LIMIT 10;

# 14. Afficher les films d'actions de plus de 2h

SELECT f.title, f.length, c.name
FROM film as f
JOIN film_category as fa
	ON f.film_id = fa.film_id
JOIN category as c
	ON fa.category_id = c.category_id
WHERE f.length > 160 AND c.name = "Action";

# 15. Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17.

SELECT cu.first_name, cu.last_name, f.title, f.rating
FROM rental as r
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN film as f
	ON i.film_id = f.film_id
JOIN customer as cu
	ON r.customer_id = cu.customer_id
WHERE f.rating = "NC-17";

# 16. Afficher les films d'animation dont la langue originale est l'anglais

SELECT f.title
FROM film as f
JOIN film_category as fa
	ON f.film_id = fa.film_id
JOIN category as c
	ON fa.category_id = c.category_id
JOIN language as l
	ON f.original_language_id = l.language_id
WHERE c.name = "Animation" and l.name = "English";

# 17. Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny)

SELECT f.title
FROM film as f
JOIN film_actor as fa
	ON f.film_id = fa.film_id
JOIN actor as a
	ON fa.actor_id = a.actor_id
WHERE a.first_name = "JENNIFER"
AND f.title IN (
	SELECT f.title
	FROM film as f
	JOIN film_actor as fa
		ON f.film_id = fa.film_id
	JOIN actor as a
		ON fa.actor_id = a.actor_id
	WHERE a.first_name = "JOHNNY");
    
    # Question 17 avec syntaxe différente
    
SELECT film_jenny.* 
FROM 
    (
        SELECT film.*
        FROM film
        JOIN film_actor ON film.film_id = film_actor.film_id
        JOIN actor ON film_actor.actor_id = actor.actor_id
        WHERE actor.first_name = "JENNIFER"
    ) AS film_jenny
JOIN 
    (
        SELECT film.film_id
        FROM film
        JOIN film_actor ON film.film_id = film_actor.film_id
        JOIN actor ON film_actor.actor_id = actor.actor_id
        WHERE actor.first_name = "JOHNNY"
    ) AS film_johnny
ON film_jenny.film_id = film_johnny.film_id;
    
# 18. Quelles sont les 3 catégories les plus empruntées?

SELECT c.name, count(r.rental_id)
FROM rental as r
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN film as f
	ON i.film_id = f.film_id
JOIN film_category as fc
	ON f.film_id = fc.film_id
JOIN category as c
	ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY count(r.rental_id) DESC
LIMIT 3;

# 19. Quelles sont les 10 villes où on a fait le plus de locations?

SELECT c.city, count(r.rental_id)
FROM rental as r
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN store as sto
	ON i.store_id = sto.store_id
JOIN address as a
	ON sto.address_id = a.address_id
JOIN city as c
	ON a.city_id = c.city_id
GROUP BY c.city
LIMIT 10;

# 20. Lister les acteurs ayant joué dans au moins 1 film.

SELECT a.first_name, a.last_name, count(fa.film_id)
FROM actor as a
JOIN film_actor as fa
	ON a.actor_id = fa.actor_id
WHERE a.actor_id
IN (
	SELECT a.actor_id
    FROM film_actor
)
GROUP BY a.actor_id;