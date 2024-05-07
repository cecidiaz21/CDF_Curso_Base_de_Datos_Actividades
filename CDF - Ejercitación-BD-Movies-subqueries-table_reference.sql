##CLASE 13- MOVIES PARTE 3
#Consultas
#SUBQUERIES Y TABLE REFERENCE

# 1- Utilizando la base de datos de movies, queremos conocer, por un lado, los títulos y el nombre del género de todas 
# las series de la base de datos.
SELECT title, genre_id
FROM series;
SELECT id
FROM genres;

#SUB -QUERIES
SELECT title, genre_id,
		(SELECT name
		FROM genres AS g
        WHERE g.id = s.genre_id) AS genre
FROM series AS s;

#TABLE REFERENCE


# 2- Por otro, necesitamos listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan 
# en cada uno de ellos.
#SUB -QUERIES
SELECT title, id
FROM episodes;

SELECT id, first_name, last_name, #selecciono 3 columnas de la tabla actors
	(SELECT actor_id #seleciono 1 columna de la tabla actor_episode (id)
    FROM actor_episode AS ae
    WHERE ae.actor_id = a.id AND 
							(SELECT title  #seleciono 1 columna de la tabla episodes (id)
							FROM episodes AS e
							WHERE e.id = ae.actor_id)
	)
FROM actors AS a; 

#segundo intento, no funciona
SELECT id, first_name, last_name, #selecciono 3 columnas de la tabla actors
	(SELECT episodes.title #seleciono 1 columna de la tabla episodes (title)
    FROM episodes 
    WHERE episodes.id = (
			SELECT actor.id  
            FROM actor AS a
            WHERE actor.id = actor_episode.episode_id
            )
	)
	AS title_episode
FROM actors AS a;

#tercer intento no funciona
SELECT id, first_name, last_name, #selecciono 3 columnas de la tabla actors
	(SELECT episodes.title, actor_episode.actor_id #seleciono 1 columna de la tabla episodes (title)
    FROM episodes, actor_episode
    WHERE episodes.id = (
			SELECT actor_episode.episode_id 
            FROM actor_episode
            WHERE actor_episode.episode_id = actor_episode.actor_id 
            AND actor_episode.actor_id = a.id
			) AS title_episode 
FROM actors AS a;

# 3- Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices (mostrar nombre y apellido) que 
# han trabajado en cualquier película de la saga de La Guerra de las galaxias.
#SUB -QUERIES
SELECT * FROM actors;

SELECT id, title
FROM movies
WHERE title LIKE ('La Guerra de las galaxias_%');

SELECT id, first_name, last_name,
	(SELECT actors.id
    FROM actors AS a
    WHERE a.id = 
		(SELECT title
		FROM movies AS m
		WHERE m.id = am.movie_id AND title LIKE ('La Guerra de las galaxias_%')
		),
FROM actor_movie AS am
GROUP BY am.movie_id) AS 
FROM actor;

SELECT id, title,
	(SELECT a.first_name
    FROM actors AS a
    WHERE a.id = (
			SELECT actor_movie.actor_id
            FROM actor_movie AS am
            WHERE am.actor_id = am.movie_id 
			) AND a.id = m.id) 
FROM movies AS m
WHERE title LIKE ('La Guerra de las galaxias_%');


# 4- Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.
#SUB -QUERIES
