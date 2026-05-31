FROM python:3.10-slim

# Forzamos a Python a que envíe las salidas directamente a la terminal sin búfer
# ENV PYTHONUNBUFFERED=1

# creamos directorio de trabajo
WORKDIR /app

# Copiamos el codigo. Esta en el raiz .
COPY . /app

# Instalar las dependencias definidas en requirements.txt
RUN pip install -r requirements.txt

# Comando por defecto al ejecutar el contenedor
CMD ["python", "main.py"]
