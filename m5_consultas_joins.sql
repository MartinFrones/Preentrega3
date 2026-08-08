--Según Ticher, tengo que adaptar las tablas
CREATE DATABASE RetailPro_DB_entrega5;
GO

USE RetailPro_DB_entrega5;
GO

-- Eliminar tablas si existen

DROP TABLE IF EXISTS Ventas_entrega5;
DROP TABLE IF EXISTS Tabla_Productos_entrega5;
DROP TABLE IF EXISTS Tabla_Clientes_entrega5;
DROP TABLE IF EXISTS Tabla_Categorias_entrega5;
DROP TABLE IF EXISTS Tabla_Territorios_entrega5;
GO

-- TABLA TERRITORIOS

CREATE TABLE Tabla_Territorios_entrega5(
    id_territorio INT PRIMARY KEY,
    nombre_region VARCHAR(50) NOT NULL
);


CREATE TABLE Tabla_Clientes_entrega5(
    id_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    mail_cliente VARCHAR(100) UNIQUE,
    segmento VARCHAR(50),
    fecha_registro DATE NOT NULL,
    id_territorio INT,

    CONSTRAINT fk_clientes_territorios
        FOREIGN KEY (id_territorio)
        REFERENCES Tabla_Territorios_entrega5(id_territorio)
);


CREATE TABLE Tabla_Categorias_entrega5(
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);


CREATE TABLE Tabla_Productos_entrega5(
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    precio_producto DECIMAL(10,2),

    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES Tabla_Categorias_entrega5(id_categoria)
);



CREATE TABLE Ventas_entrega5(
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    canal VARCHAR(20),

    CONSTRAINT fk_ventas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES Tabla_Clientes_entrega5(id_cliente),

    CONSTRAINT fk_ventas_productos
        FOREIGN KEY (id_producto)
        REFERENCES Tabla_Productos_entrega5(id_producto)
);

-- DATOS DE TERRITORIOS

INSERT INTO Tabla_Territorios_entrega5 VALUES (1, 'Norte');
INSERT INTO Tabla_Territorios_entrega5 VALUES (2, 'Sur');
INSERT INTO Tabla_Territorios_entrega5 VALUES (3, 'Este');
INSERT INTO Tabla_Territorios_entrega5 VALUES (4, 'Oeste');

-- DATOS DE CLIENTES

INSERT INTO Tabla_Clientes_entrega5 VALUES (1, 'María López', 'maria@mail.com', 'Corporativo', '2024-01-05', 1);
INSERT INTO Tabla_Clientes_entrega5 VALUES (2, 'Carlos Ruiz', 'carlos@mail.com', 'PyME', '2024-01-10', 2);
INSERT INTO Tabla_Clientes_entrega5 VALUES (3, 'Ana Gómez', 'ana@mail.com', 'Consumo Final', '2024-02-01', 3);
INSERT INTO Tabla_Clientes_entrega5 VALUES (4, 'Pedro Sanz', 'pedro@mail.com', 'Corporativo', '2024-02-15', 4);
INSERT INTO Tabla_Clientes_entrega5 VALUES (5, 'Laura Torres', 'laura@mail.com', 'PyME', '2024-03-01', 1);
INSERT INTO Tabla_Clientes_entrega5 VALUES (6, 'Juan Pérez', 'juan@mail.com', 'Consumo Final', '2024-03-20', 2);

-- DATOS DE CATEGORIAS

