-- Crear base de datos
CREATE DATABASE IF NOT EXISTS distribuidora_rs;
USE distribuidora_rs;

-- Tabla: tipoCliente
CREATE TABLE IF NOT EXISTS tipoCliente (
    ID_TipoCliente INT AUTO_INCREMENT PRIMARY KEY,
    tipoCliente VARCHAR(40) NOT NULL
);

-- Tabla: Categorias
CREATE TABLE IF NOT EXISTS Categorias (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    NombreCategoria VARCHAR(40) NOT NULL
);

-- Tabla: Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    ID_Proveedores INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(50) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Direccion VARCHAR(150) NOT NULL
);

-- Tabla: Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    usuario VARCHAR(20) PRIMARY KEY,
    contraseña VARCHAR(20) NOT NULL
);

-- Tabla: Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    ID_TipoCliente INT NOT NULL
);

-- Tabla: Producto
CREATE TABLE IF NOT EXISTS Producto (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Stock INT,
    ID_Categoria INT,
    PrecioCompra DOUBLE,
    PrecioVenta DOUBLE,
    nombreProducto VARCHAR(30),
    Descripcion VARCHAR(60),
    UbicacionFotografia LONGTEXT,
    ID_Catalogo INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria) ON DELETE RESTRICT
);

-- Tabla: catalogo
CREATE TABLE IF NOT EXISTS catalogo (
    ID_Catalogo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    Descripcion VARCHAR(100),
    Precio_Producto DOUBLE,
    Imagen VARCHAR(50),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE
);

-- Tabla: calificaciones
CREATE TABLE IF NOT EXISTS calificaciones (
    ID_Calificacion INT AUTO_INCREMENT PRIMARY KEY,
    Calificacion TINYINT,
    Comentario TEXT,
    ID_Producto INT,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE
);

-- Tabla: Compra_factura
CREATE TABLE IF NOT EXISTS Compra_factura (
    ID_CompraFactura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proveedores INT NOT NULL,
    fecha_compra DATETIME,
    total_compra FLOAT,
    FOREIGN KEY (ID_Proveedores) REFERENCES Proveedores(ID_Proveedores) ON DELETE RESTRICT
);

-- Tabla: Venta_factura
CREATE TABLE IF NOT EXISTS Venta_factura (
    NumeroFactura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    fecha_venta DATETIME,
    total_venta FLOAT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente) ON DELETE Cascade
);

-- Tabla: detalle_venta_factura
CREATE TABLE IF NOT EXISTS detalle_venta_factura (
    ID_Detalle INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    NumeroFactura INT,
    PrecioVenta DOUBLE,
    FOREIGN KEY (NumeroFactura) REFERENCES Venta_factura(NumeroFactura) ON DELETE CASCADE,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE
);

-- Tabla: DetalleCompraFactura
CREATE TABLE IF NOT EXISTS DetalleCompraFactura (
    ID_Compra INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    PrecioCompra Float,
    ID_CompraFactura INT,
    ID_Producto INT,
    FOREIGN KEY (ID_CompraFactura) REFERENCES Compra_factura(ID_CompraFactura) ON DELETE CASCADE,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE
);

-- Tabla: bitacoras
CREATE TABLE IF NOT EXISTS bitacoras (
    ID_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    transaccion VARCHAR(10) NOT NULL,
    usuario VARCHAR(40) NOT NULL,
    host VARCHAR(40) DEFAULT NULL,
    fecha DATETIME NOT NULL,
    tabla VARCHAR(20) NOT NULL
);

-- Inserción de datos realistas

-- 1. tipoCliente (2 registros)
INSERT INTO tipoCliente (tipoCliente) VALUES
('Genérico'),
('Frecuente');

-- 2. Categorias (50 registros)
INSERT INTO Categorias (NombreCategoria) VALUES
('Electrónica'), ('Ropa'), ('Alimentos'), ('Bebidas'), ('Hogar'),
('Juguetes'), ('Libros'), ('Deportes'), ('Belleza'), ('Automotriz'),
('Jardinería'), ('Muebles'), ('Electrodomésticos'), ('Joyería'), ('Calzado'),
('Accesorios'), ('Tecnología'), ('Mascotas'), ('Oficina'), ('Salud'),
('Cocina'), ('Baño'), ('Limpieza'), ('Herramientas'), ('Camping'),
('Fitness'), ('Música'), ('Videojuegos'), ('Arte'), ('Manualidades'),
('Bebés'), ('Moda'), ('Viajes'), ('Fotografía'), ('Telefonía'),
('Computadoras'), ('Televisores'), ('Audio'), ('Cámaras'), ('Drones'),
('Relojes'), ('Bolsos'), ('Perfumes'), ('Maquillaje'), ('Cuidado Personal'),
('Juegos de Mesa'), ('Instrumentos Musicales'), ('Ropa Deportiva'), ('Suplementos'), ('Decoración');

