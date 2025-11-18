FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema necesarias para ODBC y SQL Server
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    apt-transport-https \
    lsb-release \
    unixodbc \
    unixodbc-dev \
    build-essential \
    libgssapi-krb5-2 \
    locales \
    ca-certificates \
    apt-utils \
    sudo \
    wget

# Agregar repositorio oficial de Microsoft para ODBC Driver 18
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg && \
    curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Instalar ODBC Driver 18 + herramientas SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18

# Agregar herramientas al PATH
ENV PATH="${PATH}:/opt/mssql-tools18/bin"

# Copiar requirements
COPY requirements.txt .

# Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar proyecto completo
COPY . .

# Exponer puerto del backend
EXPOSE 8000

# Comando de inicio para FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
