CREATE DATABASE Distribuidora_RS;
USE Distribuidora_RS;


CREATE TABLE bitacoras (
    id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    transaccion VARCHAR(10) NOT NULL,
    usuario VARCHAR(40) NOT NULL,
    Host VARCHAR(40) DEFAULT NULL,
    fecha DATETIME NOT NULL,
    tabla VARCHAR(20) NOT NULL
);

CREATE TABLE Catalogo (
    Categoria INT PRIMARY KEY AUTO_INCREMENT,
    ID_Producto INT,
    Descripcion VARCHAR(100),
    PrecioProducto DOUBLE,
    Imagen VARCHAR(50)
);

CREATE TABLE Tiempo (
    ID_Tiempo INT PRIMARY KEY AUTO_INCREMENT,
    Fecha DATE,
    Mes VARCHAR(20),
    Año INT,
    INDEX idx_fecha (Fecha)
);

CREATE TABLE Usuarios (
    usuario VARCHAR(20) PRIMARY KEY,
    contraseña VARCHAR(20)
);

CREATE TABLE Calificaciones (
    ID_Calificacion INT AUTO_INCREMENT PRIMARY KEY,
    Calificacion TINYINT NULL,
    Comentario TEXT NULL,
    ID_Producto INT NULL
);

CREATE TABLE Categorias (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    NombreCategoria VARCHAR(40) NOT NULL
);

CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    ID_tipoCliente INT NOT NULL
);

CREATE TABLE tipoCliente (
    ID_tipoCliente INT AUTO_INCREMENT PRIMARY KEY,
    TipoCliente VARCHAR(40)
);

CREATE TABLE Compra_factura (
    ID_CompraFactura INT AUTO_INCREMENT PRIMARY KEY,
    N_Factura INT NULL,
    ID_Proveedores INT NULL,
    Fecha DATETIME NULL,
    Imagen LONGBLOB NULL
);

CREATE TABLE Detalle_venta_factura (
    ID_Detalle INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    NumeroFactura INT NULL,
    PrecioVenta DOUBLE NULL
);

CREATE TABLE DetalleCompraFactura (
    ID_Compra INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    ID_CompraFactura INT NULL,
    ID_Producto INT NULL
);

CREATE TABLE Producto (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Stock INT NULL,
    ID_Categoria INT NULL,
    PrecioCompra DOUBLE NULL,
    PrecioVenta DOUBLE NULL,
    nombreProducto VARCHAR(30) NULL,
    Descripcion VARCHAR(60) NULL,
    UbicacionFotografia LONGTEXT,
    ID_catalogo INT
);

CREATE TABLE Proveedores (
    ID_Proveedores INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(50) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);

CREATE TABLE Venta_factura (
    NumeroFactura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NULL,
    fecha_venta DATETIME NULL
);

-- Modificacion a la tabla venta y detalle
ALTER TABLE detalle_venta_factura
ADD CONSTRAINT fk_venta_detalle FOREIGN KEY (NumeroFactura) REFERENCES venta_factura(NumeroFactura) ON DELETE CASCADE;


-- Relaciones entre tablas
ALTER TABLE venta_factura
ADD CONSTRAINT FK_Venta_factura_Cliente
FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente);  -- clientet y venta factura 

ALTER TABLE detalle_venta_factura
ADD CONSTRAINT FK_Detalle_Venta_Venta_factura
FOREIGN KEY (NumeroFactura) REFERENCES Venta_factura(NumeroFactura); 

ALTER TABLE Producto
ADD CONSTRAINT FK_Categoria_Producto
FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria); 

ALTER TABLE detalle_venta_factura
ADD CONSTRAINT FK_Producto_Detallecomprafactura 
FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto);

ALTER TABLE detallecomprafactura
ADD CONSTRAINT FK_Categoria_Compra
FOREIGN KEY (ID_CompraFactura) REFERENCES Compra_factura(ID_CompraFactura);

ALTER TABLE compra_factura
ADD CONSTRAINT FK_proveedores_compra
FOREIGN KEY (ID_Proveedores) REFERENCES Proveedores(ID_Proveedores);

