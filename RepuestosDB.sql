IF DB_ID('RepuestosDB') IS NOT NULL
    DROP DATABASE RepuestosDB;
GO

CREATE DATABASE RepuestosDB;
GO

USE RepuestosDB;
GO

IF OBJECT_ID('DetallePedido', 'U') IS NOT NULL DROP TABLE DetallePedido;
IF OBJECT_ID('Facturas', 'U') IS NOT NULL DROP TABLE Facturas;
IF OBJECT_ID('Pedidos', 'U') IS NOT NULL DROP TABLE Pedidos;
IF OBJECT_ID('Productos', 'U') IS NOT NULL DROP TABLE Productos;
IF OBJECT_ID('DireccionesEnvio', 'U') IS NOT NULL DROP TABLE DireccionesEnvio;
IF OBJECT_ID('Usuarios', 'U') IS NOT NULL DROP TABLE Usuarios;
IF OBJECT_ID('MetodosPago', 'U') IS NOT NULL DROP TABLE MetodosPago;
IF OBJECT_ID('Roles', 'U') IS NOT NULL DROP TABLE Roles;
GO

CREATE TABLE Roles (
    RolID INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol NVARCHAR(50) NOT NULL
);

CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Telefono NVARCHAR(20) NOT NULL,
    RolID INT NOT NULL,
    FOREIGN KEY (RolID) REFERENCES Roles(RolID)
);

CREATE TABLE DireccionesEnvio (
    DireccionID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    Direccion NVARCHAR(255) NOT NULL,
    Ciudad NVARCHAR(100) NOT NULL,
    Departamento NVARCHAR(100) NOT NULL,
    CodigoPostal NVARCHAR(10),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE MetodosPago (
    MetodoPagoID INT IDENTITY(1,1) PRIMARY KEY,
    Metodo NVARCHAR(50) NOT NULL
);

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    Categoria NVARCHAR(50),
    ImagenURL NVARCHAR(255)
);

CREATE TABLE Pedidos (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    DireccionID INT NOT NULL,
    MetodoPagoID INT NOT NULL,
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    FechaPedido DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (DireccionID) REFERENCES DireccionesEnvio(DireccionID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodosPago(MetodoPagoID)
);

CREATE TABLE DetallePedido (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE Facturas (
    FacturaID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    FechaFactura DATETIME DEFAULT GETDATE(),
    Subtotal DECIMAL(10,2) NOT NULL,
    Impuesto DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);
GO

CREATE TRIGGER trg_ReducirStock
ON DetallePedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE P
    SET P.Stock = P.Stock - I.Cantidad
    FROM Productos P
    INNER JOIN inserted I ON P.ProductoID = I.ProductoID;
END;
GO

CREATE TRIGGER trg_GenerarFactura
ON DetallePedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PedidoID INT;
    SELECT @PedidoID = PedidoID FROM inserted;

    DECLARE @Subtotal DECIMAL(10,2);
    SELECT @Subtotal = ISNULL(SUM(Cantidad * PrecioUnitario),0)
    FROM DetallePedido
    WHERE PedidoID = @PedidoID;

    DECLARE @Impuesto DECIMAL(10,2) = @Subtotal * 0.15;
    DECLARE @Total DECIMAL(10,2) = @Subtotal + @Impuesto;

    IF @Subtotal > 0
    BEGIN
        INSERT INTO Facturas (PedidoID, Subtotal, Impuesto, Total, Estado)
        VALUES (@PedidoID, @Subtotal, @Impuesto, @Total, 'Pendiente');
    END
END;
GO

INSERT INTO Roles (NombreRol) VALUES ('Vendedor'), ('Comprador');

INSERT INTO Usuarios (Nombre, Email, PasswordHash, Telefono, RolID) VALUES
('Juan Pérez', 'juanperez@repuestos.com', 'hash123', '9999-1111', 1),
('Carlos López', 'carlos@gmail.com', 'hash456', '8888-2222', 2),
('María García', 'maria@gmail.com', 'hash789', '8777-3333', 2),
('Pedro Sánchez', 'pedro@gmail.com', 'hash321', '8666-4444', 2);

INSERT INTO DireccionesEnvio (UsuarioID, Direccion, Ciudad, Departamento, CodigoPostal) VALUES
(2, 'Col. Centro, Calle Principal #123', 'Tegucigalpa', 'Francisco Morazán', '11101'),
(3, 'Barrio Abajo, Avenida 4', 'San Pedro Sula', 'Cortés', '21101'),
(4, 'Residencial Los Pinos, Casa #45', 'La Ceiba', 'Atlántida', '31101');

INSERT INTO MetodosPago (Metodo) VALUES
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Efectivo contra entrega');

INSERT INTO Productos (NombreProducto, Descripcion, Precio, Stock, Categoria, ImagenURL) VALUES
('Filtro de aceite', 'Filtro de aceite para motor 1.6L', 250.00, 40, 'Filtros', 'filtro_aceite.jpg'),
('Filtro de aire', 'Filtro de aire de alto rendimiento', 320.00, 30, 'Filtros', 'filtro_aire.jpg'),
('Bujía NGK', 'Bujía estándar para motor gasolina', 150.00, 100, 'Encendido', 'bujia_ngk.jpg'),
('Pastillas de freno', 'Juego de pastillas de freno delanteras', 850.00, 25, 'Frenos', 'pastillas_freno.jpg'),
('Disco de freno', 'Disco ventilado delantero 280mm', 1200.00, 20, 'Frenos', 'disco_freno.jpg'),
('Amortiguador delantero', 'Amortiguador hidráulico delantero', 2100.00, 15, 'Suspensión', 'amortiguador.jpg'),
('Batería 12V 60Ah', 'Batería libre de mantenimiento', 3200.00, 10, 'Eléctrico', 'bateria.jpg'),
('Aceite sintético 5W30', 'Aceite sintético premium 1L', 450.00, 60, 'Lubricantes', 'aceite_5w30.jpg'),
('Radiador aluminio', 'Radiador de aluminio con ventilador', 5400.00, 8, 'Refrigeración', 'radiador.jpg'),
('Alternador', 'Alternador 12V 90A para motor gasolina', 6500.00, 5, 'Eléctrico', 'alternador.jpg'),
('Clutch kit', 'Kit completo de clutch (disco y prensa)', 4800.00, 7, 'Transmisión', 'clutch.jpg'),
('Correa de distribución', 'Correa reforzada para motor 2.0L', 1500.00, 18, 'Motor', 'correa.jpg'),
('Sensor de oxígeno', 'Sensor de oxígeno universal 4 pines', 2300.00, 12, 'Sensores', 'sensor_oxigeno.jpg'),
('Parabrisas delantero', 'Vidrio templado para sedan', 7200.00, 3, 'Carrocería', 'parabrisas.jpg'),
('Espejo retrovisor', 'Espejo retrovisor eléctrico izquierdo', 1800.00, 6, 'Carrocería', 'retrovisor.jpg');

INSERT INTO Pedidos (UsuarioID, DireccionID, MetodoPagoID, Estado) VALUES
(2, 1, 1, 'Pendiente'),
(3, 2, 2, 'Completado'),
(4, 3, 3, 'Enviado');

INSERT INTO DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario) VALUES
(1, 1, 2, 250.00),
(1, 3, 4, 150.00),
(2, 4, 1, 850.00),
(2, 7, 1, 3200.00),
(3, 8, 3, 450.00);
GO
