use sakila;

INSERT INTO actor (first_name, last_name)
VALUES ("CHRIS", "PRATT");

INSERT INTO actor (first_name, last_name)
VALUES ("BRADLEY", "COOPER");

INSERT INTO film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features)
VALUES ("GUARDIANS OF THE GALAXY",
		"Peter Quill is an adventurer hunted by all bounty hunters for stealing a mysterious globe coveted by the mighty Ronan, whose actions threaten the entire universe. He discovers the true power of this globe and the threat to the galaxy, he presents a fragile alliance with four disparate extraterrestrials.",
		2014,
        (SELECT max(language_id) FROM language WHERE name = "English"),
        (SELECT max(language_id) FROM language WHERE name = "English"),
        7,
        4.99,
        20.99,
        122,
        "G",
        "Trailers");
	
    
INSERT INTO film_actor (actor_id, film_id)
VALUES( (SELECT actor_id FROM actor  WHERE concat(first_name," ", last_name) = "CHRIS PRATT"),
		(SELECT film_id FROM film WHERE title = "GUARDIANS OF THE GALAXY") );

INSERT INTO film_actor (actor_id, film_id)
VALUES( (SELECT actor_id FROM actor  WHERE concat(first_name," ", last_name) = "BRADLEY COOPER"),
		(SELECT film_id FROM film WHERE title = "GUARDIANS OF THE GALAXY") );


SELECT * FROM film WHERE title = "GUARDIANS OF THE GALAXY" LIMIT 1;

SELECT f.title, a.* 
FROM film as f
JOIN film_actor as fa
	ON f.film_id = fa.film_id
JOIN actor as a
	ON fa.actor_id = a.actor_id
WHERE f.title = "GUARDIANS OF THE GALAXY";