ALTER TABLE producto
ADD CONSTRAINT FK_proveedores_categoria
FOREIGN KEY (ID_Categoria) REFERENCES categorias(ID_Categoria);

ALTER TABLE producto
ADD CONSTRAINT FK_proveedores_calificaciones 	
FOREIGN KEY (ID_Calificacion) REFERENCES calificaciones(ID_Calificacion);

-- Insertando 50 registros en la tabla Usuarios
INSERT INTO Usuarios (usuario, contraseña) VALUES 
('usuario1', 'contraseña1'),
('usuario2', 'contraseña2'),
('usuario3', 'contraseña3'),
('usuario4', 'contraseña4'),
('usuario5', 'contraseña5'),
('usuario6', 'contraseña6'),
('usuario7', 'contraseña7'),
('usuario8', 'contraseña8'),
('usuario9', 'contraseña9'),
('usuario10', 'contraseña10'),
('usuario11', 'contraseña11'),
('usuario12', 'contraseña12'),
('usuario13', 'contraseña13'),
('usuario14', 'contraseña14'),
('usuario15', 'contraseña15'),
('usuario16', 'contraseña16'),
('usuario17', 'contraseña17'),
('usuario18', 'contraseña18'),
('usuario19', 'contraseña19'),
('usuario20', 'contraseña20'),
('usuario21', 'contraseña21'),
('usuario22', 'contraseña22'),
('usuario23', 'contraseña23'),
('usuario24', 'contraseña24'),
('usuario25', 'contraseña25'),
('usuario26', 'contraseña26'),
('usuario27', 'contraseña27'),
('usuario28', 'contraseña28'),
('usuario29', 'contraseña29'),
('usuario30', 'contraseña30'),
('usuario31', 'contraseña31'),
('usuario32', 'contraseña32'),
('usuario33', 'contraseña33'),
('usuario34', 'contraseña34'),
('usuario35', 'contraseña35'),
('usuario36', 'contraseña36'),
('usuario37', 'contraseña37'),
('usuario38', 'contraseña38'),
('usuario39', 'contraseña39'),
('usuario40', 'contraseña40'),
('usuario41', 'contraseña41'),
('usuario42', 'contraseña42'),
('usuario43', 'contraseña43'),
('usuario44', 'contraseña44'),
('usuario45', 'contraseña45'),
('usuario46', 'contraseña46'),
('usuario47', 'contraseña47'),
('usuario48', 'contraseña48'),
('usuario49', 'contraseña49'),
('usuario50', 'contraseña50');

-- Insertando 50 registros en la tabla Categorias
INSERT INTO Categorias (NombreCategoria) VALUES 
('Electrónica'),
('Hogar'),
('Deportes'),
('Ropa'),
('Alimentos'),
('Juguetes'),
('Libros'),
('Muebles'),
('Belleza'),
('Salud'),
('Tecnología'),
('Automotriz'),
('Jardinería'),
('Oficina'),
('Mascotas'),
('Viajes'),
('Juegos'),
('Herramientas'),
('Artículos de Cocina'),
('Accesorios'),
('Material Escolar'),
('Deportes Acuáticos'),
('Fitness'),
('Ciclismo'),
('Correr'),
('Senderismo'),
('Camping'),
('Pesca'),
('Caza'),
('Surf'),
('Esquí'),
('Patinaje'),
('Gimnasia'),
('Yoga'),
('Pilates'),
('Boxeo'),
('Artes Marciales'),
('Bailes'),
('Fotografía'),
('Cine'),
('Música'),
('Teatro'),
('Arte'),
('Manualidades'),
('Costura'),
('Tejido'),
('Cerámica'),
('Escultura'),
('Pintura'),
('Dibujo');

