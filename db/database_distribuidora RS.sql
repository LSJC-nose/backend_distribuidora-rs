-- Create Database
CREATE DATABASE distribuidora_rs;
USE distribuidora_rs;

-- Table: tipoCliente
CREATE TABLE tipo_cliente (
    ID_TipoCliente INT AUTO_INCREMENT PRIMARY KEY,
   tipoCliente VARCHAR(40) NOT NULL
);

-- Table: categorias
CREATE TABLE categorias (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    NombreCategoria VARCHAR(40) NOT NULL
);

-- Table: proveedores
CREATE TABLE proveedores (
    ID_Proveedores INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(50) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);

-- Table: usuarios
CREATE TABLE usuarios (
    usuario VARCHAR(20) PRIMARY KEY,
    contraseña VARCHAR(20) NOT NULL
);

-- Table: cliente
CREATE TABLE cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    ID_TipoCliente INT NOT NULL,
    FOREIGN KEY (ID_TipoCliente) REFERENCES tipo_cliente(ID_TipoCliente) ON DELETE RESTRICT
);

-- Table: producto
CREATE TABLE producto (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Stock INT,
    ID_Categoria INT,
    PrecioCompra DOUBLE,
    PrecioVenta DOUBLE,
    nombreProducto VARCHAR(30),
    Descripcion VARCHAR(60),
    UbicacionFotografia VARCHAR(160),
    ID_Catalogo INT,
    FOREIGN KEY (ID_Categoria) REFERENCES categorias(ID_Categoria) ON DELETE RESTRICT
);

-- Table: catalogo
CREATE TABLE catalogo (
    ID_Catalogo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    Descripcion VARCHAR(100),
    Precio_Producto DOUBLE,
    Imagen VARCHAR(50),
    FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto) ON DELETE CASCADE
);

-- Table: calificaciones
CREATE TABLE calificaciones (
    ID_Calificacion INT AUTO_INCREMENT PRIMARY KEY,
    Calificacion TINYINT,
    Comentario TEXT,
    ID_Producto INT,
    FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto) ON DELETE CASCADE
);

-- Table: tiempo
CREATE TABLE tiempo (
    ID_Tiempo INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE,
    Mes VARCHAR(20),
    Año INT,
    INDEX idx_fecha (Fecha)
);

CREATE TABLE Compra_factura (
    ID_CompraFactura INT AUTO_INCREMENT PRIMARY KEY,
    N_Factura INT NULL,
    ID_Proveedores INT NULL,
    Fecha DATETIME NULL,
    Imagen LONGBLOB NULL
);

-- Table: venta_factura
CREATE TABLE venta_factura (
    numeraFactura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    fecha_venta DATETIME,
    total_venta float,
    FOREIGN KEY (ID_Cliente) REFERENCES cliente(ID_Cliente) ON DELETE RESTRICT
);

