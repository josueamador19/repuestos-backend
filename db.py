import os
import pyodbc
from dotenv import load_dotenv

load_dotenv()

server = os.getenv("DB_SERVER")
database = os.getenv("DB_NAME")
driver = os.getenv("DB_DRIVER")
trusted = os.getenv("DB_TRUSTED_CONNECTION")

extra_params = "Encrypt=no;TrustServerCertificate=yes;"

def get_connection():
    try:
        if trusted and trusted.lower() == "yes":
            connection_string = (
                f"DRIVER={{{driver}}};"
                f"SERVER={server};"
                f"DATABASE={database};"
                f"Trusted_Connection=yes;"
                f"{extra_params}"
            )
        else:
            user = os.getenv("DB_USER")
            password = os.getenv("DB_PASSWORD")
            connection_string = (
                f"DRIVER={{{driver}}};"
                f"SERVER={server};"
                f"DATABASE={database};"
                f"UID={user};"
                f"PWD={password};"
                f"{extra_params}"
            )

        conn = pyodbc.connect(connection_string)
        return conn
    except Exception as e:
        print("❌ Error al conectar:", e)
        raise e
