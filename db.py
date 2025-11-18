import os
import pyodbc
from dotenv import load_dotenv

load_dotenv()

def get_connection():
    try:
        server = os.getenv("DB_SERVER")
        database = os.getenv("DB_NAME")
        user = os.getenv("DB_USER")
        password = os.getenv("DB_PASSWORD")

        # Cadena de conexión recomendada para ODBC Driver 18 en Render
        connection_string = (
            "DRIVER={ODBC Driver 18 for SQL Server};"
            f"SERVER={server};"
            f"DATABASE={database};"
            f"UID={user};"
            f"PWD={password};"
            "Encrypt=yes;"
            "TrustServerCertificate=yes;"
        )

        conn = pyodbc.connect(connection_string)
        return conn

    except Exception as e:
        print("Error al conectar:", e)
        raise e
