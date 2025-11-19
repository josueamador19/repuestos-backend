from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from db import get_connection

router = APIRouter(prefix="/politicas", tags=["Políticas"])

# ---------- Schemas ----------
class PoliticaCreate(BaseModel):
    Tipo: str
    Contenido: str

class PoliticaResponse(PoliticaCreate):
    PoliticaID: int
    Activo: bool

# ---------- Endpoints ----------
@router.get("/", response_model=list[PoliticaResponse])
def get_all_politicas():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT PoliticaID, Tipo, Contenido, Activo FROM Politicas")
        rows = cursor.fetchall()
        result = [
            {
                "PoliticaID": row[0],
                "Tipo": row[1],
                "Contenido": row[2],
                "Activo": bool(row[3])
            }
            for row in rows
        ]
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@router.post("/", response_model=PoliticaResponse)
def create_politica(politica: PoliticaCreate):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO Politicas (Tipo, Contenido) OUTPUT INSERTED.PoliticaID, INSERTED.Activo VALUES (?, ?)",
            (politica.Tipo, politica.Contenido)
        )
        inserted = cursor.fetchone()
        conn.commit()
        return {
            "PoliticaID": inserted[0],
            "Tipo": politica.Tipo,
            "Contenido": politica.Contenido,
            "Activo": bool(inserted[1])
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()