CREATE TABLE detalle_venta_factura (
  ID_Detalle int NOT NULL AUTO_INCREMENT,
  ID_Producto int DEFAULT NULL,
  Cantidad int NOT NULL,
  NumeroFactura int DEFAULT NULL,
  PrecioVenta double DEFAULT NULL,
  PRIMARY KEY (`ID_Detalle`),
  KEY `FK_Detalle_Venta_Venta_factura` (`NumeroFactura`),
  CONSTRAINT `FK_Detalle_Venta_Venta_factura` FOREIGN KEY (`NumeroFactura`) REFERENCES `venta_factura` (`NumeroFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_detalle` FOREIGN KEY (`NumeroFactura`) REFERENCES `venta_factura` (`NumeroFactura`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


CREATE TABLE DetalleCompraFactura (
    ID_Compra INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    ID_CompraFactura INT NULL,
    ID_Producto INT NULL
);


-- Table: bitacoras
CREATE TABLE bitacoras (
    ID_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    transaccion VARCHAR(10) NOT NULL,
    usuario VARCHAR(40) NOT NULL,
    host VARCHAR(40) DEFAULT NULL,
    fecha DATETIME NOT NULL,
    tabla VARCHAR(20) NOT NULL
);

-- Insert Data into tipo_cliente
INSERT INTO tipocliente (TipoCliente) VALUES
('Generico'),
('Frecuente');

-- Insert Data into categorias
INSERT INTO categorias (NombreCategoria) VALUES 
('Electrónica'), ('Hogar'), ('Deportes'), ('Ropa'), ('Alimentos'), ('Juguetes'), ('Libros'), 
('Muebles'), ('Belleza'), ('Salud'), ('Tecnología'), ('Automotriz'), ('Jardinería'), ('Oficina'), 
('Mascotas'), ('Viajes'), ('Juegos'), ('Herramientas'), ('Artículos de Cocina'), ('Accesorios'), 
('Material Escolar'), ('Deportes Acuáticos'), ('Fitness'), ('Ciclismo'), ('Correr'), ('Senderismo'), 
('Camping'), ('Pesca'), ('Caza'), ('Surf'), ('Esquí'), ('Patinaje'), ('Gimnasia'), ('Yoga'), 
('Pilates'), ('Boxeo'), ('Artes Marciales'), ('Bailes'), ('Fotografía'), ('Cine'), ('Música'), 
('Teatro'), ('Arte'), ('Manualidades'), ('Costura'), ('Tejido'), ('Cerámica'), ('Escultura'), 
('Pintura'), ('Dibujo');

-- Insert Data into proveedores
INSERT INTO proveedores (NombreProveedor, Telefono, Correo, Direccion) VALUES
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

-- Insert Data into usuarios
INSERT INTO usuarios (usuario, contraseña) VALUES 
('usuario1', 'contraseña1'), ('usuario2', 'contraseña2'), ('usuario3', 'contraseña3'), 
('usuario4', 'contraseña4'), ('usuario5', 'contraseña5'), ('usuario6', 'contraseña6'), 
('usuario7', 'contraseña7'), ('usuario8', 'contraseña8'), ('usuario9', 'contraseña9'), 
('usuario10', 'contraseña10'), ('usuario11', 'contraseña11'), ('usuario12', 'contraseña12'), 
('usuario13', 'contraseña13'), ('usuario14', 'contraseña14'), ('usuario15', 'contraseña15'), 
('usuario16', 'contraseña16'), ('usuario17', 'contraseña17'), ('usuario18', 'contraseña18'), 
('usuario19', 'contraseña19'), ('usuario20', 'contraseña20'), ('usuario21', 'contraseña21'), 
('usuario22', 'contraseña22'), ('usuario23', 'contraseña23'), ('usuario24', 'contraseña24'), 
('usuario25', 'contraseña25'), ('usuario26', 'contraseña26'), ('usuario27', 'contraseña27'), 
('usuario28', 'contraseña28'), ('usuario29', 'contraseña29'), ('usuario30', 'contraseña30'), 
('usuario31', 'contraseña31'), ('usuario32', 'contraseña32'), ('usuario33', 'contraseña33'), 
('usuario34', 'contraseña34'), ('usuario35', 'contraseña35'), ('usuario36', 'contraseña36'), 
('usuario37', 'contraseña37'), ('usuario38', 'contraseña38'), ('usuario39', 'contraseña39'), 
('usuario40', 'contraseña40'), ('usuario41', 'contraseña41'), ('usuario42', 'contraseña42'), 
('usuario43', 'contraseña43'), ('usuario44', 'contraseña44'), ('usuario45', 'contraseña45'), 
('usuario46', 'contraseña46'), ('usuario47', 'contraseña47'), ('usuario48', 'contraseña48'), 
('usuario49', 'contraseña49'), ('usuario50', 'contraseña50');

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

-- Insert Data into producto
INSERT INTO producto (Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, ubicacionFotografia, ID_Catalogo) VALUES
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

-- Insert Data into catalogo
INSERT INTO catalogo (ID_Producto, Descripcion, imagen) VALUES
(1, 'Televisor 4K UHD', 150.00, 'imagenes/tv50.jpg'),
(2, 'Lámpara de escritorio LED', 50.00, 'imagenes/lampara.jpg'),
(3, 'Smartphone de última generación', 300.00, 'imagenes/smartphone.jpg'),
(4, 'Bicicleta de montaña', 700.00, 'imagenes/bicicleta.jpg'),
(5, 'Camiseta de algodón', 25.00, 'imagenes/camiseta.jpg'),
(6, 'Snack saludable', 10.00, 'imagenes/snack.jpg'),
(7, 'Juguete educativo', 80.00, 'imagenes/juguete.jpg'),
(8, 'Libro de aventuras', 30.00, 'imagenes/libro.jpg'),
(9, 'Sofa de 3 plazas', 200.00, 'imagenes/sofa.jpg'),
(10, 'Crema hidratante', 15.00, 'imagenes/crema.jpg'),
(11, 'Perfume de mujer', 120.00, 'imagenes/perfume.jpg'),
(12, 'Laptop para gamers', 400.00, 'imagenes/laptop.jpg'),
(13, 'Cámara digital', 90.00, 'imagenes/camara.jpg'),
(14, 'Mesa de comedor', 60.00, 'imagenes/mesa.jpg'),
(15, 'Silla ergonómica', 100.00, 'imagenes/silla.jpg'),
(16, 'Taza de cerámica', 35.00, 'imagenes/taza.jpg'),
(17, 'Bolígrafo de gel', 18.00, 'imagenes/boligrafo.jpg'),
(18, 'Cuaderno de notas', 25.00, 'imagenes/cuaderno.jpg'),
(19, 'Reloj de pulsera', 70.00, 'imagenes/reloj.jpg'),
(20, 'Auriculares inalámbricos', 200.00, 'imagenes/auriculares.jpg'),
(21, 'Altavoz Bluetooth', 130.00, 'imagenes/altavoz.jpg'),
(22, 'Monitor 27"', 250.00, 'imagenes/monitor.jpg'),
(23, 'Teclado mecánico', 350.00, 'imagenes/teclado.jpg'),
(24, 'Mouse ergonómico', 200.00, 'imagenes/mouse.jpg'),
(25, 'Proyector de alta definición', 600.00, 'imagenes/proyector.jpg'),
(26, 'Estuche para laptop', 100.00, 'imagenes/estuche.jpg'),
(27, 'Mochila escolar', 50.00, 'imagenes/mochila.jpg'),
(28, 'Botella de agua', 25.00, 'imagenes/botella.jpg'),
(29, 'Cuchara de acero', 60.00, 'imagenes/cuchara.jpg'),
(30, 'Tenedor de acero', 90.00, 'imagenes/tenedor.jpg'),
(31, 'Cuchillo de cocina', 80.00, 'imagenes/cuchillo.jpg'),
(32, 'Sartén antiadherente', 120.00, 'imagenes/sarten.jpg'),
(33, 'Olla de acero inoxidable', 35.00, 'imagenes/olla.jpg'),
(34, 'Plato de cerámica', 15.00, 'imagenes/plato.jpg'),
(35, 'Vaso de vidrio', 30.00, 'imagenes/vaso.jpg'),
(36, 'Cuchara medidora de plástico', 25.00, 'imagenes/cucharamedidora.jpg'),
(37, 'Batidora de mano', 18.00, 'imagenes/batidora.jpg'),
(38, 'Licuadora de 1.5L', 50.00, 'imagenes/licuadora.jpg'),
(39, 'Tostadora de pan', 35.00, 'imagenes/tostadora.jpg'),
(40, 'Cafetera eléctrica', 60.00, 'imagenes/cafetera.jpg'),
(41, 'Cortadora de césped eléctrica', 200.00, 'imagenes/cortadora.jpg'),
(42, 'Sierra circular', 120.00, 'imagenes/sierra.jpg'),
(43, 'Taladro inalámbrico', 150.00, 'imagenes/taladro.jpg'),
(44, 'Destornillador eléctrico', 130.00, 'imagenes/destornillador.jpg'),
(45, 'Martillo de carpintero', 80.00, 'imagenes/martillo.jpg'),
(46, 'Llave inglesa ajustable', 30.00, 'imagenes/llave.jpg'),
(47, 'Cinta métrica de 5m', 25.00, 'imagenes/cinta.jpg'),
(48, 'Nivel de burbuja', 15.00, 'imagenes/nivel.jpg'),
(49, 'Guantes de trabajo', 10.00, 'imagenes/guantes.jpg'),
(50, 'Mascarilla de protección', 18.00, 'imagenes/mascarilla.jpg');

-- Insert Data into venta_factura
INSERT INTO venta_factura (ID_Cliente, fecha_venta,total_venta) VALUES
(1, '2025-05-01'), (2, '2025-05-02'), (3, '2025-05-03'), (4, '2025-05-04'), 
(5, '2025-05-05'), (6, '2025-05-06'), (7, '2025-05-07'), (8, '2025-05-08'), 
(9, '2025-05-09'), (10, '2025-05-10'), (11, '2025-05-11'), (12, '2025-05-12'), 
(13, '2025-05-13'), (14, '2025-05-14'), (15, '2025-05-15'), (16, '2025-05-16'), 
(17, '2025-05-17'), (18, '2025-05-18'), (19, '2025-05-19'), (20, '2025-05-20'), 
(21, '2025-05-21'), (22, '2025-05-22'), (23, '2025-05-23'), (24, '2025-05-24'), 
(25, '2025-05-25'), (26, '2025-05-26'), (27, '2025-05-27'), (28, '2025-05-28'), 
(29, '2025-05-29'), (30, '2025-05-30');

-- Insert Data into detalle_venta_factura
INSERT INTO detalle_venta_factura (ID_Producto, Cantidad, NumeroFactura, precio_venta) VALUES
(1, 2, 1, 150.00), (2, 1, 1, 50.00), (3, 3, 2, 300.00), (4, 1, 2, 700.00), 
(5, 4, 3, 25.00), (6, 5, 3, 10.00), (7, 6, 4, 80.00), (8, 2, 4, 15.00), 
(9, 1, 5, 200.00), (10, 3, 5, 90.00), (11, 4, 6, 30.00), (12, 5, 6, 12.00), 
(13, 6, 7, 45.00), (14, 1, 7, 70.00), (15, 2, 8, 25.00), (16, 3, 8, 60.00), 
(17, 4, 9, 15.00), (18, 5, 9, 35.00), (19, 6, 10, 50.00), (20, 1, 10, 100.00), 
(21, 2, 11, 75.00), (22, 3, 11, 30.00), (23, 4, 12, 20.00), (24, 5, 12, 18.00), 
(25, 6, 13, 22.00), (26, 1, 13, 90.00), (27, 2, 14, 40.00), (28, 3, 14, 80.00), 
(29, 4, 15, 55.00), (30, 5, 15, 65.00);

-- Insert Data into compra_factura
INSERT INTO compra_factura (ID_CompraFactura, ID_Proveedores, fecha_compra) VALUES
(1001, 1, '2025-05-01 10:00:00'), (1002, 2, '2025-05-02 11:00:00'), 
(1003, 3, '2025-05-03 12:00:00'), (1004, 4, '2025-05-04 13:00:00'), 
(1005, 5, '2025-05-05 14:00:00'), (1006, 6, '2025-05-06 15:00:00'), 
(1007, 7, '2025-05-07 16:00:00'), (1008, 8, '2025-05-08 17:00:00'), 
(1009, 9, '2025-05-09 18:00:00'), (1010, 10, '2025-05-10 19:00:00');

-- Insert Data into detalle_compra_factura
INSERT INTO detalle_compra_factura (Cantidad, PrecioCompra, ID_CompraFactura, ID_Producto) VALUES
(5, 100.00, 1, 1), (10, 50.00, 1, 2), (3, 200.00, 2, 3), (7, 15.00, 2, 4), 
(2, 300.00, 3, 5), (4, 80.00, 3, 6), (1, 400.00, 4, 7), (6, 20.00, 4, 8), 
(8, 120.00, 5, 9), (5, 35.00, 5, 10);