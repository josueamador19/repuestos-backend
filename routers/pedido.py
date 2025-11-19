from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List
from db import get_connection

router_pedidos = APIRouter(prefix="/pedidos", tags=["Pedidos"])


class ProductoPedido(BaseModel):
    producto_id: int
    cantidad: int
    precio_unitario: float


class PedidoInvitadoCreate(BaseModel):
    nombre_cliente: str
    email: str
    telefono: str
    direccion: str
    ciudad: str
    departamento: str
    codigo_postal: str = None
    metodo_pago_id: int
    productos: List[ProductoPedido]


class PedidoUsuarioCreate(BaseModel):
    usuario_id: int
    direccion_id: int
    metodo_pago_id: int
    productos: List[ProductoPedido]


class DireccionCreate(BaseModel):
    usuario_id: int
    direccion: str
    ciudad: str
    departamento: str
    codigo_postal: str = None


# -------------------------------
# PEDIDO INVITADO
# -------------------------------
@router_pedidos.post("/invitado/")
def crear_pedido_invitado(pedido: PedidoInvitadoCreate):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Buscar usuario invitado
        cursor.execute("SELECT UsuarioID FROM Usuarios WHERE Email = 'invitado@temp.com'")
        result = cursor.fetchone()

        if result:
            usuario_id = result[0]
        else:
            cursor.execute("""
                INSERT INTO Usuarios (Nombre, Email, PasswordHash, Telefono, RolID)
                OUTPUT INSERTED.UsuarioID
                VALUES ('Cliente Invitado', 'invitado@temp.com', 'nohash', '0000-0000', 2)
            """)
            usuario_id = cursor.fetchone()[0]

        # Crear dirección
        cursor.execute("""
            INSERT INTO DireccionesEnvio (UsuarioID, Direccion, Ciudad, Departamento, CodigoPostal)
            OUTPUT INSERTED.DireccionID
            VALUES (%s, %s, %s, %s, %s)
        """, (usuario_id, pedido.direccion, pedido.ciudad, pedido.departamento, pedido.codigo_postal))
        direccion_id = cursor.fetchone()[0]

        # Crear pedido
        cursor.execute("""
            INSERT INTO Pedidos (UsuarioID, DireccionID, MetodoPagoID, Estado, EmailInvitado)
            OUTPUT INSERTED.PedidoID
            VALUES (%s, %s, %s, 'Pendiente', %s)
        """, (usuario_id, direccion_id, pedido.metodo_pago_id, pedido.email))
        pedido_id = cursor.fetchone()[0]

        # Detalle del pedido
        for producto in pedido.productos:
            cursor.execute("""
                INSERT INTO DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario)
                VALUES (%s, %s, %s, %s)
            """, (pedido_id, producto.producto_id, producto.cantidad, producto.precio_unitario))

        conn.commit()

        return {
            "pedido_id": pedido_id,
            "mensaje": "Pedido creado exitosamente",
            "estado": "Pendiente"
        }

    except Exception as e:
        if conn:
            conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error al crear pedido: {str(e)}")
    finally:
        if conn:
            conn.close()


# -------------------------------
# PEDIDO DE USUARIO
# -------------------------------
@router_pedidos.post("/usuario/")
def crear_pedido_usuario(pedido: PedidoUsuarioCreate):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO Pedidos (UsuarioID, DireccionID, MetodoPagoID, Estado)
            OUTPUT INSERTED.PedidoID
            VALUES (%s, %s, %s, 'Pendiente')
        """, (pedido.usuario_id, pedido.direccion_id, pedido.metodo_pago_id))
        pedido_id = cursor.fetchone()[0]

        # Detalle del pedido
        for producto in pedido.productos:
            cursor.execute("""
                INSERT INTO DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario)
                VALUES (%s, %s, %s, %s)
            """, (pedido_id, producto.producto_id, producto.cantidad, producto.precio_unitario))

        conn.commit()

        return {
            "pedido_id": pedido_id,
            "mensaje": "Pedido creado exitosamente",
            "estado": "Pendiente"
        }

    except Exception as e:
        if conn:
            conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error al crear pedido: {str(e)}")
    finally:
        if conn:
            conn.close()


# -------------------------------
# PEDIDOS POR USUARIO
# -------------------------------
@router_pedidos.get("/usuario/{usuario_id}")
def obtener_pedidos_usuario(usuario_id: int):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT p.PedidoID, p.FechaPedido, p.Estado, 
                   ISNULL(f.Total, 0) as Total
            FROM Pedidos p
            LEFT JOIN Facturas f ON p.PedidoID = f.PedidoID
            WHERE p.UsuarioID = %s
            ORDER BY p.FechaPedido DESC
        """, (usuario_id,))

        pedidos = []
        for row in cursor.fetchall():
            pedidos.append({
                "pedido_id": row[0],
                "fecha_pedido": row[1].isoformat() if row[1] else None,
                "estado": row[2],
                "total": float(row[3])
            })

        return {"pedidos": pedidos}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener pedidos: {str(e)}")
    finally:
        if conn:
            conn.close()


