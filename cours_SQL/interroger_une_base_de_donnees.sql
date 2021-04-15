use sakila;

### INTERROGATIONS AVANCEES ###

# 1. Afficher tout les emprunt ayant été réalisé en 2006. Le mois doit être écrit en toute
# lettre et le résultat doit s’afficher dans une seul colonne.

SELECT MONTHNAME(rental_date)
FROM rental
WHERE YEAR(rental_date) = 2006;

# 2. Afficher la colonne qui donne la durée de location des films en jour.

SELECT rental_id, DATEDIFF(return_date,rental_date) as duree_location
FROM rental;

# 3. Afficher les emprunts réalisés avant 1h du matin en 2005. Afficher la date dans un
# format lisible.

SELECT rental_id, DATE_FORMAT(rental_date, "%H:%i:%s %d/%m/%Y") as rental_date
FROM rental
WHERE YEAR(rental_date) = 2005 AND HOUR(rental_date)<1;

# 4. Afficher les emprunts réalisés entre le mois d’avril et le mois de mai. La liste doit être
# triée du plus ancien au plus récent.

SELECT rental_id, DATE_FORMAT(rental_date, "%d/%m/%Y") as rental_date
FROM rental
WHERE MONTH(rental_date) = 4 OR MONTH(rental_date) = 5
ORDER BY rental_date ASC; 

# 5. Lister les film dont le nom ne commence pas par le mot «LE».

SELECT title
FROM film
WHERE SUBSTRING(title,1,2) != "LE"; # Aurait pu utiliser LEFT aussi

# 6. Lister les films ayant la mention « PG 13 » ou « NC 17 ». Ajouter une colonne qui
# affichera « oui » si « NC 17 » et « non » Sinon.

SELECT title, IF(rating= "NC-17", "oui", "non") as "NC-17 ?"
FROM film
WHERE rating = "PG-13" OR rating = "NC-17";

# 7. Fournir la liste des catégories qui commencent par un ‘A’ ou un ‘C’. (Utiliser LEFT).

SELECT name
FROM category
WHERE LEFT(name,1) = "A" OR LEFT(name,1) = "C";

# 8. Lister les trois premiers caractères des noms des catégorie.

SELECT LEFT(name,3) as "Trois première lettres"
FROM category;

# 9. Lister les premiers (first name ?) acteurs en remplaçant dans leur prenom les E par des A.

SELECT REPLACE(first_name,'E','A')
FROM actor;

### LES JOINTURES ###

# 1. Lister les 10 premiers films ainsi que leur langues.

SELECT f.title, l.name
FROM film as f
JOIN language as l
	ON f.language_id = l.language_id
LIMIT 10;

# 2. Afficher les films dans lesquels a joué « JENNIFER DAVIS » sortis en 2006.

SELECT f.title
FROM film as f
JOIN film_actor as fa
	ON f.film_id = fa.film_id
JOIN actor as a
	ON fa.actor_id = a.actor_id
WHERE a.first_name = "JENNIFER" AND a.last_name = "DAVIS"  AND f.release_year = 2006;

# petit essai
# Tous les acteurs de ANACONDA CONFESSIONS
#SELECT a.first_name, a.last_name
#FROM actor as a
#JOIN film_actor as fa
#	ON a.actor_id = fa.actor_id
#JOIN film as f
#	ON fa.film_id = f.film_id
#WHERE f.title = "ANACONDA CONFESSIONS";

# 3. Afficher le nom des clients ayant emprunté "ALABAMA DEVIL"

SELECT c.last_name
FROM customer as c
JOIN rental as r
	ON c.customer_id = r.customer_id
JOIN inventory as i
	ON r.inventory_id = i.inventory_id
JOIN film as f
	ON i.film_id = f.film_id
WHERE f.title = "ALABAMA DEVIL";

# 4. Afficher les films loués par des personnes habitant à "Woodrige"

SELECT f.title
FROM film as f
JOIN inventory as i
	ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
JOIN customer as c
	ON r.customer_id = c.customer_id
JOIN address as a
	ON c.address_id = a.address_id
JOIN city as ci
	ON a.city_id = ci.city_id
WHERE ci.city = "Woodrige";

# 5. Quels sont les 10 films dont la durée d'emprunt a été la plus courte

SELECT f.title, TIMEDIFF(r.return_date, r.rental_date) as rent_duration
FROM film as f
JOIN inventory as i
	ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
WHERE TIMEDIFF(r.return_date, r.rental_date) != ''
ORDER BY rent_duration
LIMIT 10;

# 6. Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.

SELECT f.title, c.name
FROM film as f
JOIN film_category as fc
	ON f.film_id = fc.film_id
JOIN category as c
	ON fc.category_id = c.category_id
WHERE c.name = "ACTION";

# 7. Quel sont les films dont la durée d'emprunt a été inférieure à 2 jours ?

SELECT DISTINCT f.title, r.return_date, r.rental_date, TIMEDIFF(r.return_date, r.rental_date) as rent_duration
FROM film as f
JOIN inventory as i
	ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
WHERE HOUR(TIMEDIFF(r.return_date, r.rental_date)) < 48
ORDER BY TIMEDIFF(r.return_date, r.rental_date);


	