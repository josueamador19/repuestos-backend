import os
import pymssql
from dotenv import load_dotenv

load_dotenv()

server = os.getenv("DB_SERVER")
port = int(os.getenv("DB_PORT", "1433"))
database = os.getenv("DB_NAME")
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")

def get_connection():
    try:
        conn = pymssql.connect(
            server=server,
            port=port,
            user=user,
            password=password,
            database=database
        )
        return conn
    except Exception as e:
        print("Error al conectar:", e)
        raise e
