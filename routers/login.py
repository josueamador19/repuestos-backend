from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from db import get_connection

router = APIRouter(prefix="/auth", tags=["Autenticación"])

class LoginRequest(BaseModel):
    email: str
    password: str

class RegisterRequest(BaseModel):
    nombre: str
    email: str
    password: str
    telefono: str


@router.post("/login")
def login(login_data: LoginRequest):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT UsuarioID, Nombre, Email,Telefono, RolID
            FROM Usuarios
            WHERE Email = %s AND PasswordHash = %s
        """, (login_data.email, login_data.password))

        user = cursor.fetchone()

        if user:
            return {
                "usuario_id": user[0],
                "nombre": user[1],
                "email": user[2],
                "telefono": user[3],
                "rol_id": user[4],
                "mensaje": "Login exitoso"
            }
        else:
            raise HTTPException(status_code=401, detail="Credenciales incorrectas")

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error en login: {str(e)}")
    finally:
        if conn:
            conn.close()


@router.post("/register")
def register(register_data: RegisterRequest):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            "SELECT UsuarioID FROM Usuarios WHERE Email = %s",
            (register_data.email,)
        )

        if cursor.fetchone():
            raise HTTPException(status_code=400, detail="El email ya está registrado")

        # Insert del usuario
        cursor.execute("""
            INSERT INTO Usuarios (Nombre, Email, PasswordHash, Telefono, RolID)
            VALUES (%s, %s, %s, %s, 2)
        """, (register_data.nombre, register_data.email, register_data.password, register_data.telefono))

        # Obtener ID generado
        cursor.execute("SELECT SCOPE_IDENTITY()")
        user_id = cursor.fetchone()[0]

        conn.commit()

        return {
            "usuario_id": int(user_id),
            "mensaje": "Usuario registrado exitosamente"
        }

    except Exception as e:
        if conn:
            conn.rollback()
        raise HTTPException(status_code=500, detail=f"Error en registro: {str(e)}")
    finally:
        if conn:
            conn.close()