-- 3. Proveedores (50 registros)
INSERT INTO Proveedores (NombreProveedor, Telefono, Correo, Direccion) VALUES
('TechTrend S.A.', '+52-55-1234-5678', 'contacto@techtrend.com', 'Av. Insurgentes 123, CDMX, México'),
('ModaViva S.A.', '+52-55-2345-6789', 'ventas@modaviva.com', 'Calle Reforma 456, Guadalajara, México'),
('Alimentos Naturales', '+52-33-3456-7890', 'info@alimentosnaturales.com', 'Av. Juárez 789, Monterrey, México'),
('Bebidas Frescas', '+52-81-4567-8901', 'pedidos@bebidasfrescas.com', 'Calle Morelos 101, Puebla, México'),
('Hogar Ideal', '+52-55-5678-9012', 'soporte@hogarideal.com', 'Av. Revolución 234, Tijuana, México'),
('Juguetes Alegres', '+52-55-6789-0123', 'ventas@juguetesalegres.com', 'Calle Hidalgo 567, León, México'),
('Librería Cultura', '+52-33-7890-1234', 'contacto@libreriacultura.com', 'Av. Chapultepec 890, Querétaro, México'),
('Deportes Activos', '+52-81-8901-2345', 'info@deportesactivos.com', 'Calle Madero 123, San Luis Potosí, México'),
('Belleza Radiante', '+52-55-9012-3456', 'ventas@bellezaradiante.com', 'Av. Universidad 456, Mérida, México'),
('AutoPartes México', '+52-55-0123-4567', 'pedidos@autopartesmx.com', 'Calle Independencia 789, Cancún, México'),
('Jardín Verde', '+52-33-1234-5678', 'contacto@jardinverde.com', 'Av. López Mateos 101, Zapopan, México'),
('Muebles Confort', '+52-81-2345-6789', 'ventas@mueblesconfort.com', 'Calle Allende 234, Toluca, México'),
('ElectroHogar', '+52-55-3456-7890', 'soporte@electrohogar.com', 'Av. Tlalpan 567, CDMX, México'),
('Joyería Brillante', '+52-55-4567-8901', 'info@joyeriabrillante.com', 'Calle 5 de Mayo 890, Guadalajara, México'),
('Calzado Estilo', '+52-33-5678-9012', 'ventas@calzadoestilo.com', 'Av. Vallarta 123, Monterrey, México'),
('Accesorios Modernos', '+52-81-6789-0123', 'contacto@accesoriosmodernos.com', 'Calle Zaragoza 456, Puebla, México'),
('TechInnovate', '+52-55-7890-1234', 'pedidos@techinnovate.com', 'Av. Insurgentes Sur 789, Tijuana, México'),
('Mascotas Felices', '+52-55-8901-2345', 'ventas@mascotasfelices.com', 'Calle Juárez 101, León, México'),
('Oficina Pro', '+52-33-9012-3456', 'soporte@oficinapro.com', 'Av. México 234, Querétaro, México'),
('Salud Total', '+52-81-0123-4567', 'info@saludtotal.com', 'Calle Hidalgo 567, San Luis Potosí, México'),
('Cocina Práctica', '+52-55-1234-5678', 'ventas@cocinapractica.com', 'Av. Revolución 890, Mérida, México'),
('Baño Elegante', '+52-55-2345-6789', 'contacto@bañoelegante.com', 'Calle Morelos 123, Cancún, México'),
('Limpieza Total', '+52-33-3456-7890', 'pedidos@limpiezatotal.com', 'Av. Chapultepec 456, Zapopan, México'),
('Herramientas Pro', '+52-81-4567-8901', 'ventas@herramientaspro.com', 'Calle Madero 789, Toluca, México'),
('Camping Aventura', '+52-55-5678-9012', 'info@campingaventura.com', 'Av. Tlalpan 101, CDMX, México'),
('Fitness Activo', '+52-55-6789-0123', 'ventas@fitnessactivo.com', 'Calle 5 de Mayo 234, Guadalajara, México'),
('Música Viva', '+52-33-7890-1234', 'contacto@musicaviva.com', 'Av. Vallarta 567, Monterrey, México'),
('Videojuegos Manía', '+52-81-8901-2345', 'pedidos@videojuegosmania.com', 'Calle Zaragoza 890, Puebla, México'),
('Arte Creativo', '+52-55-9012-3456', 'ventas@artecreativo.com', 'Av. Insurgentes Sur 123, Tijuana, México'),
('Manualidades Únicas', '+52-55-0123-4567', 'info@manualidadesunicas.com', 'Calle Juárez 456, León, México'),
('Bebés Felices', '+52-33-1234-5678', 'ventas@bebesfelices.com', 'Av. México 789, Querétaro, México'),
('Moda Actual', '+52-81-2345-6789', 'contacto@modaactual.com', 'Calle Hidalgo 101, San Luis Potosí, México'),
('Viajes Aventura', '+52-55-3456-7890', 'pedidos@viajesaventura.com', 'Av. Revolución 234, Mérida, México'),
('Fotografía Pro', '+52-55-4567-8901', 'ventas@fotografiapro.com', 'Calle Morelos 567, Cancún, México'),
('Telefonía Móvil', '+52-33-5678-9012', 'info@telefoniamovil.com', 'Av. Chapultepec 890, Zapopan, México'),
('Computadoras Avanzadas', '+52-81-6789-0123', 'ventas@computadorasavanzadas.com', 'Calle Madero 123, Toluca, México'),
('Televisores Smart', '+52-55-7890-1234', 'contacto@televisoressmart.com', 'Av. Tlalpan 456, CDMX, México'),
('Audio Premium', '+52-55-8901-2345', 'pedidos@audiopremium.com', 'Calle 5 de Mayo 789, Guadalajara, México'),
('Cámaras Profesionales', '+52-33-9012-3456', 'ventas@camarasprofesionales.com', 'Av. Vallarta 101, Monterrey, México'),
('Drones Innovadores', '+52-81-0123-4567', 'info@dronesinnovadores.com', 'Calle Zaragoza 234, Puebla, México'),
('Relojes Elegantes', '+52-55-1234-5678', 'ventas@relojeselegantes.com', 'Av. Insurgentes Sur 567, Tijuana, México'),
('Bolsos Modernos', '+52-55-2345-6789', 'contacto@bolsosmodernos.com', 'Calle Juárez 890, León, México'),
('Perfumes Exclusivos', '+52-33-3456-7890', 'pedidos@perfumesexclusivos.com', 'Av. México 123, Querétaro, México'),
('Maquillaje Natural', '+52-81-4567-8901', 'ventas@maquillajenatural.com', 'Calle Hidalgo 456, San Luis Potosí, México'),
('Cuidado Personal', '+52-55-5678-9012', 'info@cuidado-personal.com', 'Av. Revolución 789, Mérida, México'),
('Juegos de Mesa', '+52-55-6789-0123', 'ventas@juegosdemesa.com', 'Calle Morelos 101, Cancún, México'),
('Instrumentos Musicales', '+52-33-7890-1234', 'contacto@instrumentosmusicales.com', 'Av. Chapultepec 234, Zapopan, México'),
('Ropa Deportiva', '+52-81-8901-2345', 'pedidos@ropadeportiva.com', 'Calle Madero 567, Toluca, México'),
('Suplementos Salud', '+52-55-9012-3456', 'ventas@suplementossalud.com', 'Av. Tlalpan 890, CDMX, México'),
('Decoración Hogar', '+52-55-0123-4567', 'info@decoracionhogar.com', 'Calle 5 de Mayo 123, Guadalajara, México');

