from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles  
from routers import productos, blog, comentarios, contacto
from db import get_connection

app = FastAPI(title="Repuestos API", version="1.0")

# Configuración de CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Montar carpeta de imágenes estáticas
app.mount("/static", StaticFiles(directory="static"), name="static")

# Registrar rutas
app.include_router(productos.router)
app.include_router(blog.router)
app.include_router(comentarios.router)
app.include_router(contacto.router)

@app.get("/")
def root():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT @@VERSION;")
        version = cursor.fetchone()
        conn.close()
        return {"message": "Conectado a SQL Server!", "version": version[0]}
    except Exception as e:
        return {"error": str(e)}
