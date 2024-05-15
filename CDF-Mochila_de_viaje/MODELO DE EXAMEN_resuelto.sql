/* MODELO EXAMEN FINAL
 - Bases de datos.  Consultas a la Base de datos Pokemon.
EJERCICIOS
*/
## Where
#1- Mostrar el nombre, peso y altura de los pokémon cuyo peso sea mayor a 150. 
#Tablas: pokemon. Campos: nombre, peso, altura.
SELECT *
FROM pokemon;

SELECT nombre, peso, altura
FROM pokemon
WHERE peso > 150;

#2- Muestra los nombres y potencias de los movimientos que tienen una precisión mayor 90.
# Tablas: movimiento. Campos: m.nombre, potencia.
SELECT nombre, potencia, precision_mov
FROM movimiento
WHERE precision_mov > 90;

SELECT nombre AS movimiento, potencia, precision_mov #si la precision es 100% significa que nunca va a fallar y a mayor potencia mayor daño
FROM movimiento
WHERE precision_mov > 90;

## Operadores & joins
#1- Mostrar tipo, nombre y potencia de los movimientos que tienen una potencia mayor igual que 120. 
#Tablas: movimiento, tipo. Campos: t.nombre, m.nombre, m.potencia.
SELECT m.nombre AS nombre,
		t.nombre AS tipo,
        potencia #puede ponerse solo, no hace falta el m. xq es la unica columna que hay y no genera confusión
FROM movimiento AS m
JOIN tipo AS t  #se puede usar INNER JOIN, es lo mismo
ON m.id_tipo = t.id_tipo
WHERE m.potencia >= 120;

#2- Muestra los nombres de los tipos de Pokémon junto con sus tipos de ataque correspondientes de aquellos cuya potencia sea igual a 0. 
#Tablas: tipo, tipo_ataque, movimiento. Campos: t.nombre ta.tipo m.potencia.
SELECT m.nombre AS movimiento, 
		t.nombre AS tipo,
		ta.tipo AS tipo_ataque,
        potencia
FROM tipo AS t
JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque 
JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
WHERE potencia = 0;

## Order by
#1- Muestra los nombres y números de Pokédex de los primeros 10 Pokémon en orden alfabético. Tablas: pokemon. Campos: numero_pokedex, nombre.
SELECT numero_pokedex, 
		nombre AS pokemon
FROM pokemon;
SELECT numero_pokedex, 
		nombre AS pokemon
FROM pokemon
ORDER BY nombre
LIMIT 10;
--
#2- Muestra los nombres y alturas de los Pokémon de tipo "Eléctrico", ordenados por altura de forma descendente. 
#Tablas: pokemon, pokemon_tipo, tipo. Campos: nombre, altura
SELECT p.nombre,
	t.nombre AS tipo_nombre, 
	 p.altura
FROM pokemon AS p
JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
WHERE t.nombre LIKE '%Eléctrico%'
ORDER BY altura DESC;

## Funciones de agregación
#1- ¿Cuál es la suma total de los valores de "Defensa" en todas las estadísticas base? 
#Tablas: estadisticas_base. Campos: defensa.
SELECT SUM(defensa) AS sum_total_defensa
FROM estadisticas_base;

#2- ¿Cuántos Pokémon tienen el tipo "Fuego"? tablas: pokemon_tipo, tipo. Campos:* 
SELECT *
FROM pokemon_tipo;

SELECT *
FROM tipo;

SELECT COUNT(*) AS total_pokemon_fuego
FROM pokemon_tipo AS pt
INNER JOIN tipo AS t
ON pt.id_tipo = t.id_tipo
WHERE t.nombre LIKE 'Fuego';

#otra manera
SELECT nombre, numero_pokedex
FROM pokemon_tipo AS pt
INNER JOIN tipo AS t
ON pt.id_tipo = t.id_tipo
WHERE t.nombre LIKE 'Fuego';

##Group by
#1- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo.
#Tablas: pokemon_tipo, tipo. Campos: nombre, numero_pokedex.
SELECT t.nombre AS nombre_tipo_pokemon, 
		COUNT(*) AS cantidad_pokemon
FROM pokemon_tipo AS pt
JOIN tipo AS t ON pt.id_tipo = t.id_tipo
GROUP BY t.nombre;

#otra forma
SELECT t.nombre AS tipo,
		COUNT(*)  AS total_pokemon #3 
FROM tipo AS t	
	INNER JOIN pokemon_tipo AS pt
    ON t.id_tipo = pt.id_tipo #1 nos fijamos q funcione, en especial id_tipo sea igual en las dos columnas que me trae
GROUP BY t.nombre; #2 el unico que nos permite agrupar por alias

#ejemplo extra, queriamos saber cuanto pokemones tenian mas de un tipo
SELECT SUM(total_pokemon) - 151 AS pokemon_multitipo  #la SUM me da 214 en total, xq es la cantidad de pokemones de todo tipo
FROM (SELECT t.nombre AS tipo, COUNT(*) AS total_pokemon 
        FROM tipo AS t
		INNER JOIN pokemon_tipo AS pt
		ON t.id_tipo = pt.id_tipo
        GROUP BY tipo) AS la_mejor_tabla;

