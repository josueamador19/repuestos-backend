from fastapi import APIRouter, HTTPException, Form
from db import get_connection
from datetime import datetime

router = APIRouter(prefix="/comentarios", tags=["Comentarios"])

# Obtener comentarios por noticia
@router.get("/{noticia_id}")
def get_comentarios(noticia_id: int):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            """
            SELECT ComentarioID, NoticiaID, UsuarioID, Contenido, Fecha
            FROM ComentariosNoticias
            WHERE NoticiaID = %s
            ORDER BY Fecha ASC
            """,
            (noticia_id,)
        )

        rows = cursor.fetchall()

        comentarios = [
            {
                "id": row[0],
                "noticia_id": row[1],
                "usuario_id": row[2],
                "contenido": row[3],
                "fecha": row[4],
            }
            for row in rows
        ]

        return comentarios

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener comentarios: {str(e)}")

    finally:
        conn.close()


# Crear un comentario
@router.post("/")
def crear_comentario(
    noticia_id: int = Form(...),
    usuario_id: int = Form(...),
    contenido: str = Form(...)
):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Insertar comentario
        cursor.execute(
            """
            INSERT INTO ComentariosNoticias (NoticiaID, UsuarioID, Contenido, Fecha)
            VALUES (%s, %s, %s, GETDATE())
            """,
            (noticia_id, usuario_id, contenido)
        )
        conn.commit()

        # Obtener el último comentario insertado
        cursor.execute(
            """
            SELECT TOP 1 ComentarioID, NoticiaID, UsuarioID, Contenido, Fecha
            FROM ComentariosNoticias
            WHERE NoticiaID = %s
            ORDER BY Fecha DESC
            """,
            (noticia_id,)
        )

        row = cursor.fetchone()

        return {
            "id": row[0],
            "noticia_id": row[1],
            "usuario_id": row[2],
            "contenido": row[3],
            "fecha": row[4]
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al agregar comentario: {str(e)}")

    finally:
        conn.close()
