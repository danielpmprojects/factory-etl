# Factory ETL Pipeline

Este proyecto implementa una tubería de datos (Pipeline ETL) en tiempo real para simular y procesar datos de telemetría de máquinas de una fábrica. 

El sistema utiliza **Kafka** como bus de mensajes para la ingesta de eventos de los sensores, y **Elasticsearch** junto con **Kibana** para el almacenamiento, indexado y visualización de la información.

## Arquitectura

- **Simulador (`src/simulator.py`)**: Genera datos de telemetría (IoT) falsos representando sensores de la fábrica y los envía a Kafka.
- **Procesador (`src/processor.py`)**: Consume los datos desde Kafka, los procesa/transforma mediante el pipeline, y los indexa en Elasticsearch.
- **Servicios Docker**:
  - `kafka`: Broker de mensajería principal (con KRaft).
  - `kafdrop`: Interfaz web en el puerto `9000` para visualizar tópicos y mensajes de Kafka.
  - `elasticsearch`: Motor de búsqueda y analítica en el puerto `9200`.
  - `kibana`: Plataforma de dashboards y visualización en el puerto `5601`.

## Requisitos Previos

- Docker y Docker Compose
- Python 3.9+ 
- Entorno virtual (recomendado)

## Instalación y Configuración

1. **Levantar la infraestructura con Docker**:
   ```bash
   docker-compose up -d
   ```
   *Esto iniciará Kafka, Kafdrop, Elasticsearch y Kibana.*

2. **Crear y activar un entorno virtual**:
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # En Linux/Mac
   # .venv\Scripts\activate   # En Windows
   ```

3. **Instalar dependencias Python**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Variables de Entorno**:
   Configura tu archivo `.env` en la raíz del proyecto basándote en la infraestructura.

## Uso del Proyecto

1. **Iniciar el simulador**:
   Ejecuta el script de simulación para comenzar a enviar datos a Kafka.
   ```bash
   python src/simulator.py
   ```
2. **Iniciar el procesador ETL**:
   Ejecuta el procesador para consumir de Kafka y enviar a Elasticsearch.
   ```bash
   python src/processor.py
   ```

3. **Visualización y Monitoreo**:
   - Accede a [Kafdrop (http://localhost:9000)](http://localhost:9000) para ver los mensajes en Kafka.
   - Accede a [Kibana (http://localhost:5601)](http://localhost:5601) para crear índices y dashboards de los datos.

---

## Anexo: Diccionario de Datos

El sistema maneja una serie de códigos y atributos para referirse a la información de forma comprimida.

### Códigos de atributos del mensaje
- **TS**: TIMESTAMP (Marca de tiempo)
- **MC**: MACHINE (Máquina)
- **PR**: PRODUCT (Producto)
- **PS**: PROPS (Propiedades/Métricas)

### Códigos de Máquinas
- `UNS56A`: UNSCRAMBLER (Posicionador)
- `WS964F`: WASHER (Lavadora)
- `IS8710`: INSPECTION (Inspección)
- `FB713A`: FILLING (Llenadora)
- `C7841R`: CARBONATOR (Carbonatador)
- `CPM784`: CAPPING (Taponadora)
- `LBL74F`: LABELING (Etiquetadora)
- `PLL741`: PALLETIZER (Paletizador)

### Códigos de Propiedades Diferenciales
- `A7`: LITERS (Litros utilizados)
- `W8`: QUALITY (Calidad del resultado)
- `L1`: LIGHT (Luz que pasa a través del cristal)
- `T3`: TIME (Tiempo de operación)
- `P6`: POWER (Fuerza usada)
- `G8`: GRADES (Grados)
