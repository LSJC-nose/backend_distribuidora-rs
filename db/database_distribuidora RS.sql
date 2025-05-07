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
    UbicacionFotografia VARCHAR(160) NULL,
    ID_catalogo INT
);

CREATE TABLE Proveedores (
    ID_Proveedores INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(50) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);



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
(50, 1, 100.00, 150.00, 'Televisor 50"', 'Televisor 4K UHD', 'imagenes/tv50.jpg', 1),
(20, 2, 30.00, 50.00, 'Lámpara LED', 'Lámpara de escritorio LED', 'imagenes/lampara.jpg', 2),
(15, 1, 200.00, 300.00, 'Smartphone', 'Smartphone de última generación', 'imagenes/smartphone.jpg', 1),
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

