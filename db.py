import os
import pyodbc
from dotenv import load_dotenv

load_dotenv()  # solo necesario para pruebas locales

server = os.getenv("DB_SERVER")
port = os.getenv("DB_PORT", "1433")
database = os.getenv("DB_NAME")
driver = os.getenv("DB_DRIVER", "FreeTDS")
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")

extra_params = "Encrypt=no;TrustServerCertificate=yes;"

def get_connection():
    try:
        # Conexión solo con usuario/clave
        connection_string = (
            f"DRIVER={{{driver}}};"
            f"SERVER={server};PORT={port};"
            f"DATABASE={database};"
            f"UID={user};"
            f"PWD={password};"
            f"{extra_params}"
        )
        conn = pyodbc.connect(connection_string)
        return conn
    except Exception as e:
        print("Error al conectar:", e)
        raise e