-- Insertando 50 registros en la tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, ID_tipoCliente) VALUES
('Juan', 'Perez', 1),
('Ana', 'Gomez', 2),
('Carlos', 'Lopez', 3),
('María', 'Fernandez', 1),
('Luis', 'Martinez', 2),
('Sofia', 'Hernandez', 3),
('Miguel', 'Gonzalez', 1),
('Laura', 'Rodriguez', 2),
('Javier', 'Sanchez', 3),
('Patricia', 'Torres', 1),
('Diego', 'Ramirez', 2),
('Sandra', 'Diaz', 3),
('Fernando', 'Morales', 1),
('Cristina', 'Paredes', 2),
('Andrés', 'Cruz', 3),
('Natalia', 'Mendoza', 1),
('Hugo', 'Rivas', 2),
('Veronica', 'Salazar', 3),
('Raúl', 'Cordero', 1),
('Carmen', 'Valdez', 2),
('Roberto', 'Ortega', 3),
('Esteban', 'Cano', 1),
('Silvia', 'Medina', 2),
('Alberto', 'Ceballos', 3),
('Claudia', 'Alvarez', 1),
('Julio', 'Ponce', 2),
('Elena', 'Sierra', 3),
('Victor', 'Castañeda', 1),
('Maribel', 'Rojas', 2),
('Antonio', 'Zamora', 3),
('Nadia', 'Guzman', 1),
('Matias', 'Sotelo', 2),
('Rosa', 'López', 3),
('Jorge', 'Salas', 1),
('Gina', 'Pizarro', 2),
('Rafael', 'Vargas', 3),
('Irene', 'Cortez', 1),
('Pablo', 'Núñez', 2),
('Luz', 'Hidalgo', 3),
('Francisco', 'Mora', 1),
('Marta', 'Peña', 2),
('Héctor', 'Bermúdez', 3),
('Lilian', 'Soto', 1),
('Arturo', 'García', 2),
('Susana', 'Figueroa', 3),
('Felipe', 'Cárdenas', 1),
('Adriana', 'Ríos', 2),
('Tomas', 'Cisneros', 3),
('Ruth', 'Aguirre', 1),
('Ricardo', 'Vásquez', 2),
('Santiago', 'Peñalosa', 3),
('Miriam', 'Peñaloza', 1),
('Estela', 'Arce', 2),
('Salvador', 'Maldonado', 3);

