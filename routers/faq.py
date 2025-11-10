from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from db import get_connection

router = APIRouter(prefix="/faq", tags=["FAQ"])

# ---------- Schemas ----------
class FAQCreate(BaseModel):
    Pregunta: str
    Respuesta: str
    Activo: bool = True  # Por defecto activo al crear

class FAQResponse(FAQCreate):
    FAQID: int

# ---------- Endpoints ----------
@router.get("/", response_model=list[FAQResponse])
def get_all_faq(only_active: bool = True):
    """
    Obtiene todos los FAQs. Por defecto solo los activos.
    """
    conn = get_connection()
    cursor = conn.cursor()
    query = "SELECT FAQID, Pregunta, Respuesta, Activo FROM FAQ"
    if only_active:
        query += " WHERE Activo = 1"
    cursor.execute(query)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return [
        {"FAQID": row.FAQID, "Pregunta": row.Pregunta, "Respuesta": row.Respuesta, "Activo": bool(row.Activo)}
        for row in rows
    ]


@router.post("/", response_model=FAQResponse)
def create_faq(faq: FAQCreate):
    """
    Crea un nuevo FAQ.
    """
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO FAQ (Pregunta, Respuesta, Activo) VALUES (?, ?, ?); SELECT SCOPE_IDENTITY()",
        faq.Pregunta,
        faq.Respuesta,
        int(faq.Activo)  # SQL Server usa 1/0 para bit
    )
    faq_id = cursor.fetchone()[0]
    conn.commit()
    cursor.close()
    conn.close()
    return {"FAQID": int(faq_id), "Pregunta": faq.Pregunta, "Respuesta": faq.Respuesta, "Activo": faq.Activo}
