from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from db import get_connection

router = APIRouter(prefix="/faq", tags=["FAQ"])

# ---------- Schemas ----------
class FAQCreate(BaseModel):
    Pregunta: str
    Respuesta: str
    Activo: bool = True  

class FAQResponse(FAQCreate):
    FAQID: int

# ---------- Endpoints ----------
@router.get("/", response_model=list[FAQResponse])
def get_all_faq(only_active: bool = True):
    """
    Obtiene todos los FAQs. Por defecto solo los activos.
    """
    try:
        conn = get_connection()
        cursor = conn.cursor()
        query = "SELECT FAQID, Pregunta, Respuesta, Activo FROM FAQ"
        if only_active:
            query += " WHERE Activo = 1"
        cursor.execute(query)
        rows = cursor.fetchall()
        return [
            {
                "FAQID": row[0],
                "Pregunta": row[1],
                "Respuesta": row[2],
                "Activo": bool(row[3])
            }
            for row in rows
        ]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()


@router.post("/", response_model=FAQResponse)
def create_faq(faq: FAQCreate):
    """
    Crea un nuevo FAQ.
    """
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO FAQ (Pregunta, Respuesta, Activo) OUTPUT INSERTED.FAQID VALUES (?, ?, ?)",
            (faq.Pregunta, faq.Respuesta, int(faq.Activo))
        )
        faq_id = cursor.fetchone()[0]
        conn.commit()
        return {
            "FAQID": int(faq_id),
            "Pregunta": faq.Pregunta,
            "Respuesta": faq.Respuesta,
            "Activo": faq.Activo
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()
