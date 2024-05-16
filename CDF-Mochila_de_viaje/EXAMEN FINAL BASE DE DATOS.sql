/* EXAMEN FINAL BASE DE DATOS
Consultas a la Base de datos Pokemon */

#Where
#1- Mostrar el nombre, altura y peso de los Pokémon cuya altura sea menor a 0.5.
#Tablas: pokemon
#Campos: nombre, peso, altura
SELECT nombre, peso, altura
FROM pokemon
WHERE PESO < 0.5;

#2- Mostrar los nombre, descripcion, potencia y precisión de los movimientos cuya potencia esté entre 70 y 100, la precisión sea mayor igual a 80.
#Tablas: movimiento
#Campos: nombre, descripcion, potencia, precision_mov
SELECT nombre, descripcion, potencia, precision_mov
FROM movimiento
WHERE potencia BETWEEN 70 AND 100 AND precision_mov >= 80;

#Operadores & joins
# 1- Mostrar los nombres y potencia de los movimientos que tienen una potencia entre 50 y 80, junto con el nombre del tipo al que pertenecen.
#Tablas: movimiento, tipo
#Campos: m.nombre, t.nombre, potencia
SELECT m.nombre AS ataque, t.nombre AS tipo, potencia
FROM movimiento AS m
INNER JOIN tipo AS t 
ON m.id_tipo = t.id_tipo
WHERE potencia BETWEEN 50 AND 80;

# 2- Mostrar nombre, potencia y tipo de los movimientos que tienen un tipo de ataque "Físico" y una precisión mayor a 85.
#Tablas: tipo, tipo_ataque, movimiento
#Campos: m.nombre, m.potencia, m.precision_mov, ta.tipo
SELECT m.nombre, m.potencia, m.precision_mov, ta.tipo
FROM tipo AS t
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
INNER JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
WHERE ta.tipo LIKE 'Fisico' AND m.precision_mov > 85;

#Order by
# 1- Mostrar los nombres y números de Pokédex de los Pokémon en orden descendiente según su número de Pokédex.
#Tablas: pokemon
#Campos: numero_pokedex, nombre
SELECT numero_pokedex, nombre
FROM pokemon
ORDER BY numero_pokedex DESC;

# 2- Mostrar numero de pokedex, nombre y altura de los Pokémon de tipo "Roca", ordenados por altura de forma ascendente.
#Tablas: pokemon, pokemon_tipo, tipo
#Campos: numero_pokedex, nombre, altura
SELECT p.numero_pokedex, p.nombre, p.altura,
		t.nombre
FROM pokemon AS p
INNER JOIN pokemon_tipo  AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
WHERE t.nombre LIKE 'Roca'
ORDER BY p.altura ASC;

#Funciones de agregación
# 1- ¿Cuántos Pokémon tienen una defensa superior a 100?
#Tablas: estadisticas_base
#Campos: defensa
SELECT COUNT(*) AS total_pokemon
FROM estadisticas_base
WHERE defensa >100;

# 2- ¿Cuál es la potencia promedio de todos los movimientos en la base de datos? 
#¿Cuáles son los valores máximos y mínimos de la potencia?
#Tablas: movimiento
#Campos: potencia
SELECT 
	ROUND(AVG(potencia), 1) AS potencia_promedio,
	MIN(potencia) AS potencia_min, MAX(potencia) AS potencia_max
FROM movimiento;

# Group by
# 1- Muestra los nombres de los tipos de Pokémon junto con la velocidad promedio de los Pokémon de cada tipo.
#Tablas: estadisticas_base, pokemon_tipo, tipo
#Campos: t.nombre, eb.velocidad
SELECT t.nombre AS tipo_pokemon, 
		ROUND(AVG(eb.velocidad), 1) AS prom_velocidad
FROM estadisticas_base AS eb
INNER JOIN pokemon_tipo AS pt
ON eb.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
GROUP BY tipo_pokemon;

