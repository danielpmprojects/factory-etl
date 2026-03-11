# Usa una imagen base oficial de Python ligera
FROM python:3.11-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala dependencias del sistema si fueran necesarias
# RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Copia los requerimientos e instálalos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código fuente del proyecto
COPY src/ src/

# Copia el archivo de variables de entorno (si es necesario para despliegue por defecto)
# Opcionalmente puedes montar el .env directamente en compose, pero lo copiamos por comodidad.
COPY .env .env

# Asegura que Python genere la salida sin usar un buffer (útil para ver logs en tiempo real en Docker)
ENV PYTHONUNBUFFERED=1

# Declaramos un Entrypoint o CMD base.
# Como hay dos posibles servicios a correr (simulator.py y processor.py), 
# por defecto lanzaremos el procesador, pero lo ideal es sobrescribir "command" en docker-compose
CMD ["python", "src/processor.py"]


# Para construir la imagen manualmente, ejecuta el siguiente comando:
# docker build -t processor-test .

# Para ejecutar el procesador manualmente (conectándolo a la red del docker-compose), ejecuta:
# docker run -it --rm --network factory-etl_default --env-file .env -e KAFKA_BROKERS=kafka:9092 -e ELASTICSEARCH_HOST=http://elasticsearch -e ELASTICSEARCH_PORT=9200 processor-test

# Para ejecutar el SIMULADOR manualmente usando esta misma imagen:
# docker run -it --rm --network factory-etl_default --env-file .env -e KAFKA_BROKERS=kafka:9092 processor-test python src/simulator.py
