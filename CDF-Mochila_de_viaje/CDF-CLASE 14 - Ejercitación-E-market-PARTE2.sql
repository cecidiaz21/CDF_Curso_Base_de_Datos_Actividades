#Consultas queries XL parte I - GROUP BY
#Vamos a practicar sobre consultas SELECT, enfocándonos en group by, having y distinct.
#Tips:
#Cada enunciado se corresponde con una consulta SELECT.
#Recordá ir guardando las consultas. SQL.

#Consignas
#1- Clientes
SELECT * 
FROM clientes;

#2- ¿Cuántos clientes existen? 
SELECT COUNT(*) AS total_clientes_existentes
FROM clientes;

#3- ¿Cuántos clientes hay por ciudad? 
SELECT Ciudad, COUNT(ClienteID) AS CantidadClientes
FROM clientes
GROUP BY Ciudad;

#Facturas
SELECT * 
FROM facturas;
#4- ¿Cuál es el total de transporte?
SELECT COUNT(Transporte) AS total_transporte_facturas
FROM facturas;

#5- ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
SELECT EnvioVia, COUNT(Transporte) AS Total_transp_por_EnvioVia
FROM facturas
GROUP BY EnvioVia;

#6- Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.
SELECT ClienteID, COUNT(NroFactura) AS Total_facturas_por_Cliente
FROM facturas
GROUP BY ClienteID
ORDER BY Total_facturas_por_Cliente DESC;

#7- Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
SELECT ClienteID, COUNT(NroFactura) AS Total_facturas_por_Cliente
FROM facturas
GROUP BY ClienteID
ORDER BY Total_facturas_por_Cliente DESC
LIMIT 5;

#8- ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
SELECT PaisEnvio, COUNT(NroFactura) AS Total_facturas_por_PaisEnvio
FROM facturas
GROUP BY PaisEnvio
ORDER BY Total_facturas_por_PaisEnvio ASC;

#9- Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?
SELECT EmpleadoID, COUNT(NroFactura) AS Total_Ventas_Empleado
FROM facturas
GROUP BY EmpleadoID
ORDER BY Total_Ventas_Empleado DESC;

#Factura detalle
SELECT *
FROM facturadetalle;
SELECT *
FROM productos;

#10- ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
#TABLE REFERENCE
SELECT facturadetalle.FacturaID, facturadetalle.ProductoID, productos.ProductoID, productos.ProductoNombre
FROM facturadetalle, productos
WHERE facturadetalle.ProductoID = productos.ProductoID;

#crear alias
SELECT fd.FacturaID, fd.ProductoID, p.ProductoID
FROM facturadetalle AS fd, productos AS p
WHERE fd.ProductoID = p.ProductoID;

#hacer la tabla de referencia, reemplazo en g.id x nombre, cambio la tabla
SELECT fd.cantidad, p.ProductoNombre
FROM facturadetalle AS fd, productos AS p
WHERE fd.ProductoID = p.ProductoID
GROUP BY p.ProductoNombre;
#VER COMO COLOCAR CANTIDAD POR PRODUCTO

#JOIN
#la sintaxis es mas clara y nos libera el WHERE
SELECT fd.FacturaID, fd.cantidad, p.ProductoNombre
FROM facturadetalle AS fd
INNER JOIN productos AS p
ON fd.ProductoID = p.ProductoID
GROUP BY ProductoNombre;

#11- ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.
SELECT SUM(PrecioUnitario * Cantidad) AS TotalFacturado
FROM facturadetalle;

#12- ¿Cuál es el total facturado para los productos ID entre 30 y 50?
SELECT ProductoID, SUM(PrecioUnitario * Cantidad) AS TotalFacturado
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 40
GROUP BY ProductoID;

#13- ¿Cuál es el precio unitario promedio de cada producto?
SELECT p.ProductoID,
       p.ProductoNombre,
       AVG(fd.PrecioUnitario) AS PrecioUnitarioPromedio
FROM facturadetalle AS fd
INNER JOIN productos AS p 
ON fd.ProductoID = p.ProductoID
GROUP BY p.ProductoID, p.ProductoNombre;

/*Consultas queries XL parte II - JOIN
En esta segunda parte vamos a intensificar la práctica de consultas con JOIN.
Tip: Recuerda hacer la ingeniería inversa a la base de datos para tener una mejor guía de las relaciones entre tablas. */

#1- Generar un listado de todas las facturas del empleado 'Buchanan'.
SELECT  e.Nombre, 
        e. Apellido,
        f.NroFactura 
FROM empleados AS e
INNER JOIN facturas AS f
ON e.EmpleadoID = f.EmpleadoID
WHERE e.Apellido LIKE 'Buchanan';

#2- Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
SELECT f.*, c.Compania
FROM facturas AS f
INNER JOIN correos AS c 
ON c.CorreoID = f.EnvioVia
WHERE Compania LIKE 'Speedy Express';

#3- Generar un listado de todas las facturas con el nombre y apellido de los empleados.
SELECT f.NroFactura, f.ClienteID, 
		f.FechaFactura, f.FechaEnvio, 
        e.Nombre, e.Apellido
FROM facturas AS f
INNER JOIN empleados AS e
ON e.EmpleadoID = f.EmpleadoID;

#4- Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
SELECT f.NroFactura, f.ClienteID, 
		f.FechaFactura, f.FechaEnvio, 
        f.PaisEnvio, c.Compania, c.Titulo        
FROM facturas AS f
INNER JOIN clientes as c
ON c.ClienteID = f.ClienteID
WHERE PaisEnvio LIKE 'USA' AND c.Titulo LIKE 'Owner';

#5- Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
SELECT  f.*, 
        e.Nombre, e.Apellido,
        fd.ProductoID
FROM empleados AS e
INNER JOIN facturas AS f
ON e.EmpleadoID = f.EmpleadoID
INNER JOIN facturadetalle AS fd
ON fd.FacturaID = f.NroFactura
WHERE e.Apellido LIKE 'Leverling' AND fd.ProductoID LIKE '42';

#6- Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.
SELECT  f.*, 
        e.Nombre, e.Apellido,
        fd.ProductoID
FROM empleados AS e
INNER JOIN facturas AS f
ON e.EmpleadoID = f.EmpleadoID
INNER JOIN facturadetalle AS fd
ON fd.FacturaID = f.NroFactura
WHERE e.Apellido LIKE 'Leverling' AND fd.ProductoID LIKE '42' OR fd.ProductoID LIKE '80';

#7- Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
SELECT f.ClienteID, 
		fd.FacturaID, fd.PrecioUnitario, fd.Cantidad,
		(fd.PrecioUnitario * fd.Cantidad) AS ComprasTotales
FROM facturas AS f
INNER JOIN facturadetalle AS fd
ON fd.FacturaID = f.NroFactura
#GROUP BY f.ClienteID, (fd.PrecioUnitario * fd.Cantidad);
#LIMIT 5;

#8- Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.
SELECT f.ClienteID, 
		c.Contacto as NombreApellido, 
		f.FechaFactura, f.PaisEnvio, 		
        (fd.PrecioUnitario * fd.Cantidad) AS Total
FROM facturas AS f
INNER JOIN clientes AS c
ON c.ClienteID = f.ClienteID
INNER JOIN facturadetalle AS fd
ON fd.FacturaID = f.NroFactura
ORDER BY f.FechaFactura DESC
LIMIT 10;