INSERT INTO Tabla_Categorias_entrega5 VALUES(1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO Tabla_Categorias_entrega5 VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO Tabla_Categorias_entrega5 VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO Tabla_Categorias_entrega5 VALUES (4, 'Almacenamiento', 'Discos y memorias');

-- DATOS DE PRODUCTOS

INSERT INTO Tabla_Productos_entrega5 VALUES (1, 'Laptop Pro 15', 1, 1200.00);
INSERT INTO Tabla_Productos_entrega5 VALUES (2, 'Mouse Inalámbrico', 2, 28.00);
INSERT INTO Tabla_Productos_entrega5 VALUES (3, 'Monitor 4K 27"', 1, 450.00);
INSERT INTO Tabla_Productos_entrega5 VALUES (4, 'Auriculares BT Pro', 3, 120.00);
INSERT INTO Tabla_Productos_entrega5 VALUES (5, 'SSD Externo 1TB', 4, 130.00);
INSERT INTO Tabla_Productos_entrega5 VALUES (6, 'Teclado Mecánico', 2, 95.00);
INSERT INTO Tabla_Productos_entrega5 VALUES (7, 'Webcam HD', 2, 80.00);

-- DATOS DE VENTAS

INSERT INTO Ventas_entrega5 VALUES (1, 1, 1, 2, 1200.00, '2024-03-05', 'Online');
INSERT INTO Ventas_entrega5 VALUES (2, 2, 2, 5, 28.00, '2024-03-06', 'Presencial');
INSERT INTO Ventas_entrega5 VALUES (3, 3, 3, 1, 450.00, '2024-03-07', 'Online');
INSERT INTO Ventas_entrega5 VALUES (4, 1, 4, 2, 120.00, '2024-03-08', 'Presencial');
INSERT INTO Ventas_entrega5 VALUES (5, 4, 5, 3, 130.00, '2024-03-10', 'Online');
INSERT INTO Ventas_entrega5 VALUES (6, 2, 6, 4, 95.00, '2024-03-11', 'Presencial');
INSERT INTO Ventas_entrega5 VALUES (7, 5, 1, 1, 1200.00, '2024-03-12', 'Online');
INSERT INTO Ventas_entrega5 VALUES (8, 3, 2, 8, 28.00, '2024-03-13', 'Presencial');
INSERT INTO Ventas_entrega5 VALUES (9, 4, 4, 1, 120.00, '2024-03-14', 'Online');
INSERT INTO Ventas_entrega5 VALUES (10, 5, 3, 2, 450.00, '2024-03-15', 'Presencial');

-- VERIFICACION

SELECT * FROM Tabla_Territorios_entrega5;
SELECT * FROM Tabla_Clientes_entrega5;
SELECT * FROM Tabla_Categorias_entrega5;
SELECT * FROM Tabla_Productos_entrega5;
SELECT * FROM Ventas_entrega5;

--Para agilizar, le pedí a Copilot que me genere datos con lo que ya tenía pero agregando las nuevas tablas de terriorio y demás

--Consulta 1
SELECT
    v.fecha_venta AS Fecha,
    c.nombre_cliente AS Cliente,
    c.segmento AS Segmento,
    t.nombre_region AS Region,
    p.nombre_producto AS Producto,
    cat.nombre_categoria AS Categoria,
    v.cantidad AS Cantidad,
    v.precio_unitario AS PrecioUnitario,
    (v.cantidad * v.precio_unitario) AS TotalVenta,
    v.canal AS Canal
FROM Ventas_entrega5 v
INNER JOIN Tabla_Clientes_entrega5 c
    ON v.id_cliente = c.id_cliente
INNER JOIN Tabla_Territorios_entrega5 t
    ON c.id_territorio = t.id_territorio
INNER JOIN Tabla_Productos_entrega5 p
    ON v.id_producto = p.id_producto
INNER JOIN Tabla_Categorias_entrega5 cat
    ON p.id_categoria = cat.id_categoria;

--Consulta 2 Cliente sin compras
SELECT
    c.nombre_cliente AS Cliente,
    c.mail_cliente AS Mail,
    c.fecha_registro AS FechaRegistro
FROM Tabla_Clientes_entrega5 c
LEFT JOIN Ventas_entrega5 v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

--consulta 3, productos sin venta
SELECT
    p.nombre_producto AS Producto,
    c.nombre_categoria AS Categoria,
    p.precio_producto AS Precio
FROM Tabla_Productos_entrega5 p
LEFT JOIN Ventas_entrega5 v
    ON p.id_producto = v.id_producto
INNER JOIN Tabla_Categorias_entrega5 c
    ON p.id_categoria = c.id_categoria
WHERE v.id_producto IS NULL;


--consulta 4, consolidado por canal
SELECT
    canal,
    SUM(TotalVenta) AS TotalPorCanal
FROM
(
    SELECT
        'Online' AS canal,
        (cantidad * precio_unitario) AS TotalVenta
    FROM Ventas_entrega5
    WHERE canal = 'Online'

    UNION ALL

    SELECT
        'Presencial' AS canal,
        (cantidad * precio_unitario) AS TotalVenta
    FROM Ventas_entrega5
    WHERE canal = 'Presencial'
) AS VentasConsolidadas
GROUP BY canal;
