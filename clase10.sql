SELECT * FROM movies; 
/* atajos para ver todo de la tabla == QUERY BASE
siempre arranco desde esta consulta, que es grande y despues se va especificando
*/

/* 
operador AND OR
*/
SELECT * FROM movies 
WHERE awards > 5
OR rating > 8;
#se cumple una de las dos condiciones y cumple el filtro

SELECT * FROM movies 
WHERE awards > 5
AND rating > 8;
#debe cumplir las dos condiciones y pasa el filtro

SELECT *
FROM series
WHERE year(release_date) = 2010;

SELECT *
FROM series
WHERE month(release_date) = 2010;

#a un data time le podes traer cualquier valor si lo que queres hacer es comparar


SELECT title, rating 
FROM movies;

SELECT id, title, rating
FROM movies;

SELECT *
FROM movies
WHERE rating = 9.1 
AND awards > 4;  #doble condición

SELECT *
FROM movies
WHERE length <> 120; #filtro por duracion de la pelicula

SELECT *
FROM movies
WHERE genre_id = 7; #filtre por un atributo de una tabla

SELECT * 
FROM movies 
WHERE genre_id is NULL;

# order by, nos permite ordenar en base a una columna que no sea el ID
SELECT *
FROM actors
ORDER BY first_name;

SELECT *
FROM actors
ORDER BY rating;

SELECT first_name, rating
FROM actors
WHERE RATING >= 5 AND rating <= 8
ORDER BY rating DESC;

SELECT first_name, last_name, rating
FROM actors
WHERE RATING >= 5 AND rating <= 8
ORDER BY rating DESC;

#BETWEEN
SELECT * 
FROM movies
WHERE release_date 
BETWEEN "2000-01-01" 
AND "2024-04-17";

#otra opcion que da el mismo resultado NOW() es una funcion que provee fecha actual
SELECT * 
FROM movies
WHERE release_date 
BETWEEN  "2000-01-01" 
AND NOW();

SELECT first_name, rating 
FROM actors
WHERE rating
BETWEEN  7 AND 10;

SELECT first_name, last_name
FROM actors
ORDER BY first_name;


SELECT first_name, last_name
FROM actors
WHERE first_name BETWEEN "Emma" AND "Renne"
ORDER BY first_name;

#Like
SELECT *
FROM series
WHERE release_date LIKE"2010%";

SELECT *
FROM series
WHERE release_date LIKE"2010%";

SELECT title
FROM movies
WHERE title LIKE "toy%";

SELECT title
FROM movies
WHERE title LIKE "L%s%";

/*
ORDEN ESPECIFICO
SELECT
FROM
WHERE
ORDER BY
*/