# -------------------------------
# CREAR DIRECCIÓN
# -------------------------------
@router_pedidos.post("/direcciones/")
def crear_direccion(direccion: DireccionCreate):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO DireccionesEnvio (UsuarioID, Direccion, Ciudad, Departamento, CodigoPostal)
            OUTPUT INSERTED.DireccionID
            VALUES (%s, %s, %s, %s, %s)
        """, (direccion.usuario_id, direccion.direccion, direccion.ciudad, direccion.departamento, direccion.codigo_postal))

        direccion_id = cursor.fetchone()[0]
        conn.commit()

        return {
            "direccion_id": direccion_id,
            "mensaje": "Dirección creada exitosamente"
        }

    except Exception as e:
        if conn:
            conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error al crear dirección: {str(e)}")
    finally:
        if conn:
            conn.close()


# -------------------------------
# DETALLE DE PEDIDO
# -------------------------------
@router_pedidos.get("/{pedido_id}")
def obtener_detalle_pedido(pedido_id: int):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Información del pedido
        cursor.execute("""
            SELECT p.PedidoID, p.FechaPedido, p.Estado, mp.Metodo,
                   d.Direccion, d.Ciudad, d.Departamento,
                   u.Nombre, u.Email, u.Telefono
            FROM Pedidos p
            INNER JOIN Usuarios u ON p.UsuarioID = u.UsuarioID
            INNER JOIN DireccionesEnvio d ON p.DireccionID = d.DireccionID
            INNER JOIN MetodosPago mp ON p.MetodoPagoID = mp.MetodoPagoID
            WHERE p.PedidoID = %s
        """, (pedido_id,))

        pedido_info = cursor.fetchone()
        if not pedido_info:
            raise HTTPException(status_code=404, detail="Pedido no encontrado")

        # Productos del pedido
        cursor.execute("""
            SELECT p.NombreProducto, dp.Cantidad, dp.PrecioUnitario,
                   (dp.Cantidad * dp.PrecioUnitario) as Total,
                   p.ImagenURL
            FROM DetallePedido dp
            INNER JOIN Productos p ON dp.ProductoID = p.ProductoID
            WHERE dp.PedidoID = %s
        """, (pedido_id,))

        productos = []
        for row in cursor.fetchall():
            productos.append({
                "nombre": row[0],
                "cantidad": row[1],
                "precio_unitario": float(row[2]),
                "total": float(row[3]),
                "imagen_url": row[4]
            })

        # Factura del pedido
        cursor.execute("""
            SELECT Subtotal, CostoEnvio, Impuesto, Total
            FROM Facturas
            WHERE PedidoID = %s
        """, (pedido_id,))

        factura = cursor.fetchone()
        factura_info = None
        if factura:
            factura_info = {
                "subtotal": float(factura[0]),
                "costo_envio": float(factura[1]),
                "impuesto": float(factura[2]),
                "total": float(factura[3])
            }

        return {
            "pedido_id": pedido_info[0],
            "fecha_pedido": pedido_info[1].isoformat() if pedido_info[1] else None,
            "estado": pedido_info[2],
            "metodo_pago": pedido_info[3],
            "direccion": {
                "direccion": pedido_info[4],
                "ciudad": pedido_info[5],
                "departamento": pedido_info[6]
            },
            "cliente": {
                "nombre": pedido_info[7],
                "email": pedido_info[8],
                "telefono": pedido_info[9]
            },
            "productos": productos,
            "factura": factura_info
        }

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener pedido: {str(e)}")
    finally:
        if conn:
            conn.close()