-- 4. Usuarios (50 registros)
INSERT INTO Usuarios (usuario, contraseña) VALUES
('juan.perez', 'Jperez2025'), ('maria.gomez', 'Mgomez2025'), ('carlos.lopez', 'Clopez2025'), ('ana.martinez', 'Amartinez2025'),
('luis.rodriguez', 'Lrodriguez2025'), ('sofia.hernandez', 'Shernandez2025'), ('diego.garcia', 'Dgarcia2025'), ('laura.fernandez', 'Lfernandez2025'),
('miguel.sanchez', 'Msanchez2025'), ('elena.ramirez', 'Eramirez2025'), ('pedro.torres', 'Ptorres2025'), ('carmen.vazquez', 'Cvazquez2025'),
('javier.ramos', 'Jramos2025'), ('isabel.jimenez', 'Ijimenez2025'), ('antonio.diaz', 'Adiaz2025'), ('sara.moreno', 'Smoreno2025'),
('manuel.munoz', 'Mmunoz2025'), ('lucia.alvarez', 'Lalvarez2025'), ('david.ruiz', 'Druiz2025'), ('paula.serrano', 'Pserrano2025'),
('jose.blanco', 'Jblanco2025'), ('marta.molina', 'Mmolina2025'), ('francisco.delgado', 'Fdelgado2025'), ('cristina.castro', 'Ccastro2025'),
('pablo.ortega', 'Portega2025'), ('marina.rubio', 'Mrubio2025'), ('rafael.sanz', 'Rsanz2025'), ('beatriz.iglesias', 'Biglesias2025'),
('alvaro.campos', 'Acampos2025'), ('clara.soto', 'Csoto2025'), ('adrian.guerrero', 'Aguerrero2025'), ('nerea.reyes', 'Nreyes2025'),
('victor.cruz', 'Vcruz2025'), ('alicia.ortiz', 'Aortiz2025'), ('hugo.castillo', 'Hcastillo2025'), ('daniela.santos', 'Dsantos2025'),
('marcos.gallego', 'Mgallego2025'), ('lorena.vega', 'Lvega2025'), ('ruben.herrera', 'Rherrera2025'), ('irene.nunez', 'Inunez2025'),
('gonzalo.cano', 'Gcano2025'), ('ainhoa.gil', 'Agil2025'), ('iker.rojas', 'Irojas2025'), ('noelia.dominguez', 'Ndominguez2025'),
('oscar.pascual', 'Opascual2025'), ('julia.mendez', 'Jmendez2025'), ('hector.vicente', 'Hvicente2025'), ('claudia.fuentes', 'Cfuentes2025'),
('rodrigo.arias', 'Rarias2025'), ('lidia.pena', 'Lpena2025');

-- 5. Cliente (50 registros)
INSERT INTO Cliente (Nombre, Apellido, ID_TipoCliente) VALUES
('Juan', 'Pérez', 1), ('María', 'Gómez', 2), ('Carlos', 'López', 1), ('Ana', 'Martínez', 2), ('Luis', 'Rodríguez', 1),
('Sofía', 'Hernández', 2), ('Diego', 'García', 1), ('Laura', 'Fernández', 2), ('Miguel', 'Sánchez', 1), ('Elena', 'Ramírez', 2),
('Pedro', 'Torres', 1), ('Carmen', 'Vázquez', 2), ('Javier', 'Ramos', 1), ('Isabel', 'Jiménez', 2), ('Antonio', 'Díaz', 1),
('Sara', 'Moreno', 2), ('Manuel', 'Muñoz', 1), ('Lucía', 'Álvarez', 2), ('David', 'Ruiz', 1), ('Paula', 'Serrano', 2),
('José', 'Blanco', 1), ('Marta', 'Molina', 2), ('Francisco', 'Delgado', 1), ('Cristina', 'Castro', 2), ('Pablo', 'Ortega', 1),
('Marina', 'Rubio', 2), ('Rafael', 'Sanz', 1), ('Beatriz', 'Iglesias', 2), ('Álvaro', 'Campos', 1), ('Clara', 'Soto', 2),
('Adrián', 'Guerrero', 1), ('Nerea', 'Reyes', 2), ('Víctor', 'Cruz', 1), ('Alicia', 'Ortiz', 2), ('Hugo', 'Castillo', 1),
('Daniela', 'Santos', 2), ('Marcos', 'Gallego', 1), ('Lorena', 'Vega', 2), ('Rubén', 'Herrera', 1), ('Irene', 'Núñez', 2),
('Gonzalo', 'Cano', 1), ('Ainhoa', 'Gil', 2), ('Iker', 'Rojas', 1), ('Noelia', 'Domínguez', 2), ('Óscar', 'Pascual', 1),
('Julia', 'Méndez', 2), ('Héctor', 'Vicente', 1), ('Claudia', 'Fuentes', 2), ('Rodrigo', 'Arias', 1), ('Lidia', 'Peña', 2);

