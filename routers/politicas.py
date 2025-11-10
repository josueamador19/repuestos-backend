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
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT PoliticaID, Tipo, Contenido, Activo FROM Politicas")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return [
        {
            "PoliticaID": row.PoliticaID,
            "Tipo": row.Tipo,
            "Contenido": row.Contenido,
            "Activo": bool(row.Activo)
        }
        for row in rows
    ]

@router.post("/", response_model=PoliticaResponse)
def create_politica(politica: PoliticaCreate):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO Politicas (Tipo, Contenido) OUTPUT INSERTED.PoliticaID, INSERTED.Activo VALUES (?, ?)",
        politica.Tipo,
        politica.Contenido
    )
    inserted = cursor.fetchone()
    conn.commit()
    cursor.close()
    conn.close()
    return {
        "PoliticaID": inserted.PoliticaID,
        "Tipo": politica.Tipo,
        "Contenido": politica.Contenido,
        "Activo": bool(inserted.Activo)
    }
