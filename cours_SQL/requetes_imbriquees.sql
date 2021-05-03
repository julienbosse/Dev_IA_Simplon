# 1. Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films où a joué « MCCONAUGHEY CARY ».

SELECT DISTINCT a.first_name, a.last_name
FROM actor as a
JOIN film_actor as fa
	ON a.actor_id = fa.actor_id
JOIN film as f
	ON fa.film_id = f.film_id
WHERE (concat(a.first_name," ", a.last_name) != "CARY MCCONAUGHEY")
AND f.title IN (
	SELECT f.title
	FROM film as f
	JOIN film_actor as fa
		ON f.film_id = fa.film_id
	JOIN actor as a
		ON fa.actor_id = a.actor_id
	WHERE (concat(a.first_name," ", a.last_name) = "CARY MCCONAUGHEY")
);

# 2. Afficher tout les acteurs n’ayant pas joués dans les films ou a joué « MCCONAUGHEY CARY ».

SELECT DISTINCT a.first_name, a.last_name
FROM actor as a
WHERE a.actor_id NOT IN (
	SELECT DISTINCT a.actor_id
	FROM actor as a
	JOIN film_actor as fa
		ON a.actor_id = fa.actor_id
	JOIN film as f
		ON fa.film_id = f.film_id
	AND f.title IN (
		SELECT f.title
		FROM film as f
		JOIN film_actor as fa
			ON f.film_id = fa.film_id
		JOIN actor as a
			ON fa.actor_id = a.actor_id
		WHERE (concat(a.first_name," ", a.last_name) = "CARY MCCONAUGHEY")
	)
);

# 3. Afficher uniquement le nom du film qui contient le plus d'acteurs et le nombre d'acteurs associé sans utiliser LIMIT (2 niveaux de sous requêtes).

SELECT f.title, count(fa.actor_id) as act_num
FROM film as f
JOIN film_actor as fa
	ON f.film_id = fa.film_id
GROUP BY f.title
HAVING count(fa.actor_id) = (SELECT max(reponse.act_num)
							 FROM (  SELECT f2.title, count(fa2.actor_id) as act_num
									 FROM film as f2
									 JOIN film_actor as fa2
										 ON f2.film_id = fa2.film_id
									 GROUP BY f2.title) as reponse );
                                    
# 4. Afficher les acteurs ayant joué uniquement dans des films d’actions (Utiliser EXISTS).

SELECT DISTINCT a.first_name, a.last_name
FROM actor as a
WHERE NOT EXISTS (SELECT DISTINCT a2.first_name, a2.last_name
				FROM actor as a2
				JOIN film_actor as fa2
					ON a2.actor_id = fa2.actor_id
				JOIN film as f2
					ON fa2.film_id = f2.film_id
				JOIN film_category as fc2
					ON fc2.film_id = f2.film_id
				JOIN category as c2
					ON fc2.category_id = c2.category_id
				WHERE c2.name != "Action"
				AND a2.actor_id = a.actor_id);

SELECT *
from actor as a2
WHERE NOT EXISTS (
    select distinct a.actor_id
    FROM actor as a
    INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
    INNER JOIN film as f ON f.film_id = fa.film_id
    INNER JOIN film_category as fc ON f.film_id = fc.film_id
    INNER JOIN category as c ON c.category_id = fc.category_id
    where c.name <> 'Action'
    and a2.actor_id = a.actor_id )
;

SELECT DISTINCT a2.first_name, a2.last_name
FROM actor as a2
JOIN film_actor as fa2
	ON a2.actor_id = fa2.actor_id
JOIN film as f2
	ON fa2.film_id = f2.film_id
JOIN film_category as fc2
	ON fc2.film_id = f2.film_id
JOIN category as c2
	ON fc2.category_id = c2.category_id
WHERE c2.name != "Action";