-- 6. Producto (50 registros)
INSERT INTO Producto (Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_Catalogo) VALUES
(100, 1, 8000.00, 12000.00, 'Smartphone Galaxy S23', 'Teléfono 5G 128GB', '/images/galaxy_s23.jpg', NULL),
(200, 2, 150.00, 250.00, 'Camiseta Algodón', 'Camiseta unisex talla M', '/images/camiseta_algodon.jpg', NULL),
(500, 3, 20.00, 35.00, 'Arroz Integral', 'Arroz integral 1kg', '/images/arroz_integral.jpg', NULL),
(300, 4, 15.00, 25.00, 'Coca-Cola 2L', 'Refresco de cola 2L', '/images/coca_cola.jpg', NULL),
(50, 5, 1200.00, 1800.00, 'Lámpara LED', 'Lámpara de mesa LED 10W', '/images/lampara_led.jpg', NULL),
(150, 6, 200.00, 350.00, 'Pelota de Fútbol', 'Pelota oficial FIFA', '/images/pelota_futbol.jpg', NULL),
(80, 7, 150.00, 250.00, 'Cien Años de Soledad', 'Novela de Gabriel García Márquez', '/images/cien_anos.jpg', NULL),
(100, 8, 600.00, 900.00, 'Zapatillas Nike', 'Zapatillas running talla 42', '/images/zapatillas_nike.jpg', NULL),
(120, 9, 100.00, 180.00, 'Crema Hidratante', 'Crema facial 50ml', '/images/crema_h facial.jpg', NULL),
(40, 10, 2500.00, 3500.00, 'Batería Auto', 'Batería 12V 60Ah', '/images/bateria_auto.jpg', NULL),
(60, 11, 200.00, 300.00, 'Maceta Cerámica', 'Maceta de 30cm diámetro', '/images/maceta_ceramica.jpg', NULL),
(20, 12, 8000.00, 12000.00, 'Sofá 3 Plazas', 'Sofá de tela gris', '/images/sofa_3plazas.jpg', NULL),
(30, 13, 4000.00, 6000.00, 'Microondas LG', 'Microondas 25L 1000W', '/images/microondas_lg.jpg', NULL),
(50, 14, 1500.00, 2500.00, 'Anillo de Plata', 'Anillo con zafiro', '/images/anillo_plata.jpg', NULL),
(70, 15, 800.00, 1200.00, 'Botas de Cuero', 'Botas negras talla 40', '/images/botas_cuero.jpg', NULL),
(90, 16, 300.00, 500.00, 'Gafas de Sol Ray-Ban', 'Gafas polarizadas', '/images/gafas_rayban.jpg', NULL),
(25, 17, 15000.00, 20000.00, 'Laptop HP', 'Laptop Core i7 16GB RAM', '/images/laptop_hp.jpg', NULL),
(100, 18, 150.00, 250.00, 'Comida para Perros', 'Alimento balanceado 10kg', '/images/comida_perros.jpg', NULL),
(40, 19, 2000.00, 3000.00, 'Silla Ergonómica', 'Silla de oficina ajustable', '/images/silla_ergonomica.jpg', NULL),
(60, 20, 250.00, 400.00, 'Multivitamínico', 'Suplemento 60 cápsulas', '/images/multivitaminico.jpg', NULL),
(80, 21, 350.00, 500.00, 'Sartén Tefal', 'Sartén antiadherente 28cm', '/images/sarten_tefal.jpg', NULL),
(100, 22, 200.00, 300.00, 'Toalla de Baño', 'Toalla de algodón 70x140cm', '/images/toalla_baño.jpg', NULL),
(200, 23, 50.00, 80.00, 'Detergente Ariel', 'Detergente líquido 3L', '/images/detergente_ariel.jpg', NULL),
(50, 24, 800.00, 1200.00, 'Taladro Bosch', 'Taladro eléctrico 600W', '/images/taladro_bosch.jpg', NULL),
(60, 25, 1500.00, 2200.00, 'Tienda de Campaña', 'Tienda para 4 personas', '/images/tienda_campaña.jpg', NULL),
(70, 26, 600.00, 900.00, 'Mancuernas 10kg', 'Par de mancuernas ajustables', '/images/mancuernas_10kg.jpg', NULL),
(30, 27, 4000.00, 6000.00, 'Guitarra Yamaha', 'Guitarra acústica 41"', '/images/guitarra_yamaha.jpg', NULL),
(20, 28, 5000.00, 7500.00, 'PlayStation 5', 'Consola de videojuegos 1TB', '/images/playstation5.jpg', NULL),
(80, 29, 100.00, 150.00, 'Pintura Acrílica', 'Pintura 500ml varios colores', '/images/pintura_acrilica.jpg', NULL),
(100, 30, 50.00, 80.00, 'Tijeras Fiskars', 'Tijeras para manualidades', '/images/tijeras_fiskars.jpg', NULL),
(40, 31, 2500.00, 3500.00, 'Cuna Convertible', 'Cuna para bebé 3 en 1', '/images/cuna_convertible.jpg', NULL),
(60, 32, 300.00, 450.00, 'Vestido Floral', 'Vestido de verano talla M', '/images/vestido_floral.jpg', NULL),
(50, 33, 1000.00, 1500.00, 'Maleta Samsonite', 'Maleta rígida 70cm', '/images/maleta_samsonite.jpg', NULL),
(30, 34, 8000.00, 12000.00, 'Cámara Canon', 'Cámara réflex 24MP', '/images/camara_canon.jpg', NULL),
(20, 35, 10000.00, 15000.00, 'iPhone 15', 'Smartphone 256GB', '/images/iphone_15.jpg', NULL),
(25, 36, 15000.00, 20000.00, 'PC Gamer ASUS', 'PC con RTX 3060', '/images/pc_gamer_asus.jpg', NULL),
(15, 37, 12000.00, 18000.00, 'Smart TV Samsung', 'Televisor 4K 55"', '/images/smart_tv_samsung.jpg', NULL),
(40, 38, 1500.00, 2200.00, 'Auriculares Bose', 'Auriculares inalámbricos', '/images/auriculares_bose.jpg', NULL),
(30, 39, 10000.00, 15000.00, 'Cámara Nikon', 'Cámara réflex 36MP', '/images/camara_nikon.jpg', NULL),
(20, 40, 12000.00, 18000.00, 'Drone DJI', 'Drone con cámara 4K', '/images/drone_dji.jpg', NULL),
(50, 41, 2000.00, 3000.00, 'Reloj Casio', 'Reloj analógico clásico', '/images/reloj_casio.jpg', NULL),
(60, 42, 800.00, 1200.00, 'Bolso Michael Kors', 'Bolso de mano cuero', '/images/bolso_michaelkors.jpg', NULL),
(70, 43, 500.00, 800.00, 'Perfume Dior', 'Perfume 100ml', '/images/perfume_dior.jpg', NULL),
(80, 44, 200.00, 300.00, 'Base Maybelline', 'Base de maquillaje 30ml', '/images/base_maybelline.jpg', NULL),
(100, 45, 150.00, 250.00, 'Cepillo Oral-B', 'Cepillo eléctrico', '/images/cepillo_oralb.jpg', NULL),
(50, 46, 300.00, 450.00, 'Catan', 'Juego de mesa estratégico', '/images/catan.jpg', NULL),
(30, 47, 5000.00, 7500.00, 'Violín Stradivarius', 'Violín clásico 4/4', '/images/violin_stradivarius.jpg', NULL),
(60, 48, 400.00, 600.00, 'Conjunto Adidas', 'Ropa deportiva talla M', '/images/conjunto_adidas.jpg', NULL),
(70, 49, 500.00, 800.00, 'Proteína Whey', 'Suplemento 900g', '/images/proteina_whey.jpg', NULL),
(40, 50, 600.00, 900.00, 'Cuadro Moderno', 'Cuadro decorativo 50x70cm', '/images/cuadro_moderno.jpg', NULL);