# 2-Muestra los nombres de los tipos de Pokémon junto con la potencia máxima de movimientos de cualquier tipo que tienen una potencia superior a 80.
#Tablas: movimiento, tipo
#Campos: t.nombre, m.potencia
SELECT t.nombre AS tipo_pokemon, 
		MAX(m.potencia) AS potencia_max
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
WHERE m.potencia > 80
GROUP BY t.nombre; 

#Having
# 1- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una precisión promedio mayor a 80 en sus movimientos.
#Tablas: tipo, pokemon_tipo, movimiento
#Campos: t.nombre, m.precision_mov
SELECT t.nombre AS tipo_pokemon, 
		COUNT(pt.numero_pokedex) AS cantidad_pokemon,
        ROUND(AVG(m.precision_mov),1) AS precision_promedio        
FROM movimiento AS m 
INNER JOIN tipo AS t
ON t.id_tipo = m.id_tipo
INNER JOIN pokemon_tipo  AS pt
ON pt.numero_pokedex = t.id_tipo
GROUP BY t.nombre
HAVING precision_promedio > 80;

# 2- Muestra los nombres de los Pokémon que tienen un promedio de ataque superior a 70 y más de un tipo.
#Tablas: pokemon, pokemon_tipo, estadisticas_base
#Campos: p.nombre, eb.ataque, pt.id_tipo
SELECT p.nombre AS pokemon, 
		ROUND(AVG(eb.ataque),1) AS promedio_ataque, 
        COUNT(pt.id_tipo) AS cantidad_de_tipo
FROM estadisticas_base AS eb
INNER JOIN pokemon_tipo AS pt
ON eb.numero_pokedex = pt.numero_pokedex
INNER JOIN pokemon AS p
ON p.numero_pokedex = eb.numero_pokedex
GROUP BY pokemon
HAVING promedio_ataque > 70 AND cantidad_de_tipo >1;

#Registros
# 1- Muestra el nombre de cada Pokémon junto con su tipo y velocidad base. Ordena los resultados por el nombre del Pokémon en orden descendente.
#Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
#Campos: p.nombre, t.nombre, eb.velocidad
SELECT p.nombre AS pokemon, 
		t.nombre AS tipo, 
        eb.velocidad
FROM pokemon AS p
INNER JOIN estadisticas_base AS eb 
ON p.numero_pokedex = eb.numero_pokedex 
INNER JOIN pokemon_tipo AS pt 
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t 
ON pt.id_tipo = t.id_tipo
ORDER BY pokemon DESC;

# 2- Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 60 
#y una precisión promedio mayor a 85 en sus movimientos.
#Tablas: movimiento, pokemon_tipo, tipo, estadisticas_base, pokemon 
#Campos: t.nombre
SELECT t.nombre AS tipo,
		COUNT(DISTINCT p.nombre) AS cantidad_pokemon,
		ROUND(AVG(eb.velocidad),1) AS velocidad_promedio,
        ROUND(AVG(precision_mov),1) AS precision_promedio
FROM pokemon AS p
INNER JOIN estadisticas_base AS eb 
ON p.numero_pokedex = eb.numero_pokedex 
INNER JOIN pokemon_tipo AS pt 
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t 
ON pt.id_tipo = t.id_tipo
INNER JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
GROUP BY t.nombre
HAVING velocidad_promedio > 60  AND precision_promedio > 85;

# 3- Muestra los nombres de los movimientos de tipo "Fuego" junto con los nombres de los Pokémon que pueden aprenderlos y su altura. 
#Solo incluye los movimientos con una potencia mayor a 50.
#Tablas: movimiento, pokemon_tipo, tipo, pokemon
#Campos: m.nombre, p.nombre, p.altura
SELECT m.nombre AS nombre_movimiento, 
		p.nombre AS pokemon, 
        p.altura,
        t.nombre AS tipo_ataque,
        m.potencia AS potencia
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt 
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t 
ON pt.id_tipo = t.id_tipo
INNER JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
WHERE t.nombre LIKE 'Fuego' AND m.potencia > 50;