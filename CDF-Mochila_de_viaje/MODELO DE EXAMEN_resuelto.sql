/* MODELO EXAMEN FINAL
 - Bases de datos
Consultas a la Base de datos Pokemon
EJERCICIOS
*/
## Where
#1- Mostrar el nombre, peso y altura de los pokémon cuyo peso sea mayor a 150. Tablas: pokemon. Campos: nombre, peso, altura.
SELECT *
FROM pokemon
WHERE peso > 150;

#2- Muestra los nombres y potencias de los movimientos que tienen una precisión mayor 90. Tablas: movimiento. Campos: m.nombre, potencia.
SELECT nombre, potencia, precision_mov
FROM movimiento
WHERE precision_mov > 90;

## Operadores & joins
#1- Mostrar tipo, nombre y potencia de los movimientos que tienen una potencia mayor igual que 120. 
#Tablas: movimiento, tipo. Campos: t.nombre, m.nombre, m.potencia.
SELECT m.nombre AS nombre,
		m.potencia, 
		t.nombre AS tipo
FROM movimiento AS m
JOIN tipo AS t
ON m.id_tipo = t.id_tipo
WHERE m.potencia > 120;

#2- Muestra los nombres de los tipos de Pokémon junto con sus tipos de ataque correspondientes de aquellos cuya potencia sea igual a 0. 
#Tablas: tipo, tipo_ataque, movimiento. Campos: t.nombre ta.tipo m.potencia.
SELECT t.nombre, 
		ta.tipo AS tipo_ataque,
        m.potencia
FROM tipo AS t
JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque 
JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
WHERE m.potencia = 0;

## Order by
#1- Muestra los nombres y números de Pokédex de los primeros 10 Pokémon en orden alfabético. Tablas: pokemon. Campos: numero_pokedex, nombre.


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
SELECT SUM(defensa)
FROM estadisticas_base;

#2- ¿Cuántos Pokémon tienen el tipo "Fuego"? tablas: pokemon_tipo, tipo. Campos:* 
SELECT COUNT(*) AS cantidad_pokemon_fuego
FROM pokemon_tipo AS pt
JOIN tipo AS t
ON pt.id_tipo = t.id_tipo
WHERE nombre LIKE 'Fuego';

##Group by
#1- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo.
#Tablas: pokemon_tipo, tipo. Campos: nombre, numero_pokedex.
SELECT t.nombre AS nombre_tipo_pokemon, COUNT(*) AS cantidad_pokemon
FROM pokemon_tipo AS pt
JOIN tipo AS t ON pt.id_tipo = t.id_tipo
GROUP BY t.nombre;

#2- Muestra los nombres de los tipos de Pokémon junto con el promedio de peso de los Pokémon de cada tipo. 
#Ordena los resultados de manera descendente según el promedio de peso. Tablas: pokemon, pokemon_tipo, tipo. Campos: t.nombre, p.peso
SELECT t.nombre,
		AVG(p.peso) AS promedio_peso
FROM tipo AS t
JOIN pokemon_tipo AS pt
ON t.id_tipo = pt.id_tipo 
JOIN pokemon AS p
ON pt.numero_pokedex = p.numero_pokedex
GROUP BY t.nombre
ORDER BY promedio_peso DESC;

##Having
#1- Muestra los nombres de los Pokémon que tienen más de un tipo. Tablas: pokemon, pokemon_tipo. Campos: nombre.
SELECT p.nombre
FROM pokemon AS p
JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
GROUP BY nombre
HAVING COUNT(nombre) != 1;

#2- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen un peso promedio mayor a 10. 
#Tablas: pokemon, pokemon_tipo, tipo. Campos: nombre, numero_pokedex.
SELECT p.nombre, pt.numero_pokedex
FROM pokemon AS p
JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
GROUP BY p.nombre, pt.numero_pokedex
HAVING AVG(peso) >= 10;

## Funciones de alteración
#1- Muestra los nombres de los movimientos de tipo de ataque "Especial" con una potencia superior a 10 y una desc que contenga al menos 20 palabras.
#Tablas: movimiento, tipo_ataque. Campos: nombre, potencia, tipo, descripcion
SELECT m.nombre, m.potencia,
		ta.tipo,
        SUBSTRING(m.descripcion, 20) AS descripcion_breve
FROM movimiento AS m
JOIN tipo AS t
ON m.id_tipo = t.id_tipo
JOIN tipo_ataque AS ta
ON ta.id_tipo_ataque = t.id_tipo_ataque
WHERE ta.tipo LIKE "Especial" AND m.potencia >= 10;

#2- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 80. 
# Solo incluye tipos que tienen al menos 3 Pokémon con esas características. Tablas: tipo, pokemon_tipo, estadisticas_base. Campos: t.nombre, *
SELECT t.nombre, 
		COUNT(t.nombre) AS cantidad_pokemon_x_nombre,
		AVG(eb.velocidad) AS velocidad_promedio
FROM tipo AS t
JOIN pokemon_tipo AS pt
ON t.id_tipo = pt.id_tipo
JOIN pokemon AS p
ON p.numero_pokedex = pt.numero_pokedex
JOIN estadisticas_base AS eb
On eb.numero_pokedex = p.numero_pokedex
GROUP BY t.nombre
HAVING velocidad_promedio > 80 AND cantidad_pokemon_x_nombre >3;

##Registros
#1- Muestra el nombre de cada Pokémon junto con su tipo, velocidad base y puntos de salud (PS) base. Ordena los rdos por la vel base de forma desc. 
# Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo. Campos: p.nombre, t.nombre, eb.velocidad, eb.ps.
SELECT p.nombre, t.nombre AS tipo_pokemon,
		eb.velocidad, eb.ps AS puntos_salud
FROM pokemon_tipo AS pt
JOIN pokemon AS p
ON pt.numero_pokedex = p.numero_pokedex
JOIN estadisticas_base AS eb
ON eb.numero_pokedex = p.numero_pokedex
JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
ORDER BY eb.velocidad DESC;

#2- Muestra los nombres de los movimientos de tipo "Agua" junto con los nombres de los Pokémon que pueden aprenderlos y el peso promedio de estos
#Pokémon. Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon. campos: m.nombre, p.nombre, peso
SELECT m.nombre AS nombre_movimiento,
		p.nombre AS nombre_pokemon,
		AVG(p.peso) AS peso_promedio
FROM movimiento AS m
JOIN tipo AS t
ON m.id_tipo = t.id_tipo
JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
JOIN pokemon_tipo AS pt
ON t.id_tipo = pt.id_tipo
JOIN pokemon AS p
ON pt.numero_pokedex = p.numero_pokedex
WHERE t.nombre = 'Agua'
GROUP BY m.nombre, p.nombre;