-- 7. catalogo (50 registros)
INSERT INTO catalogo (ID_Producto, Descripcion, Precio_Producto, Imagen) VALUES
(1, 'Smartphone Samsung Galaxy S23 5G 128GB', 12000.00, '/images/galaxy_s23.jpg'),
(2, 'Camiseta de algodón orgánico talla M', 250.00, '/images/camiseta_algodon.jpg'),
(3, 'Arroz integral de grano largo 1kg', 35.00, '/images/arroz_integral.jpg'),
(4, 'Coca-Cola sin azúcar 2L', 25.00, '/images/coca_cola.jpg'),
(5, 'Lámpara LED regulable 10W', 1800.00, '/images/lampara_led.jpg'),
(6, 'Pelota de fútbol oficial FIFA', 350.00, '/images/pelota_futbol.jpg'),
(7, 'Cien Años de Soledad, edición especial', 250.00, '/images/cien_anos.jpg'),
(8, 'Zapatillas Nike Air Max talla 42', 900.00, '/images/zapatillas_nike.jpg'),
(9, 'Crema hidratante facial 50ml', 180.00, '/images/crema_h facial.jpg'),
(10, 'Batería para auto 12V 60Ah', 3500.00, '/images/bateria_auto.jpg'),
(11, 'Maceta de cerámica artesanal 30cm', 300.00, '/images/maceta_ceramica.jpg'),
(12, 'Sofá de tela gris 3 plazas', 12000.00, '/images/sofa_3plazas.jpg'),
(13, 'Microondas LG 25L 1000W', 6000.00, '/images/microondas_lg.jpg'),
(14, 'Anillo de plata con zafiro natural', 2500.00, '/images/anillo_plata.jpg'),
(15, 'Botas de cuero negras talla 40', 1200.00, '/images/botas_cuero.jpg'),
(16, 'Gafas de sol Ray-Ban polarizadas', 500.00, '/images/gafas_rayban.jpg'),
(17, 'Laptop HP Core i7 16GB RAM', 20000.00, '/images/laptop_hp.jpg'),
(18, 'Comida para perros balanceada 10kg', 250.00, '/images/comida_perros.jpg'),
(19, 'Silla ergonómica ajustable', 3000.00, '/images/silla_ergonomica.jpg'),
(20, 'Multivitamínico 60 cápsulas', 400.00, '/images/multivitaminico.jpg'),
(21, 'Sartén Tefal antiadherente 28cm', 500.00, '/images/sarten_tefal.jpg'),
(22, 'Toalla de baño 100% algodón', 300.00, '/images/toalla_baño.jpg'),
(23, 'Detergente Ariel líquido 3L', 80.00, '/images/detergente_ariel.jpg'),
(24, 'Taladro Bosch 600W con accesorios', 1200.00, '/images/taladro_bosch.jpg'),
(25, 'Tienda de campaña para 4 personas', 2200.00, '/images/tienda_campaña.jpg'),
(26, 'Mancuernas ajustables 10kg', 900.00, '/images/mancuernas_10kg.jpg'),
(27, 'Guitarra Yamaha acústica 41"', 6000.00, '/images/guitarra_yamaha.jpg'),
(28, 'PlayStation 5 con 1TB almacenamiento', 7500.00, '/images/playstation5.jpg'),
(29, 'Pintura acrílica 500ml varios colores', 150.00, '/images/pintura_acrilica.jpg'),
(30, 'Tijeras Fiskars para manualidades', 80.00, '/images/tijeras_fiskars.jpg'),
(31, 'Cuna convertible 3 en 1 para bebé', 3500.00, '/images/cuna_convertible.jpg'),
(32, 'Vestido floral de verano talla M', 450.00, '/images/vestido_floral.jpg'),
(33, 'Maleta Samsonite rígida 70cm', 1500.00, '/images/maleta_samsonite.jpg'),
(34, 'Cámara Canon réflex 24MP', 12000.00, '/images/camara_canon.jpg'),
(35, 'iPhone 15 256GB negro espacial', 15000.00, '/images/iphone_15.jpg'),
(36, 'PC Gamer ASUS con RTX 3060', 20000.00, '/images/pc_gamer_asus.jpg'),
(37, 'Smart TV Samsung 4K 55 pulgadas', 18000.00, '/images/smart_tv_samsung.jpg'),
(38, 'Auriculares Bose inalámbricos', 2200.00, '/images/auriculares_bose.jpg'),
(39, 'Cámara Nikon réflex 36MP', 15000.00, '/images/camara_nikon.jpg'),
(40, 'Drone DJI con cámara 4K', 18000.00, '/images/drone_dji.jpg'),
(41, 'Reloj Casio analógico clásico', 3000.00, '/images/reloj_casio.jpg'),
(42, 'Bolso Michael Kors de cuero', 1200.00, '/images/bolso_michaelkors.jpg'),
(43, 'Perfume Dior Sauvage 100ml', 800.00, '/images/perfume_dior.jpg'),
(44, 'Base Maybelline Fit Me 30ml', 300.00, '/images/base_maybelline.jpg'),
(45, 'Cepillo Oral-B eléctrico recargable', 250.00, '/images/cepillo_oralb.jpg'),
(46, 'Catan, juego de mesa estratégico', 450.00, '/images/catan.jpg'),
(47, 'Violín Stradivarius clásico 4/4', 7500.00, '/images/violin_stradivarius.jpg'),
(48, 'Conjunto Adidas deportivo talla M', 600.00, '/images/conjunto_adidas.jpg'),
(49, 'Proteína Whey 900g chocolate', 800.00, '/images/proteina_whey.jpg'),
(50, 'Cuadro decorativo moderno 50x70cm', 900.00, '/images/cuadro_moderno.jpg');

