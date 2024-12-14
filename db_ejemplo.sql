--Crear Base de datos
CREATE DATABASE db_ejemplo;

-- Tabla "clientes"
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT
);

-- Tabla "pedidos"
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    fecha_pedido DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20),
    productos TEXT
);


-- Datos para la tabla "clientes"
INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '1234567890', 'Calle 123'),
('María', 'Gómez', 'maria.gomez@example.com', '9876543210', 'Avenida 456'),
('Carlos', 'López', 'carlos.lopez@example.com', '5555555555', 'Plaza 789'),
('Ana', 'Martínez', 'ana.martinez@example.com', '1112223333', 'Calle Principal'),
('Luis', 'Rodríguez', 'luis.rodriguez@example.com', '4445556666', 'Avenida Secundaria'),
('Laura', 'Sánchez', 'laura.sanchez@example.com', '7778889999', 'Callejón 10'),
('Pedro', 'Ramírez', 'pedro.ramirez@example.com', '2223334444', 'Callejón 20'),
('Sofía', 'Hernández', 'sofia.hernandez@example.com', '5556667777', 'Callejón 30'),
('Miguel', 'Díaz', 'miguel.diaz@example.com', '8889990000', 'Callejón 40'),
('Elena', 'Flores', 'elena.flores@example.com', '1112223333', 'Callejón 50'),
('Isabel', 'Torres', 'isabel.torres@example.com', '4445556666', 'Callejón 60'),
('Pablo', 'García', 'pablo.garcia@example.com', '7778889999', 'Callejón 70'),
('Marta', 'Ruiz', 'marta.ruiz@example.com', '2223334444', 'Callejón 80'),
('Jorge', 'Fernández', 'jorge.fernandez@example.com', '5556667777', 'Callejón 90'),
('Lucía', 'Blanco', 'lucia.blanco@example.com', '8889990000', 'Callejón 100');

-- Datos para la tabla "pedidos"
INSERT INTO pedidos (id_cliente, fecha_pedido, total, estado, productos) VALUES
(1, '2024-11-20', 150.50, 'Enviado', 'Laptop, Auriculares'),
(2, '2024-11-18', 80.25, 'Procesando', 'Camiseta, Pantalón'),
(3, '2024-11-15', 230.75, 'Entregado', 'Smartphone, Cargador'),
(4, '2024-11-12', 55.99, 'Cancelado', 'Libro'),
(5, '2024-11-10', 120.00, 'Enviado', 'Mochila, Reloj'),
(1, '2024-12-28', 35.50, 'Entregado', 'Gafas de sol'),
(2, '2024-12-25', 99.99, 'Procesando', 'Zapatos'),
(3, '2024-12-20', 75.00, 'Enviado', 'Botella de agua'),
(4, '2024-12-18', 40.25, 'Entregado', 'Termo'),
(5, '2024-12-15', 18.99, 'Cancelado', 'Llavero'),
(1, '2024-12-30', 210.99, 'Enviado', 'Impresora'),
(2, '2024-10-28', 65.50, 'Entregado', 'Ratón'),
(3, '2024-10-25', 15.75, 'Procesando', 'Cable USB'),
(4, '2024-10-22', 89.99, 'Enviado', 'Teclado'),
(5, '2024-10-20', 30.00, 'Entregado', 'Altavoces');


select*from clientes;

select*from pedidos;

-- Consulta 1: Obtener todos los pedidos realizados por un cliente específico
SELECT p.id_pedido, c.nombre, c.apellido, p.fecha_pedido, p.total, p.estado, p.productos
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE c.email = 'juan.perez@example.com';

-- Consulta 2: Mostrar el total de pedidos por estado
SELECT estado, COUNT(*) AS total_pedidos, SUM(total) AS total_ventas
FROM pedidos
GROUP BY estado
ORDER BY total_ventas DESC;

-- Consulta 3: Listar los clientes que han realizado pedidos superiores a $100
SELECT DISTINCT c.id_cliente, c.nombre, c.apellido, SUM(p.total) AS total_gastado
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING SUM(p.total) > 100
ORDER BY total_gastado DESC;