USE Ventas_tech_db;
GO

--Consulta 1 Total facturado agrupado por mes
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad_vendida * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    ROUND(SUM(cantidad_vendida * precio_unitario) / COUNT(*), 2) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

--Consulta 2 top 5 facturado
SELECT TOP 5
    id_producto,
    SUM(cantidad_vendida) AS unidades_vendidas,
    SUM(cantidad_vendida * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

--Consulta 3 clientes regulares, mostrando cuánto gastó
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad_vendida * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--consulta 4 ver cuando tuve desvíos del promedio del ticket
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad_vendida * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad_vendida * precio_unitario)
             >= AVG(SUM(cantidad_vendida * precio_unitario)) OVER ()
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_vs_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

--Hallazgos:
--El producto 1 Laptop Pro, es el de mayor facturación, generando 3600 de ventas
--Todos los clientes realizaron hicieron 2 pedidos cada uno.
--La categoría de computación es la que concentra la mayor parte de la facturación
