# FUNCIONES DE AGREGACIÓN

SELECT COUNT(*)
FROM actors;

SELECT COUNT(*)
FROM movies
WHERE genre_id = 5;

#AVG SUM, da un numero sumando el total de minutos de duracion de las peliculas
SELECT SUM(length)
FROM movies;

#si le quiero poner un alias a la columna de respuesta
SELECT SUM(length) total_minutos
FROM movies;

SELECT AVG(rating) promedio_rating
FROM movies
WHERE genre_id= 5;

#ROUND() si quiero que me de menos decimales puedo agregar otra funcion
ROUND()
TRUNCATE();
SELECT ROUND(AVG(rating)) promedio_rating
FROM movies
WHERE genre_id= 5;

#si quiero que redondee con una cantidad de decimales determinado, agrego al final la cantidad
ROUND()
TRUNCATE();
SELECT ROUND(AVG(rating),2) promedio_rating
FROM movies
WHERE genre_id= 5;

# DOS FUNCIONES DE AGREGACIÓN
SELECT COUNT(*) total_episodios,
AVG(rating) promedio_rating
FROM episodes;


# MAX MIN
SELECT MAX(awards) max_premios, 
MIN(awards) min_premios
FROM movies
WHERE length > 100
AND rating < 7;

# GROUP BY
SELECT * #query base
FROM movies;

SELECT awards, COUNT(*) total_pelis,
MAX(rating) AS maximo_rating,
AVG(rating) AS promedio_rating
FROM movies
GROUP BY awards
ORDER BY awards;

# AGRUPAR POR UNA CLAVE FORANEA FK
SELECT genre_id
FROM movies
GROUP BY genre_id;

SELECT genre_id,
COUNT(*) AS total_pelis
FROM movies
GROUP BY genre_id;

SELECT genre_id,
COUNT(*) AS total_pelis
FROM movies
WHERE genre_id IS NOT NULL
GROUP BY genre_id;

SELECT genre_id,
#las comas separan las columnas
COUNT(*) AS total_pelis
FROM movies
WHERE genre_id IS NOT NULL
GROUP BY genre_id
HAVING total_pelis >3;