#2- Muestra los nombres de los tipos de Pokémon junto con el promedio de peso de los Pokémon de cada tipo. 
#Ordena los resultados de manera descendente según el promedio de peso.
#Tablas: pokemon, pokemon_tipo, tipo. Campos: t.nombre, p.peso
SELECT t.nombre AS tipo,
		AVG(p.peso) AS promedio_peso
FROM tipo AS t
	INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo 
	INNER JOIN pokemon AS p
	ON pt.numero_pokedex = p.numero_pokedex #1 nos fijamos q funcione, en especial id_tipo sea igual en las dos columnas que me trae
GROUP BY tipo #agrupo los nombres de tipo de pokemon 
ORDER BY promedio_peso DESC;

#otra forma agregando una funcion de alteracion para redonder los numeros que nos dieron en los promedios del peso
SELECT t.nombre AS tipo,
		ROUND(AVG(p.peso), 2) AS promedio_peso #el round lleva dos variables que le damos, la primera la columna q quiero modificar y la segunda la cantidad de decimales que quiero en esa columna
FROM tipo AS t
	INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo 
	INNER JOIN pokemon AS p
	ON pt.numero_pokedex = p.numero_pokedex #1 nos fijamos q funcione, en especial id_tipo sea igual en las dos columnas que me trae
GROUP BY tipo #agrupo los nombres de tipo de pokemon 
ORDER BY promedio_peso DESC;
-- 
##Having
#1- Muestra los nombres de los Pokémon que tienen más de un tipo. 
#Tablas: pokemon, pokemon_tipo. Campos: nombre.
SELECT p.nombre, COUNT(id_tipo) AS cantidad_total_tipos
FROM pokemon AS p
	INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
GROUP BY nombre
HAVING cantidad_total_tipos != 1; #la funcion de agregacion me permite filtrar solo por having otra forma seria >1

#para verlo de otra manera y comprobar, desde el ejemplo para saber cuanto pokemons teniamos multitipo
SELECT COUNT(*) FROM (SELECT p.nombre, COUNT(id_tipo) AS cantidad_total_tipos
FROM pokemon AS p
	INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
GROUP BY nombre
HAVING cantidad_total_tipos != 1) AS pokemon_multitipo;

#2- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen un peso promedio mayor a 10. 
#Tablas: pokemon, pokemon_tipo, tipo. Campos: nombre, numero_pokedex.
SELECT COUNT(*) #paso 2 para ver el total de pokemon que tienen asingado un tipo, por la consulta de ejemplo anterior sabemos que 63 tienen mas de 1 tipo asignado
FROM pokemon AS p
	INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
	INNER JOIN tipo AS t
	ON t.id_tipo = pt.id_tipo; #paso 1 para combinar las tablas para resolver la consulta
#veamos la cantidad de pokemon por nombre
SELECT t.nombre AS tipo,
		COUNT(*) AS total_pokemon
FROM tipo AS t
	INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
	INNER JOIN pokemon AS p 
    ON p.numero_pokedex = pt.numero_pokedex
GROUP BY t.nombre;

#sigo agregando consultas para llegar a la respuesta
SELECT t.nombre AS tipo,
		COUNT(*) AS total_pokemon,
        AVG(peso) AS promedio_peso
FROM tipo AS t
	INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
	INNER JOIN pokemon AS p 
    ON p.numero_pokedex = pt.numero_pokedex
GROUP BY t.nombre
HAVING promedio_peso > 50; #ponemos 50 para que veamos que se esta filtrando

SELECT p.nombre AS tipo, 
		COUNT(*) AS total_pokemon,
        AVG (p.peso) AS promedio_peso		
FROM pokemon AS p
	INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
	INNER JOIN tipo AS t
	ON t.id_tipo = pt.id_tipo
GROUP BY tipo
HAVING AVG(peso) >= 10;

## Funciones de alteración
#1- Muestra los nombres de los movimientos de tipo de ataque "Especial" con una potencia superior a 10 y una desc que contenga al menos 20 palabras.
#Tablas: movimiento, tipo_ataque. Campos: nombre, potencia, tipo, descripcion
SELECT m.nombre, ta.tipo AS tipo_ataque,
		m.potencia,		
        SUBSTRING(m.descripcion, 20) AS descripcion_breve #ultimo paso, esta es la funcion de alteracion 
FROM movimiento AS m
	INNER JOIN tipo AS t
	ON m.id_tipo = t.id_tipo
	INNER JOIN tipo_ataque AS ta
	ON ta.id_tipo_ataque = t.id_tipo_ataque #paso 1 para poder tomar las columnas de las 3 tablas que nos interesan
WHERE ta.tipo LIKE "Especial" AND m.potencia >= 10; # paso 2, aca ponemos la condicion que necesitamos para obtener la respuesta