-- 8. calificaciones (50 registros)
INSERT INTO calificaciones (Calificacion, Comentario, ID_Producto) VALUES
(5, 'Excelente smartphone, muy rápido', 1),
(4, 'Camiseta cómoda, buena calidad', 2),
(3, 'Arroz de buena calidad, pero caro', 3),
(5, 'Refresco muy refrescante', 4),
(4, 'Lámpara con gran diseño', 5),
(5, 'Pelota resistente y de buen rebote', 6),
(4, 'Libro fascinante, gran edición', 7),
(5, 'Zapatillas muy cómodas', 8),
(3, 'Crema hidratante aceptable', 9),
(5, 'Batería con excelente duración', 10),
(4, 'Maceta elegante y resistente', 11),
(5, 'Sofá muy cómodo y moderno', 12),
(4, 'Microondas fácil de usar', 13),
(5, 'Anillo hermoso, gran calidad', 14),
(4, 'Botas duraderas y elegantes', 15),
(3, 'Gafas bonitas pero frágiles', 16),
(5, 'Laptop potente y ligera', 17),
(4, 'Comida para perros de calidad', 18),
(5, 'Silla muy ergonómica', 19),
(4, 'Vitaminas efectivas', 20),
(5, 'Sartén excelente, no se pega', 21),
(4, 'Toalla muy suave', 22),
(3, 'Detergente normal, nada especial', 23),
(5, 'Taladro potente y versátil', 24),
(4, 'Tienda fácil de montar', 25),
(5, 'Mancuernas de gran calidad', 26),
(4, 'Guitarra con excelente sonido', 27),
(5, 'Consola con gráficos increíbles', 28),
(3, 'Pintura de calidad media', 29),
(4, 'Tijeras muy precisas', 30),
(5, 'Cuna segura y práctica', 31),
(4, 'Vestido elegante y cómodo', 32),
(5, 'Maleta resistente y ligera', 33),
(4, 'Cámara con gran resolución', 34),
(5, 'iPhone con excelente cámara', 35),
(4, 'PC ideal para gaming', 36),
(5, 'Televisor con imagen espectacular', 37),
(4, 'Auriculares con buen sonido', 38),
(5, 'Cámara réflex profesional', 39),
(4, 'Drone fácil de volar', 40),
(5, 'Reloj con diseño elegante', 41),
(4, 'Bolso muy moderno', 42),
(5, 'Perfume con aroma duradero', 43),
(4, 'Base de maquillaje ligera', 44),
(3, 'Cepillo aceptable, batería regular', 45),
(5, 'Juego de mesa muy divertido', 46),
(4, 'Violín con gran sonido', 47),
(5, 'Ropa deportiva muy cómoda', 48),
(4, 'Proteína de buen sabor', 49),
(5, 'Cuadro muy decorativo', 50);

