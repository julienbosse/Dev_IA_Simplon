/*
INSERT :

Insérez les acteurs/actrices suivants :
STAN LAUREL
OLIVER HARDY
LEONARDO DICAPRIO
KATE WINSLET

Insérez le film suivant :
titre : Titanic
description : Un transatlantique coule après avoir heurté un iceberg
release_year : 1997
language_id : 1
original language id : NULL
rental duration : 3
rental rate : 2.99
length : 210
replacement cost : 5 
rating : PG-13
Special features : Trailers
last update : date du jour

Insérez les lignes correspondant à LEONARDO DICAPRIO et KATE WINSLET dans film_actor

Insérez vos infos en tant que Customer (mettez une adresse fictive déjà présente dans la table address)
*/

USE sakila;

INSERT INTO actor (first_name, last_name)
VALUES
	("STAN", "LAUREL"),
	("OLIVER", "HARDY"),
    ("LEONARDO", "DICAPRIO"),
    ("KATE", "WINSLET");
    
INSERT INTO film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features)
VALUES 
	("TITANIC",
	"Un transatlantique coule après avoir heurté un iceberg",
    1997,
    1,
    NULL,
    3,
    3.99,
    210,
    5,
    "PG-13",
    "Trailers");
    
INSERT INTO film_actor (actor_id, film_id)
VALUES 
	( (SELECT actor_id FROM actor WHERE concat(first_name," ", last_name) = "LEONARDO DICAPRIO") , (SELECT film_id FROM film WHERE title="TITANIC") ),
    ( (SELECT actor_id FROM actor WHERE concat(first_name," ", last_name) = "KATE WINSLET") , (SELECT film_id FROM film WHERE title="TITANIC") );

/*
------------------------------
UPDATE:
Mettez à jour tous les films avec un rating à "R". Mettez le replacement cost à 50.

Mettez à jour l'adresse vous correspondant en tant que customer. Insérez une nouvelle adresse si besoin.
*/

UPDATE film
SET
	replacement_cost = 50
WHERE 
	rating = "R";
    
UPDATE address
SET
	address = "115 Boulevard des Ecureuils",
    address2 = " "
WHERE address_id = ( SELECT address_id FROM customer WHERE (concat(first_name," ", last_name) = "JULIEN BOSSE") );
		
/*
------------------------------
DELETE :
Supprimez les lignes correspondant à STAN LAUREL et OLIVER HARDY de la table actor.

Suprimez les lignes correspondant à KATE WINSLET et LEONARDO DICAPRIO
*/

DELETE FROM actor 
WHERE (concat(first_name," ", last_name) = "STAN LAUREL") OR (concat(first_name," ", last_name) = "OLIVER HARDY");

DELETE FROM film_actor
WHERE actor_id = (SELECT actor_id FROM actor WHERE concat(first_name," ", last_name) = "LEONARDO DICAPRIO") OR actor_id = (SELECT actor_id FROM actor WHERE concat(first_name," ", last_name) = "KATE WINSLET");

DELETE FROM actor 
WHERE (concat(first_name," ", last_name) = "LEONARDO DICAPRIO") OR (concat(first_name," ", last_name) = "KATE WINSLET");


	