-- Insertando 50 registros en la tabla Producto
INSERT INTO Producto (Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo) VALUES
(50, 2, 100.00, 150.00, 'Televisor 50"', 'Televisor 4K UHD', 'imagenes/tv50.jpg', 1),
(20, 2, 30.00, 50.00, 'Lámpara LED', 'Lámpara de escritorio LED', 'imagenes/lampara.jpg', 2),
(15, 2, 200.00, 300.00, 'Smartphone', 'Smartphone de última generación', 'imagenes/smartphone.jpg', 1),
(10, 3, 500.00, 700.00, 'Bicicleta', 'Bicicleta de montaña', 'imagenes/bicicleta.jpg', 2),
(25, 4, 15.00, 25.00, 'Camiseta', 'Camiseta de algodón', 'imagenes/camiseta.jpg', 1),
(30, 5, 5.00, 10.00, 'Snack', 'Snack saludable', 'imagenes/snack.jpg', 2),
(40, 6, 50.00, 80.00, 'Juguete', 'Juguete educativo', 'imagenes/juguete.jpg', 1),
(60, 7, 20.00, 30.00, 'Libro', 'Libro de aventuras', 'imagenes/libro.jpg', 2),
(35, 8, 150.00, 200.00, 'Sofa', 'Sofa de 3 plazas', 'imagenes/sofa.jpg', 1),
(45, 9, 10.00, 15.00, 'Crema', 'Crema hidratante', 'imagenes/crema.jpg', 2),
(55, 10, 80.00, 120.00, 'Perfume', 'Perfume de mujer', 'imagenes/perfume.jpg', 1),
(12, 11, 300.00, 400.00, 'Laptop', 'Laptop para gamers', 'imagenes/laptop.jpg', 2),
(22, 12, 60.00, 90.00, 'Cámara', 'Cámara digital', 'imagenes/camara.jpg', 1),
(32, 13, 40.00, 60.00, 'Mesa', 'Mesa de comedor', 'imagenes/mesa.jpg', 2),
(42, 14, 70.00, 100.00, 'Silla', 'Silla ergonómica', 'imagenes/silla.jpg', 1),
(52, 15, 25.00, 35.00, 'Taza', 'Taza de cerámica', 'imagenes/taza.jpg', 2),
(62, 16, 12.00, 18.00, 'Bolígrafo', 'Bolígrafo de gel', 'imagenes/boligrafo.jpg', 1),
(72, 17, 18.00, 25.00, 'Cuaderno', 'Cuaderno de notas', 'imagenes/cuaderno.jpg', 2),
(82, 18, 45.00, 70.00, 'Reloj', 'Reloj de pulsera', 'imagenes/reloj.jpg', 1),
(92, 19, 150.00, 200.00, 'Auriculares', 'Auriculares inalámbricos', 'imagenes/auriculares.jpg', 2),
(102, 20, 90.00, 130.00, 'Altavoz', 'Altavoz Bluetooth', 'imagenes/altavoz.jpg', 1),
(112, 21, 200.00, 250.00, 'Monitor', 'Monitor 27"', 'imagenes/monitor.jpg', 2),
(122, 22, 300.00, 350.00, 'Teclado', 'Teclado mecánico', 'imagenes/teclado.jpg', 1),
(132, 23, 150.00, 200.00, 'Mouse', 'Mouse ergonómico', 'imagenes/mouse.jpg', 2),
(142, 24, 500.00, 600.00, 'Proyector', 'Proyector de alta definición', 'imagenes/proyector.jpg', 1),
(152, 25, 70.00, 100.00, 'Estuche', 'Estuche para laptop', 'imagenes/estuche.jpg', 2),
(162, 26, 30.00, 50.00, 'Mochila', 'Mochila escolar', 'imagenes/mochila.jpg', 1),
(172, 27, 15.00, 25.00, 'Botella', 'Botella de agua', 'imagenes/botella.jpg', 2),
(182, 28, 40.00, 60.00, 'Cuchara', 'Cuchara de acero', 'imagenes/cuchara.jpg', 1),
(192, 29, 60.00, 90.00, 'Tenedor', 'Tenedor de acero', 'imagenes/tenedor.jpg', 2),
(202, 30, 50.00, 80.00, 'Cuchillo', 'Cuchillo de cocina', 'imagenes/cuchillo.jpg', 1),
(212, 31, 80.00, 120.00, 'Sartén', 'Sartén antiadherente', 'imagenes/sarten.jpg', 2),
(222, 32, 25.00, 35.00, 'Olla', 'Olla de acero inoxidable', 'imagenes/olla.jpg', 1),
(232, 33, 10.00, 15.00, 'Plato', 'Plato de cerámica', 'imagenes/plato.jpg', 2),
(242, 34, 20.00, 30.00, 'Vaso', 'Vaso de vidrio', 'imagenes/vaso.jpg', 1),
(252, 35, 15.00, 25.00, 'Cuchara Medidora', 'Cuchara medidora de plástico', 'imagenes/cucharamedidora.jpg', 2),
(262, 36, 12.00, 18.00, 'Batidora', 'Batidora de mano', 'imagenes/batidora.jpg', 1),
(272, 37, 30.00, 50.00, 'Licuadora', 'Licuadora de 1.5L', 'imagenes/licuadora.jpg', 2),
(282, 38, 25.00, 35.00, 'Tostadora', 'Tostadora de pan', 'imagenes/tostadora.jpg', 1),
(292, 39, 40.00, 60.00, 'Cafetera', 'Cafetera eléctrica', 'imagenes/cafetera.jpg', 2),
(302, 40, 150.00, 200.00, 'Cortadora de Césped', 'Cortadora de césped eléctrica', 'imagenes/cortadora.jpg', 1),
(312, 41, 80.00, 120.00, 'Sierra', 'Sierra circular', 'imagenes/sierra.jpg', 2),
(322, 42, 100.00, 150.00, 'Taladro', 'Taladro inalámbrico', 'imagenes/taladro.jpg', 1),
(332, 43, 90.00, 130.00, 'Destornillador', 'Destornillador eléctrico', 'imagenes/destornillador.jpg', 2),
(342, 44, 50.00, 80.00, 'Martillo', 'Martillo de carpintero', 'imagenes/martillo.jpg', 1),
(352, 45, 20.00, 30.00, 'Llave Inglesa', 'Llave inglesa ajustable', 'imagenes/llave.jpg', 2),
(362, 46, 15.00, 25.00, 'Cinta Métrica', 'Cinta métrica de 5m', 'imagenes/cinta.jpg', 1),
(372, 47, 10.00, 15.00, 'Nivel', 'Nivel de burbuja', 'imagenes/nivel.jpg', 2),
(382, 48, 5.00, 10.00, 'Guantes', 'Guantes de trabajo', 'imagenes/guantes.jpg', 1),
(392, 49, 12.00, 18.00, 'Mascarilla', 'Mascarilla de protección', 'imagenes/mascarilla.jpg', 2),
(402, 50, 25.00, 35.00, 'Gafas de Sol', 'Gafas de sol polarizadas', 'imagenes/gafas.jpg', 1);

