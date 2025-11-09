ALTER TABLE Facturas ADD CostoEnvio DECIMAL(10,2);

ALTER TABLE Facturas ADD CONSTRAINT UQ_Facturas_PedidoID UNIQUE (PedidoID);

DROP TRIGGER IF EXISTS trg_GenerarFactura;
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
    SELECT @Subtotal = ISNULL(SUM(Cantidad * PrecioUnitario), 0)
    FROM DetallePedido
    WHERE PedidoID = @PedidoID;
    
    DECLARE @Impuesto DECIMAL(10,2) = @Subtotal * 0.15;
    DECLARE @CostoEnvio DECIMAL(10,2) = 100.00;
    DECLARE @Total DECIMAL(10,2) = @Subtotal + @Impuesto + @CostoEnvio;
    
    IF @Subtotal > 0
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Facturas WHERE PedidoID = @PedidoID)
        BEGIN
            INSERT INTO Facturas (PedidoID, Subtotal, CostoEnvio, Impuesto, Total, Estado)
            VALUES (@PedidoID, @Subtotal, @CostoEnvio, @Impuesto, @Total, 'Pendiente');
        END
        ELSE
        BEGIN
            UPDATE Facturas 
            SET Subtotal = @Subtotal, 
                CostoEnvio = @CostoEnvio,
                Impuesto = @Impuesto, 
                Total = @Total,
                FechaFactura = GETDATE()
            WHERE PedidoID = @PedidoID;
        END
    END
END;
GO

INSERT INTO Usuarios (Nombre, Email, PasswordHash, Telefono, RolID) 
VALUES ('Cliente Invitado', 'invitado@temp.com', 'nohash', '0000-0000', 2);
