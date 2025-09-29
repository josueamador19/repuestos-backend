from fastapi import APIRouter
from db import get_connection

router = APIRouter(prefix="/productos", tags=["Productos"])

@router.get("/")
def listar_productos():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT ProductoID, NombreProducto, Descripcion, Precio, Stock, Categoria, ImagenURL FROM Productos;")
        rows = cursor.fetchall()
        conn.close()

        
        productos = []
        for r in rows:
            productos.append({
                "id": r[0],
                "nombre": r[1],
                "Descripcion": r[2],
                "Precio": r[3],
                "Stock": r[4],
                "Categoria": r[5],
                "ImagenURL": f"http://127.0.0.1:8000/static/images/{r[6]}" if r[6] else None
            })
        return {"productos": productos}
    except Exception as e:
        return {"error": str(e)}