#2- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 80. 
# Solo incluye tipos que tienen al menos 3 Pokémon con esas características. 
#Tablas: tipo, pokemon_tipo, estadisticas_base. Campos: t.nombre, *
SELECT t.nombre, 
		COUNT(t.nombre) AS cantidad_pokemon_x_nombre, #paso 3, funcion de agregacion que necesito para saber la cant de pokemon de cada tipo por nombre
		ROUND(AVG(eb.velocidad),2) AS velocidad_promedio #funcion de agregación que me permite ver la velocidad promedio de cada pokemon
FROM tipo AS t
	JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
	JOIN pokemon AS p
	ON p.numero_pokedex = pt.numero_pokedex
	JOIN estadisticas_base AS eb #paso 1 para poder vincular las tablas que queremos analizar
	ON eb.numero_pokedex = p.numero_pokedex
GROUP BY t.nombre #paso 2 agrupo por nombre
HAVING velocidad_promedio > 80 AND cantidad_pokemon_x_nombre >3; # paso 4 condicion que me esta pidiendo que cumpla

##Registros
#1- Muestra el nombre de cada Pokémon junto con su tipo, velocidad base y puntos de salud (PS) base. 
#Ordena los resultados por la velolidad base de forma descendiente. 
# Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo. Campos: p.nombre, t.nombre, eb.velocidad, eb.ps.
SELECT p.nombre, t.nombre AS tipo_pokemon,
		eb.velocidad, eb.ps AS puntos_salud
FROM pokemon_tipo AS pt
	INNER JOIN pokemon AS p
	ON pt.numero_pokedex = p.numero_pokedex
	INNER JOIN estadisticas_base AS eb
	ON eb.numero_pokedex = p.numero_pokedex
	INNER JOIN tipo AS t
	ON t.id_tipo = pt.id_tipo
ORDER BY eb.velocidad DESC;

#otra forma paso 1
SELECT p.nombre AS pokemon, t.nombre AS tipo
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.id_tipo;

#otra forma paso 2 agregamos la tabla de estadisticas basicas y de ahi las columnas que necesitamos para resolver
SELECT p.nombre AS pokemon, t.nombre AS tipo,
	velocidad, #no se repiten estas columnas por lo que no hace faltan alias
    ps
FROM pokemon AS p
	INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
	INNER JOIN tipo AS t
	ON t.id_tipo = pt.id_tipo
    INNER JOIN estadisticas_base AS eb
    ON eb.numero_pokedex = p.numero_pokedex
ORDER BY velocidad DESC;

#2- Muestra los nombres de los movimientos de tipo "Agua" junto con los nombres de los Pokémon que pueden aprenderlos y el peso promedio de estos
#Pokémon. Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon. Campos: m.nombre, p.nombre, peso
SELECT m.nombre AS nombre_movimiento,
		p.nombre AS nombre_pokemon,
		AVG(p.peso) AS peso_promedio
FROM movimiento AS m
	INNER JOIN tipo AS t
	ON m.id_tipo = t.id_tipo
	INNER JOIN tipo_ataque AS ta
	ON t.id_tipo_ataque = ta.id_tipo_ataque
	INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
	INNER JOIN pokemon AS p
	ON pt.numero_pokedex = p.numero_pokedex
WHERE t.nombre = 'Agua'
GROUP BY m.nombre, p.nombre;

#otra forma paso 1
SELECT *
FROM movimiento AS m
INNER JOIN pokemon_tipo AS pt
ON pt.id_tipo = m.id_tipo
INNER JOIN pokemon AS p
ON p.numero_pokedex = pt.numero_pokedex;

#paso 2, me muestra por caad movimiento el pokemon que va a poder aprender que y cual tipo de movimiento
SELECT m.nombre AS movimiento,
		p.nombre AS pokemon
FROM movimiento AS m
INNER JOIN pokemon_tipo AS pt
ON pt.id_tipo = m.id_tipo
INNER JOIN pokemon AS p
ON p.numero_pokedex = pt.numero_pokedex;

#paso 3, me esta pidiendo el tipo tengo que hacer la relacion con la tabla tipo, y da igual en que pocision hago el join
SELECT m.nombre AS movimiento,
		p.nombre AS pokemon,
        t.nombre AS tipo
FROM movimiento AS m
INNER JOIN tipo AS t
ON t.id_tipo = m.id_tipo
INNER JOIN pokemon_tipo AS pt
ON pt.id_tipo = m.id_tipo
INNER JOIN pokemon AS p
ON p.numero_pokedex = pt.numero_pokedex;

#paso 4, nos pide que mostremos el tipo agua con el peso del pokemon
SELECT m.nombre AS movimiento,
		p.nombre AS pokemon,
        t.nombre AS tipo,
        peso
FROM movimiento AS m
INNER JOIN tipo AS t
ON t.id_tipo = m.id_tipo
INNER JOIN pokemon_tipo AS pt
ON pt.id_tipo = m.id_tipo
INNER JOIN pokemon AS p
ON p.numero_pokedex = pt.numero_pokedex
WHERE t.nombre= 'Agua';