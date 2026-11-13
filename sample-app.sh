
#!/bin/bash

# Detener el script si ocurre algún error
set -e

# Eliminar el directorio temporal anterior
rm -rf tempdir

# Crear los directorios necesarios
mkdir -p tempdir/templates
mkdir -p tempdir/static

# Copiar los archivos de la aplicación
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Crear el Dockerfile
cat > tempdir/Dockerfile <<'EOF'
FROM python:3.8

RUN pip install --no-cache-dir --progress-bar off flask==3.0.3

COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/

EXPOSE 5050

CMD ["python", "/home/myapp/sample_app.py"]
EOF

# Construir la imagen Docker
cd tempdir
docker build -t sampleapp .

# Eliminar el contenedor anterior si existe
docker rm -f samplerunning 2>/dev/null || true

# Ejecutar el nuevo contenedor
docker run -t -d -p 8080:8080 --name samplerunning sampleapp

# Mostrar los contenedores
docker ps -a
