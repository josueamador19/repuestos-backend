from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles  

from routers import productos, blog, comentarios, contacto, faq, politicas
from routers import login
from routers.pedido import router_pedidos 

from db import get_connection

app = FastAPI(title="Repuestos API", version="1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "*"
        # "http://localhost:5173",
        # "https://tu-frontend.onrender.com"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Archivos estáticos
app.mount("/static", StaticFiles(directory="static"), name="static")

# Routers
app.include_router(productos.router)
app.include_router(blog.router)
app.include_router(comentarios.router)
app.include_router(contacto.router)
app.include_router(router_pedidos)
app.include_router(login.router)
app.include_router(politicas.router)
app.include_router(faq.router)

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