-- 9. Compra_factura (50 registros)
INSERT INTO Compra_factura (ID_Proveedores, fecha_compra, total_compra) VALUES
(1, '2025-05-01 09:00:00', 80000.00),
(2, '2025-05-02 10:00:00', 3000.00),
(3, '2025-05-03 11:00:00', 10000.00),
(4, '2025-05-04 12:00:00', 4500.00),
(5, '2025-05-05 13:00:00', 60000.00),
(6, '2025-05-06 14:00:00', 3000.00),
(7, '2025-05-07 15:00:00', 12000.00),
(8, '2025-05-08 16:00:00', 18000.00),
(9, '2025-05-09 17:00:00', 3000.00),
(10, '2025-05-10 18:00:00', 100000.00),
(11, '2025-05-11 09:00:00', 12000.00),
(12, '2025-05-12 10:00:00', 160000.00),
(13, '2025-05-13 11:00:00', 120000.00),
(14, '2025-05-14 12:00:00', 75000.00),
(15, '2025-05-15 13:00:00', 24000.00),
(16, '2025-05-16 14:00:00', 9000.00),
(17, '2025-05-17 15:00:00', 375000.00),
(18, '2025-05-18 16:00:00', 15000.00),
(19, '2025-05-19 17:00:00', 80000.00),
(20, '2025-05-20 18:00:00', 15000.00),
(21, '2025-05-21 09:00:00', 17500.00),
(22, '2025-05-22 10:00:00', 6000.00),
(23, '2025-05-23 11:00:00', 10000.00),
(24, '2025-05-24 12:00:00', 24000.00),
(25, '2025-05-25 13:00:00', 30000.00),
(26, '2025-05-26 14:00:00', 18000.00),
(27, '2025-05-27 15:00:00', 120000.00),
(28, '2025-05-28 16:00:00', 100000.00),
(29, '2025-05-29 17:00:00', 3000.00),
(30, '2025-05-30 18:00:00', 5000.00),
(31, '2025-05-31 09:00:00', 50000.00),
(32, '2025-06-01 10:00:00', 6000.00),
(33, '2025-06-02 11:00:00', 20000.00),
(34, '2025-06-03 12:00:00', 240000.00),
(35, '2025-06-04 13:00:00', 200000.00),
(36, '2025-06-05 14:00:00', 450000.00),
(37, '2025-06-06 15:00:00', 360000.00),
(38, '2025-06-07 16:00:00', 60000.00),
(39, '2025-06-08 17:00:00', 300000.00),
(40, '2025-06-09 18:00:00', 240000.00),
(41, '2025-06-10 09:00:00', 60000.00),
(42, '2025-06-11 10:00:00', 24000.00),
(43, '2025-06-12 11:00:00', 10000.00),
(44, '2025-06-13 12:00:00', 6000.00),
(45, '2025-06-14 13:00:00', 6000.00),
(46, '2025-06-15 14:00:00', 9000.00),
(47, '2025-06-16 15:00:00', 150000.00),
(48, '2025-06-17 16:00:00', 12000.00),
(49, '2025-06-18 17:00:00', 15000.00),
(50, '2025-06-19 18:00:00', 18000.00);

-- 10. Venta_factura (50 registros)
INSERT INTO Venta_factura (ID_Cliente, fecha_venta, total_venta) VALUES
(1, '2025-06-01 09:00:00', 12000.00),
(2, '2025-06-01 10:00:00', 500.00),
(3, '2025-06-01 11:00:00', 175.00),
(4, '2025-06-01 12:00:00', 75.00),
(5, '2025-06-01 13:00:00', 1800.00),
(6, '2025-06-01 14:00:00', 700.00),
(7, '2025-06-01 15:00:00', 250.00),
(8, '2025-06-01 16:00:00', 900.00),
(9, '2025-06-01 17:00:00', 180.00),
(10, '2025-06-01 18:00:00', 3500.00),
(11, '2025-06-02 09:00:00', 300.00),
(12, '2025-06-02 10:00:00', 12000.00),
(13, '2025-06-02 11:00:00', 6000.00),
(14, '2025-06-02 12:00:00', 2500.00),
(15, '2025-06-02 13:00:00', 1200.00),
(16, '2025-06-02 14:00:00', 500.00),
(17, '2025-06-02 15:00:00', 20000.00),
(18, '2025-06-02 16:00:00', 250.00),
(19, '2025-06-02 17:00:00', 3000.00),
(20, '2025-06-02 18:00:00', 400.00),
(21, '2025-06-03 09:00:00', 500.00),
(22, '2025-06-03 10:00:00', 300.00),
(23, '2025-06-03 11:00:00', 80.00),
(24, '2025-06-03 12:00:00', 1200.00),
(25, '2025-06-03 13:00:00', 2200.00),
(26, '2025-06-03 14:00:00', 900.00),
(27, '2025-06-03 15:00:00', 6000.00),
(28, '2025-06-03 16:00:00', 7500.00),
(29, '2025-06-03 17:00:00', 150.00),
(30, '2025-06-03 18:00:00', 80.00),
(31, '2025-06-04 09:00:00', 3500.00),
(32, '2025-06-04 10:00:00', 450.00),
(33, '2025-06-04 11:00:00', 1500.00),
(34, '2025-06-04 12:00:00', 12000.00),
(35, '2025-06-04 13:00:00', 15000.00),
(36, '2025-06-04 14:00:00', 20000.00),
(37, '2025-06-04 15:00:00', 18000.00),
(38, '2025-06-04 16:00:00', 2200.00),
(39, '2025-06-04 17:00:00', 15000.00),
(40, '2025-06-04 18:00:00', 18000.00),
(41, '2025-06-05 09:00:00', 3000.00),
(42, '2025-06-05 10:00:00', 1200.00),
(43, '2025-06-05 11:00:00', 800.00),
(44, '2025-06-05 12:00:00', 300.00),
(45, '2025-06-05 13:00:00', 250.00),
(46, '2025-06-05 14:00:00', 450.00),
(47, '2025-06-05 15:00:00', 7500.00),
(48, '2025-06-05 16:00:00', 600.00),
(49, '2025-06-05 17:00:00', 800.00),
(50, '2025-06-05 18:00:00', 900.00);

