#SUB QUERY PARA RELACIONAR DOS TABLAS
SELECT ProductoNombre, 
	   CategoriaID,
	   (SELECT CategoriaID FROM categorias)
FROM productos;
#no funciona xq estoy vinculando todos los registros de una tabla con todos los registros de otra tabla, hace una relacion de todos con todos
#yo lo que quiero es hacer una categoria existente y que me la relacione con otra categoria especifica

SELECT ProductoNombre, 
	   CategoriaID,
	   (SELECT CategoriaID 
       FROM categorias
       WHERE CategoriaID = CategoriaID)
FROM productos;
#aca tb hay un error xq no pueden tener el mismo nombre, toma el de arriba de la tabla de productos y el de abajo es de la tabla de productos, x eso debemos especificar

SELECT ProductoNombre, 
	   CategoriaID,
	   (SELECT CategoriaID 
       FROM categorias 
       WHERE categorias.CategoriaID = productos.CategoriaID) AS categoria #completar
FROM productos;


SELECT ProductoNombre, 
	   CategoriaID,
	   (SELECT CategoriaID 
       FROM categorias AS c
       WHERE c.CategoriaID = p.CategoriaID) AS categoria #completar
FROM productos AS p;

# SUB QUERY SELECT + WHERE
SELECT ProductoID, #de la tabla de producto
		(SELECT productoNombre
        FROM productos AS p
        WHERE p.ProductoID = fd.ProductoID) AS producto
FROM  facturadetalle AS fd
GROUP BY ProductoID;

#CONSULTAS A MAS DE UNA TABLA
# hay q buscar cual es la relacion que existe entre las dos tablas, donde esta la relacion? EJEMPLO DE TEORIA
SELECT clientes.id AS ID, clientes.nombre, ventas.fecha
FROM clientes, ventas #aca hace una relacion cartesiana relacionando una tabla con otra
WHERE clientes.id = ventas.cliente_id;

#TABLE REFERENCE
SELECT * FROM productos;

SELECT * FROM productos AS p, proveedores AS pee;

SELECT ProductoNombre, contacto
FROM productos AS p, proveedores AS pee
WHERE p.ProveedorID = pee.ProveedorID;

SELECT ProductoNombre, contacto, CategoriaNombre AS categoria
FROM productos AS p, 
	 proveedores AS pee,
     categorias AS c
WHERE p.ProveedorID = pee.ProveedorID
AND p.CategoriaID = c.CategoriaID;

SELECT CategoriaNombre AS categorias, SUM(PrecioUnitario)
FROM productos AS p, 
	 proveedores AS pee,
     categorias AS c
WHERE p.ProveedorID = pee.ProveedorID
AND p.CategoriaID = c.CategoriaID
GROUP BY categorias;
#lo que mas vamos a estar usando en un empleo de analisis de datos, la mejor forma de analizarlo seria JOINT 