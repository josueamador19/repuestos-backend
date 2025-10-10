from fastapi import APIRouter, UploadFile, File, HTTPException, Form
from db import get_connection
import shutil
import os

router = APIRouter(prefix="/blog", tags=["Blog"])
UPLOAD_DIR = "static/images"
# Obtener todas las noticias
@router.get("/")
def get_noticias():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT n.NoticiaID, n.Titulo, n.Contenido, n.ImagenURL,
                u.Nombre AS Autor, n.FechaPublicacion, n.Categoria
            FROM Noticias n
            LEFT JOIN Usuarios u ON n.AutorID = u.UsuarioID
            WHERE n.Activo = 1
            ORDER BY n.FechaPublicacion DESC
        """)
        rows = cursor.fetchall()

        noticias = [
            {
                "id": row[0],
                "titulo": row[1],
                "contenido": row[2],
                "imagen_url": row[3],
                "autor": row[4],
                "fecha": row[5],
                "categoria": row[6]
            }
            for row in rows
        ]
        return noticias
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener noticias: {str(e)}")
    finally:
        conn.close()

# Obtener noticia por ID
@router.get("/{noticia_id}")
def get_noticia(noticia_id: int):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT n.NoticiaID, n.Titulo, n.Contenido, n.ImagenURL,
                u.Nombre AS Autor, n.FechaPublicacion, n.Categoria
            FROM Noticias n
            LEFT JOIN Usuarios u ON n.AutorID = u.UsuarioID
            WHERE n.NoticiaID = ? AND n.Activo = 1
        """, (noticia_id,))
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Noticia no encontrada")

        noticia = {
            "id": row[0],
            "titulo": row[1],
            "contenido": row[2],
            "imagen_url": row[3],
            "autor": row[4],
            "fecha": row[5],
            "categoria": row[6]
        }
        return noticia
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener noticia: {str(e)}")
    finally:
        conn.close()


#  Crear una noticia
@router.post("/")
def crear_noticia(
    titulo: str = Form(...),
    contenido: str = Form(...),
    AutorID: int = Form(...),
    categoria: str = Form(...),
    imagen: UploadFile = File(None)
):
    try:
        imagen_url = None
        if imagen:
        
            filename = imagen.filename
            file_path = os.path.join(UPLOAD_DIR, filename)
            with open(file_path, "wb") as f:
                shutil.copyfileobj(imagen.file, f)
            imagen_url = filename  

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """
            INSERT INTO Noticias (Titulo, Contenido, ImagenURL, AutorID, Categoria, Activo, FechaPublicacion)
            VALUES (?, ?, ?, ?, ?, 1, GETDATE())
            """,
            (titulo, contenido, imagen_url, AutorID, categoria)
        )
        conn.commit()
        return {"message": "✅ Noticia creada correctamente"}
    finally:
        conn.close()