INSERT INTO tipoCliente ( TipoCliente) Values
                        ('Generico'),
						('Frecuente');

INSERT INTO Proveedores (NombreProveedor, Telefono, Correo, Direccion) VALUES
('Proveedor A', '555-0001', 'contactoA@proveedora.com', 'Calle 1, Ciudad A'),
('Proveedor B', '555-0002', 'contactoB@proveedora.com', 'Calle 2, Ciudad B'),
('Proveedor C', '555-0003', 'contactoC@proveedora.com', 'Calle 3, Ciudad C'),
('Proveedor D', '555-0004', 'contactoD@proveedora.com', 'Calle 4, Ciudad D'),
('Proveedor E', '555-0005', 'contactoE@proveedora.com', 'Calle 5, Ciudad E'),
('Proveedor F', '555-0006', 'contactoF@proveedora.com', 'Calle 6, Ciudad F'),
('Proveedor G', '555-0007', 'contactoG@proveedora.com', 'Calle 7, Ciudad G'),
('Proveedor H', '555-0008', 'contactoH@proveedora.com', 'Calle 8, Ciudad H'),
('Proveedor I', '555-0009', 'contactoI@proveedora.com', 'Calle 9, Ciudad I'),
('Proveedor J', '555-0010', 'contactoJ@proveedora.com', 'Calle 10, Ciudad J'),
('Proveedor K', '555-0011', 'contactoK@proveedora.com', 'Calle 11, Ciudad K'),
('Proveedor L', '555-0012', 'contactoL@proveedora.com', 'Calle 12, Ciudad L'),
('Proveedor M', '555-0013', 'contactoM@proveedora.com', 'Calle 13, Ciudad M'),
('Proveedor N', '555-0014', 'contactoN@proveedora.com', 'Calle 14, Ciudad N'),
('Proveedor O', '555-0015', 'contactoO@proveedora.com', 'Calle 15, Ciudad O'),
('Proveedor P', '555-0016', 'contactoP@proveedora.com', 'Calle 16, Ciudad P'),
('Proveedor Q', '555-0017', 'contactoQ@proveedora.com', 'Calle 17, Ciudad Q'),
('Proveedor R', '555-0018', 'contactoR@proveedora.com', 'Calle 18, Ciudad R'),
('Proveedor S', '555-0019', 'contactoS@proveedora.com', 'Calle 19, Ciudad S'),
('Proveedor T', '555-0020', 'contactoT@proveedora.com', 'Calle 20, Ciudad T'),
('Proveedor U', '555-0021', 'contactoU@proveedora.com', 'Calle 21, Ciudad U'),
('Proveedor V', '555-0022', 'contactoV@proveedora.com', 'Calle 22, Ciudad V'),
('Proveedor W', '555-0023', 'contactoW@proveedora.com', 'Calle 23, Ciudad W'),
('Proveedor X', '555-0024', 'contactoX@proveedora.com', 'Calle 24, Ciudad X'),
('Proveedor Y', '555-0025', 'contactoY@proveedora.com', 'Calle 25, Ciudad Y'),
('Proveedor Z', '555-0026', 'contactoZ@proveedora.com', 'Calle 26, Ciudad Z'),
('Proveedor AA', '555-0027', 'contactoAA@proveedora.com', 'Calle 27, Ciudad AA'),
('Proveedor AB', '555-0028', 'contactoAB@proveedora.com', 'Calle 28, Ciudad AB'),
('Proveedor AC', '555-0029', 'contactoAC@proveedora.com', 'Calle 29, Ciudad AC'),
('Proveedor AD', '555-0030', 'contactoAD@proveedora.com', 'Calle 30, Ciudad AD');

