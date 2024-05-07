# Clase 11
# LIMIT 
# Los 5 productos más caros
SELECT * FROM productos
ORDER BY preciounitario DESC
LIMIT 5;

# LIMIT + OFFSET 
# penultima y antepenultima empleado contratado 

SELECT nombre, fechacontratacion
FROM empleados
ORDER BY fechacontratacion DESC
LIMIT 2
OFFSET 1;


# ALIAS 
SELECT categorianombre AS Categoria 
FROM categorias;

SELECT productonombre AS nombre, (preciounitario * unidadesstock) AS total
FROM productos
ORDER BY total DESC;


# HAVING
 SELECT categoriaid, COUNT(*) AS total_productos,
 AVG (preciounitario) promedio_precio_unitario
 FROM productos
 GROUP BY categoriaid
 HAVING total_productos > 10
 AND promedio_precio_unitario  > 24;
 
 SELECT COUNT(*)
 FROM categorias;
 
SELECT categoriaid, COUNT(*) AS total_productos,
AVG (preciounitario) promedio_precio_unitario
FROM productos
WHERE categoriaid IS NOT NULL
GROUP BY categoriaid
HAVING total_productos > 10
AND promedio_precio_unitario  > 24
ORDER BY promedio_precio_unitario;