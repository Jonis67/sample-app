FROM python:3.8

RUN pip install --no-cache-dir --progress-bar off flask==3.0.3

COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/

EXPOSE 5050

CMD ["python", "/home/myapp/sample_app.py"]
