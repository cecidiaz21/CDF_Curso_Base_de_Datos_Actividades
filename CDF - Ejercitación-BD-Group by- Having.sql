# Ejercitación consultas - Bases de datos
# Consultas de base de datos movies Group By y Having

#1 - ¿Cuántas películas hay?
SELECT 
COUNT(*) AS total_pelis
FROM movies;

#2 - ¿Cuántas películas tienen entre 3 y 7 premios?
SELECT *
FROM movies;

SELECT title, awards
FROM movies;

SELECT title, awards
FROM movies
WHERE awards 
BETWEEN 3 AND 7;

#3 - ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
SELECT title, rating, awards
FROM movies
WHERE rating > 7 
AND awards 
BETWEEN 3 AND 7;

#4 - Encuentra la cantidad de actores en cada película.
SELECT movies.title AS titulo_pelicula, 
COUNT (actor_movie.actor_id) AS cantidad_actores
FROM movies_db.movies 
LEFT JOIN movies_db.actor_movie am ON movies.id = actor_movie
GROUP BY movies.id;

#creo que este ejercicio se hace con JOIN,  logre el resultado consultando en ChatGPT pero no lo entendi del todo

SELECT m.title AS movie_title, COUNT(am.actor_id) AS actor_count
FROM movies_db.movies m
LEFT JOIN movies_db.actor_movie am ON m.id = am.movie_id
GROUP BY m.id;

#5 - Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.
SELECT genre_id, COUNT(title) AS cantidad_peli_por_genero
FROM movies
GROUP BY genre_id;

#6 - De la consulta anterior, listar sólo aquellos géneros que tengan como suma de premios un número mayor a 5.
SELECT genre_id, 
COUNT(awards) AS total_pelis, SUM(awards) AS total_premios
FROM movies
GROUP BY genre_id
HAVING total_premios >= 5;

#7 - Encuentra los géneros que tienen las películas con un promedio de calificación mayor a 6.0.
SELECT genre_id,
AVG(rating) as promedio_rating
FROM movies
GROUP BY genre_id
HAVING promedio_rating > 6.0;

#8 - Encuentra los géneros que tienen al menos 3 películas.genres
SELECT genre_id, 
COUNT(title) AS total_pelis
FROM movies
GROUP BY genre_id
HAVING total_pelis >= 3;