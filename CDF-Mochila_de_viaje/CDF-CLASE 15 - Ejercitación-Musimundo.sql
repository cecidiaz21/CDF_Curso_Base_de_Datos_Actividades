/* CLASE 15. Ejercitación consultas - Bases de datos
Consultas de base de datos Musimundos JOIN
Consignas Consultas
SELECT, GROUP BY y JOIN
*/
#1 - Listar las canciones cuya duración sea mayor a 2 minutos.
SELECT *
FROM canciones;

SELECT *
FROM canciones
WHERE milisegundos >= 120000;

SELECT c.id, c.nombre, c.milisegundos,
	 c.milisegundos /60000.0 AS duracion_minutos
FROM canciones AS c
WHERE milisegundos/60000.0 >= 2;

#2 - Listar las canciones cuyo nombre comience con una vocal. 
SELECT *
FROM canciones
WHERE nombre LIKE 'a%';

#3 - Canciones
	#a - Listar las canciones ordenadas por compositor en forma descendente.
    SELECT *
	FROM canciones
	ORDER BY compositor DESC;

	#b - Luego, por nombre en forma ascendente. Incluir únicamente aquellas canciones que tengan compositor. 
	SELECT *
	FROM canciones
	WHERE compositor IS NOT NULL AND compositor != ''
	ORDER BY compositor ASC;
        
#4 - Canciones
	#a - Listar la cantidad de canciones de cada compositor. 
    SELECT compositor,
	       COUNT(*) AS canciones_por_compositor
	FROM canciones
    WHERE compositor IS NOT NULL AND compositor != ''
    GROUP BY compositor
	ORDER BY compositor ASC;
        
	#b - Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. 
    SELECT compositor,
	       COUNT(*) AS canciones_por_compositor
	FROM canciones
	WHERE compositor IS NOT NULL AND compositor != '' 
    GROUP BY compositor
    HAVING canciones_por_compositor >= 10
    #para filtrar los resultados basados en la cantidad de canciones por compositor.
	ORDER BY canciones_por_compositor DESC;
    
#5 - Facturas
	#a - Listar el total facturado agrupado por ciudad.
    SELECT *
    FROM facturas;
    
    SELECT total, ciudad_de_facturacion
    FROM facturas;
    
	SELECT total, ciudad_de_facturacion
    FROM facturas
    ORDER BY ciudad_de_facturacion;
    #entonces no debo seleccionar la columna del total, solo la de ciudad_de_facturacion
    #ahi tengo que crear una nueva columna donde sume el total facturado por ciudad
    #despues agrupo por ciudad y ordeno por ciudad de facturacion
    SELECT ciudad_de_facturacion, SUM(total) AS total_facturado_por_ciudad			
    FROM facturas
    GROUP BY ciudad_de_facturacion
    ORDER BY ciudad_de_facturacion;
    
	#b - Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
    SELECT pais_de_facturacion, ciudad_de_facturacion, 
			SUM(total) AS total_facturado_por_ciudad			
    FROM facturas
    GROUP BY pais_de_facturacion, ciudad_de_facturacion
    ORDER BY pais_de_facturacion, ciudad_de_facturacion;
    
    SELECT pais_de_facturacion, ciudad_de_facturacion, 
			SUM(total) AS total_facturado_por_ciudad			
    FROM facturas
    WHERE pais_de_facturacion = 'Canada' #filtro por Canada
    GROUP BY pais_de_facturacion, ciudad_de_facturacion #agrupo las dos columnas
    ORDER BY pais_de_facturacion; #Ordeno solo por pais
    
	#c - Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
    SELECT ciudad_de_facturacion, SUM(total) AS total_facturado_por_ciudad			
    FROM facturas
    GROUP BY ciudad_de_facturacion
    HAVING total_facturado_por_ciudad > 38
    ORDER BY ciudad_de_facturacion;
    
	#d - Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
    SELECT pais_de_facturacion, SUM(total) AS total_facturado_por_pais			
    FROM facturas
    GROUP BY pais_de_facturacion
    ORDER BY pais_de_facturacion;
    
#6 - Canciones / Géneros
	#a - Listar la duración mínima, máxima y promedio de las canciones.
    SELECT *
    FROM canciones;
    
    SELECT nombre, milisegundos,
		MIN(milisegundos) AS duracion_minima,
        MAX(milisegundos) AS duracion_maxima, 
        AVG(milisegundos) AS promedio_duracion
    FROM canciones;
#    HAVING MIN(duracion_minutos) MAX(duracion_minutos) AVG(duracion_minutos);
    
	#b - Modificar el punto (a) mostrando la información agrupada por género.
    SELECT g.nombre AS genero,
		MIN(c.milisegundos) AS duracion_minima,
        MAX(c.milisegundos) AS duracion_maxima, 
        AVG(c.milisegundos) AS promedio_duracion
    FROM canciones AS c
    LEFT JOIN generos AS g
    On g.id = c.id_genero
    GROUP BY g.nombre;

