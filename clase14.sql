# TABLE REFERENCE
SELECT movies.genre_id, movies.title, genres.id
FROM genres, movies
WHERE genres.id = movies.genre_id;

#crear alias
SELECT m.genre_id, m.title, g.id
FROM genres AS g, movies AS m
WHERE g.id = m.genre_id;

#hacer la tabla de referencia, reemplazo en g.id x nombre, cambio la tabla
SELECT m.genre_id, m.title, g.name
FROM genres AS g, movies AS m
WHERE g.id = m.genre_id;

#JOIN
#la sintaxis es mas clara y nos libera el WHERE
SELECT m.genre_id, m.title, g.name
FROM movies AS m
INNER JOIN genres AS g 
ON g.id = m.genre_id
WHERE name = "Ciencia Ficcion"
AND rating >8;

SELECT g.name, COUNT(*) AS totalPeli, AVG(rating) AS promRating
FROM movies AS m
INNER JOIN genres AS g 
ON g.id = m.genre_id
GROUP BY name;

#JOIN CON MAS DE DOS TABLAS
SELECT *FROM movies;

SELECT * #esto necesito hacer con SUB QUERY
FROM movies AS m
JOIN actor_movie AS am
ON  m.id = am.movie_id
INNER JOIN actors AS a
ON am.actor_id = a.id;

#me conviene elegrir las columnas que quiero ver
SELECT m.title, a.first_name, a.last_name
FROM movies AS m
JOIN actor_movie AS am
ON  m.id = am.movie_id
INNER JOIN actors AS a
ON am.actor_id = a.id;
# a partir de este momento podemos hacer las consultas que me pide la consulta

#INNER JOIN CON DISTINCT
SELECT DISTINCT a.first_name, a.last_name
FROM movies AS m
INNER JOIN actor_movie AS am
ON  m.id = am.movie_id
INNER JOIN actors AS a
ON am.actor_id = a.id
WHERE title LIKE ('Harry%');
#tienen que ser coincidentes todas las columnas que les estamos pasando
