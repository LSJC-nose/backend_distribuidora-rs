Create database RS_DataMart;
use RS_DataMart;

CREATE TABLE Hecho_Venta (
     NumeroFactura INT ,
    ID_Cliente INT ,
    ID_Detalle INT,
    ID_Tiempo INT,
    ID_Producto INT ,
    Cantidad INT NOT NULL,
	PrecioVenta DOUBLE NULL,
    fecha_venta datetime,
    Total int,
    PRIMARY KEY (NumeroFactura, ID_Detalle)
);


CREATE TABLE Dim_Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    ID_tipoCliente Int NOT NULL
);


CREATE TABLE Dim_Producto (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Stock INT NULL,
    ID_Categoria INT NULL,
    PrecioCompra DOUBLE NULL,
    PrecioVenta DOUBLE NULL,
    nombreProducto VARCHAR(30) NULL,
    Descripcion VARCHAR(60) NULL
);


create table Dim_Tiempo (
ID_Tiempo INT PRIMARY KEY auto_increment,
fecha Date,
año INT,
mes INT(20),
dia INT,
trimestre INT,
nombre_mes Varchar(20),
dia_semana Varchar(20)
);


Alter table Hecho_Venta
ADD CONSTRAINT FK_Producto
FOREIGN KEY (ID_Producto) REFERENCES Dim_Producto(ID_Producto);

Alter table Hecho_Venta
ADD CONSTRAINT FK_Cliente
FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente);

Alter table Hecho_Venta
ADD CONSTRAINT FK_Tiempo
FOREIGN KEY (ID_Tiempo) REFERENCES Dim_Tiempo(ID_Tiempo);



