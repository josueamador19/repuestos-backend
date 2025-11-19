from fastapi import APIRouter, HTTPException, Form
from db import get_connection
from datetime import datetime

router = APIRouter(prefix="/contacto", tags=["Contacto"])

# Obtener la información del local
@router.get("/info")
def get_contact_info():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT TOP 1 * FROM ContactInfo")
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="No hay información de contacto registrada")
        return {
            "direccion": row[1],
            "telefono": row[2],
            "correo": row[3],
            "horario": row[4],
            "mapa_url": row[5]
        }
    finally:
        conn.close()

# Guardar mensaje del formulario de contacto
@router.post("/mensaje")
def send_contact_message(
    nombre: str = Form(...),
    email: str = Form(...),
    asunto: str = Form(...),
    mensaje: str = Form(...)
):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        fecha_envio = datetime.now()
        estado = "Pendiente"

        cursor.execute("""
            INSERT INTO ContactMessages (Nombre, Email, Asunto, Mensaje, FechaEnvio, Estado)
            VALUES ($s, $s, $s, $s, $s, $s)
        """, (nombre, email, asunto, mensaje, fecha_envio, estado))
        conn.commit()

        return {"message": "Mensaje enviado correctamente"}

    except Exception as e:
        print("Error al guardar mensaje:", e)
        raise HTTPException(status_code=500, detail="Error al guardar el mensaje")

    finally:
        conn.close()