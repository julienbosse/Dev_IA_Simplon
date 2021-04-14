use sakila;

# 1. Afficher tout les emprunt ayant été réalisé en 2006. Le mois doit être écrit en toute
# lettre et le résultat doit s’afficher dans une seul colonne.

SELECT rental_id,MONTHNAME(rental_date)
FROM rental
WHERE YEAR(rental_date) = 2006;

# 2. Afficher la colonne qui donne la durée de location des films en jour.

SELECT rental_id, DATEDIFF(return_date,rental_date) as duree_location
FROM rental;

# 3. Afficher les emprunts réalisés avant 1h du matin en 2005. Afficher la date dans un
# format lisible.

SELECT rental_id, DATE_FORMAT(rental_date, "%H:%i:%s %d/%m/%Y") as rental_date
FROM rental
WHERE HOUR(rental_date)<1;

# 4. Afficher les emprunts réalisé entre le mois d’avril et le mois de mai. La liste doit être
# trié du plus ancien au plus récent.

SELECT rental_id, DATE_FORMAT(rental_date, "%d/%m/%Y") as rental_date
FROM rental
WHERE MONTH(rental_date) = 4 OR MONTH(rental_date) = 5; 

# 5. Lister les film dont le nom ne commence pas par le mot « Le ».

SELECT title
FROM film
WHERE SUBSTRING(title,1,2) != "LE";

# 6. Lister les films ayant la mention « PG 13 » ou « NC 17 ». Ajouter une colonne qui
# affichera « oui » si « NC 17 » et « non » Sinon.

SELECT title, IF(rating= "NC-17", "oui", "non") as "NC-17 ?"
FROM film
WHERE rating = "PG-13" OR rating = "NC-17";

# 7. Fournir la liste des catégorie qui commence par un ‘A’ ou un ‘C’. (Utiliser LEFT).

SELECT name
FROM category
WHERE LEFT(name,1) = "A" OR LEFT(name,1) = "C";

# 8. Lister les trois premiers caractères des noms des catégorie.

SELECT LEFT(name,3) as "Trois première lettres"
FROM category;

# 9. Lister les premiers acteurs en remplaçant dans leur prenom les E par des A.

SELECT REPLACE(first_name,'E','A')
FROM actor;