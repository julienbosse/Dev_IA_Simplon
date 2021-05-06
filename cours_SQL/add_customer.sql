use sakila;

INSERT INTO city (city, country_id)
VALUES ("Mandelieu", (SELECT country_id FROM country WHERE country = "France" LIMIT 1) );

INSERT INTO address (address, address2, district, city_id, postal_code, phone, location)
VALUES ("499 Avenue Janvier Passero",
		"Batiment A",
		" ",
        (SELECT city_id FROM city WHERE city = "Mandelieu" LIMIT 1),
        "06210",
        "0610543054",
        ST_GeomFromWKB(X'0101000000000000000000F03F000000000000F03F'));
        
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (1,
		"JULIEN",
		"BOSSE",
        "julien@bosse.pro",
        (SELECT address_id FROM address WHERE address = "499 Avenue Janvier Passero" AND address2 = "Batiment A" AND postal_code = "06210"),
        1,
        CURRENT_DATE());

SELECT * FROM address 
WHERE address = "499 Avenue Janvier Passero" AND address2 = "Batiment A" AND postal_code = "06210";

SELECT * FROM city
WHERE city = "Mandelieu";

SELECT * FROM customer 
WHERE (concat(first_name," ", last_name) = "JULIEN BOSSE");