-- 11. detalle_venta_factura (50 registros)
INSERT INTO detalle_venta_factura (ID_Producto, Cantidad, NumeroFactura, PrecioVenta) VALUES
(1, 1, 1, 12000.00),
(2, 2, 2, 250.00),
(3, 5, 3, 35.00),
(4, 3, 4, 25.00),
(5, 1, 5, 1800.00),
(6, 2, 6, 350.00),
(7, 1, 7, 250.00),
(8, 1, 8, 900.00),
(9, 1, 9, 180.00),
(10, 1, 10, 3500.00),
(11, 1, 11, 300.00),
(12, 1, 12, 12000.00),
(13, 1, 13, 6000.00),
(14, 1, 14, 2500.00),
(15, 1, 15, 1200.00),
(16, 1, 16, 500.00),
(17, 1, 17, 20000.00),
(18, 1, 18, 250.00),
(19, 1, 19, 3000.00),
(20, 1, 20, 400.00),
(21, 1, 21, 500.00),
(22, 1, 22, 300.00),
(23, 1, 23, 80.00),
(24, 1, 24, 1200.00),
(25, 1, 25, 2200.00),
(26, 1, 26, 900.00),
(27, 1, 27, 6000.00),
(28, 1, 28, 7500.00),
(29, 1, 29, 150.00),
(30, 1, 30, 80.00),
(31, 1, 31, 3500.00),
(32, 1, 32, 450.00),
(33, 1, 33, 1500.00),
(34, 1, 34, 12000.00),
(35, 1, 35, 15000.00),
(36, 1, 36, 20000.00),
(37, 1, 37, 18000.00),
(38, 1, 38, 2200.00),
(39, 1, 39, 15000.00),
(40, 1, 40, 18000.00),
(41, 1, 41, 3000.00),
(42, 1, 42, 1200.00),
(43, 1, 43, 800.00),
(44, 1, 44, 300.00),
(45, 1, 45, 250.00),
(46, 1, 46, 450.00),
(47, 1, 47, 7500.00),
(48, 1, 48, 600.00),
(49, 1, 49, 800.00),
(50, 1, 50, 900.00);

-- 12. DetalleCompraFactura (50 registros)
INSERT INTO DetalleCompraFactura (Cantidad, PrecioCompra, ID_CompraFactura, ID_Producto) VALUES
(10, 8000.00, 1, 1),
(20, 150.00, 2, 2),
(50, 20.00, 3, 3),
(30, 15.00, 4, 4),
(5, 1200.00, 5, 5),
(10, 200.00, 6, 6),
(10, 150.00, 7, 7),
(10, 600.00, 8, 8),
(15, 100.00, 9, 9),
(5, 2500.00, 10, 10),
(10, 200.00, 11, 11),
(2, 8000.00, 12, 12),
(3, 4000.00, 13, 13),
(5, 1500.00, 14, 14),
(5, 800.00, 15, 15),
(10, 300.00, 16, 16),
(3, 15000.00, 17, 17),
(20, 150.00, 18, 18),
(5, 2000.00, 19, 19),
(10, 250.00, 20, 20),
(5, 350.00, 21, 21),
(10, 200.00, 22, 22),
(20, 50.00, 23, 23),
(5, 800.00, 24, 24),
(5, 1500.00, 25, 25),
(5, 600.00, 26, 26),
(3, 4000.00, 27, 27),
(2, 5000.00, 28, 28),
(10, 100.00, 29, 29),
(10, 50.00, 30, 30),
(5, 2500.00, 31, 31),
(10, 300.00, 32, 32),
(5, 1000.00, 33, 33),
(3, 8000.00, 34, 34),
(3, 10000.00, 35, 35),
(3, 15000.00, 36, 36),
(2, 12000.00, 37, 37),
(5, 1500.00, 38, 38),
(3, 10000.00, 39, 39),
(2, 12000.00, 40, 40),
(5, 2000.00, 41, 41),
(5, 800.00, 42, 42),
(10, 500.00, 43, 43),
(10, 200.00, 44, 44),
(10, 150.00, 45, 45),
(5, 300.00, 46, 46),
(2, 5000.00, 47, 47),
(5, 400.00, 48, 48),
(5, 500.00, 49, 49),
(5, 600.00, 50, 50);