INSERT INTO Venta_factura (ID_Cliente, fecha_venta) VALUES
(1, '2025-05-01'),
(2, '2025-05-02'),
(3, '2025-05-03'),
(4, '2025-05-04'),
(5, '2025-05-05'),
(6, '2025-05-06'),
(7, '2025-05-07'),
(8, '2025-05-08'),
(9, '2025-05-09'),
(10, '2025-05-10'),
(11, '2025-05-11'),
(12, '2025-05-12'),
(13, '2025-05-13'),
(14, '2025-05-14'),
(15, '2025-05-15'),
(16, '2025-05-16'),
(17, '2025-05-17'),
(18, '2025-05-18'),
(19, '2025-05-19'),
(20, '2025-05-20'),
(21, '2025-05-21'),
(22, '2025-05-22'),
(23, '2025-05-23'),
(24, '2025-05-24'),
(25, '2025-05-25'),
(26, '2025-05-26'),
(27, '2025-05-27'),
(28, '2025-05-28'),
(29, '2025-05-29'),
(30, '2025-05-30');


INSERT INTO Detalle_venta_factura (ID_Producto, Cantidad, NumeroFactura, PrecioVenta) VALUES
(1, 2, 1, 150.00),
(2, 1, 1, 50.00),
(3, 3, 2, 300.00),
(4, 1, 2, 700.00),
(5, 4, 3, 25.00),
(6, 5, 3, 10.00),
(7, 6, 4, 80.00),
(8, 2, 4, 15.00),
(9, 1, 5, 200.00),
(10, 3, 5, 90.00),
(11, 4, 6, 30.00),
(12, 5, 6, 12.00),
(13, 6, 7, 45.00),
(14, 1, 7, 70.00),
(15, 2, 8, 25.00),
(16, 3, 8, 60.00),
(17, 4, 9, 15.00),
(18, 5, 9, 35.00),
(19, 6, 10, 50.00),
(20, 1, 10, 100.00),
(21, 2, 11, 75.00),
(22, 3, 11, 30.00),
(23, 4, 12, 20.00),
(24, 5, 12, 18.00),
(25, 6, 13, 22.00),
(26, 1, 13, 90.00),
(27, 2, 14, 40.00),
(28, 3, 14, 80.00),
(29, 4, 15, 55.00),
(30, 5, 15, 65.00);

 INSERT INTO Compra_factura (N_Factura, ID_Proveedores, Fecha) VALUES
(1001, 1, '2025-05-01 10:00:00'),
(1002, 2, '2025-05-02 11:00:00'),
(1003, 3, '2025-05-03 12:00:00'),
(1004, 4, '2025-05-04 13:00:00'),
(1005, 5, '2025-05-05 14:00:00'),
(1006, 6, '2025-05-06 15:00:00'),
(1007, 7, '2025-05-07 16:00:00'),
(1008, 8, '2025-05-08 17:00:00'),
(1009, 9, '2025-05-09 18:00:00'),
(1010, 10, '2025-05-10 19:00:00');


INSERT INTO DetalleCompraFactura (Cantidad, Precio, ID_CompraFactura, ID_Producto) VALUES
(5, 100.00, 1, 1),  -- 5 unidades del producto 1 a 100.00 cada uno
(10, 50.00, 1, 2),  -- 10 unidades del producto 2 a 50.00 cada uno
(3, 200.00, 2, 3),  -- 3 unidades del producto 3 a 200.00 cada uno
(7, 15.00, 2, 4),   -- 7 unidades del producto 4 a 15.00 cada uno
(2, 300.00, 3, 5),  -- 2 unidades del producto 5 a 300.00 cada uno
(4, 80.00, 3, 6),   -- 4 unidades del producto 6 a 80.00 cada uno
(1, 400.00, 4, 7),  -- 1 unidad del producto 7 a 400.00
(6, 20.00, 4, 8),   -- 6 unidades del producto 8 a 20.00 cada uno
(8, 120.00, 5, 9),  -- 8 unidades del producto 9 a 120.00 cada uno
(5, 35.00, 5, 10);  -- 5 unidades del producto 10 a 35.00 cada uno



