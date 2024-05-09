##CLASE 15. Bases de datos. Consultas de base de datos EMarket. ALTER.
/*Consultas queries XL parte III - Tipos de JOIN
En esta tercer parte vamos a intensificar la práctica de consultas con tipos de JOIN.
Tip:
Recuerda hacer la ingeniería inversa a la base de datos para tener una mejor guía de las relaciones entre tablas
Reportes parte I - Repasamos INNER JOIN
Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
Id de la factura
fecha de la factura
nombre de la empresa de correo
nombre del cliente
categoría del producto vendido
nombre del producto
precio unitario
cantidad */

## Reportes parte I - Repasamos INNER JOIN
USE emarket;
SELECT c.ClienteID, c.Contacto,
f.NroFactura, f.FechaFactura, f.NombreEnvio, 
p.ProductoID, p.ProductoNombre, fd.PrecioUnitario, f.NombreEnvio, 
p.CategoriaID
FROM facturadetalle as fd
JOIN facturas AS f
ON  f.NroFactura = fd.FacturaID
INNER JOIN productos AS p
ON p.ProductoID = fd.ProductoID
INNER JOIN clientes AS c
ON c.ClienteID = f.ClienteID;
 
##Reportes parte II - INNER, LEFT Y RIGHT JOIN

#1- Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.
USE emarket;
SELECT *
FROM productos;
USE emarket;
SELECT p.ProductoID, p.CategoriaID, p.ProductoNombre, p.CantidadPorUnidad, 
		p.PrecioUnitario, p.UnidadesStock, p.UnidadesPedidas
FROM productos AS p
WHERE p.CantidadPorUnidad >= 0;

#2- Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.
SELECT c.ClienteID, c.Contacto, c.Titulo, c.Direccion, c.Compania, c.Ciudad,
p.UnidadesPedidas
FROM facturadetalle as fd
JOIN facturas AS f
ON  f.NroFactura = fd.FacturaID
INNER JOIN productos AS p
ON p.ProductoID = fd.ProductoID
INNER JOIN clientes AS c
ON c.ClienteID = f.ClienteID
WHERE p.UnidadesPedidas = 0;

#3- Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor. 
#Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.
SELECT  p.CategoriaID, p.ProductoNombre, 
		pr.Contacto
FROM productos AS p
JOIN proveedores AS pr
ON p.ProveedorID = pr.ProveedorID;
#WHERE pr.Contacto BETWEEN IS NULL AND pr.Contacto = ' '; ERROR

SELECT  p.ProductoNombre, p.CategoriaID,
    COALESCE(pr.Contacto, 'Proveedor no especificado') AS ContactoProveedor 
#nos permite mostrar la información de contacto del proveedor (pr.Contacto), pero en caso de que el proveedor no esté especificado (es decir, pr.Contacto sea NULL), mostrará el texto 'Proveedor no especificado'.
FROM productos AS p
LEFT JOIN proveedores AS pr ON p.ProveedorID = pr.ProveedorID;
# utilizamos left join para asegurarnos de incluir todos los productos de la tabla productos (p), 
#incluso si no tienen una correspondencia en la tabla proveedores (pr).

#4- Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT *
FROM categorias;

SELECT c.CategoriaID, c.CategoriaNombre, 
		AVG(p.PrecioUnitario) AS precioUnitarioPromedio
FROM categorias AS c
LEFT JOIN productos AS p
#Utilizamos LEFT JOIN para asegurarnos de incluir todas las categorías, incluso si no tienen productos asociados en la tabla productos.
ON  p.CategoriaID = c.CategoriaID
GROUP BY c.CategoriaID, c.CategoriaNombre;
# para que el promedio se calcule para cada categoría y xq la funcion AVG lo necesita

#5- Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.
USE emarket;
SELECT  c.ClienteID, c.Contacto,
	MAX(f.FechaFactura) AS UltimaFechaFactura,
    # para obtener la última fecha de factura para cada cliente. Esto nos da la última factura de compra para cada cliente. 
	COALESCE(SUM(fd.Cantidad), 0) AS CantidadCompra
    #  
FROM clientes AS c
LEFT JOIN facturas AS f
ON c.ClienteID = f.ClienteID
LEFT JOIN facturadetalle AS fd
ON fd.FacturaID = f.NroFactura
GROUP BY c.ClienteID, c.Contacto
ORDER BY UltimaFechaFactura DESC;

#6- Todas las facturas tienen una empresa de correo asociada (enviovia). 
#Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes. 
#Realizar la consulta utilizando RIGHT JOIN.
USE emarket;
SELECT  c.CorreoID, c.Compania,
        COUNT(f.EnvioVia) AS CantidadFacturas
        #count o sum? count xq queremos contar registros dentro de un grupo en SQL. sum es para sumar valores de una columna especifica
FROM correos AS c
RIGHT JOIN facturas AS f
ON c.CorreoID = f.EnvioVia
GROUP BY c.CorreoID, c.Compania;

