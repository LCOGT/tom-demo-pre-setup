FROM python:3.7
MAINTAINER Austin Riba <ariba@lco.global>

EXPOSE 8080
ENTRYPOINT [ "/usr/local/bin/gunicorn", "tom_demo.wsgi", "-b", "0.0.0.0:8080", "--access-logfile", "-", "--error-logfile", "-", "-k", "gevent", "--timeout", "300", "--workers", "4"]
WORKDIR /tom_demo

COPY requirements.txt /tom_demo
RUN pip install --no-cache-dir -r /tom_demo/requirements.txt

COPY . /tom_demo

RUN python manage.py collectstatic --noinput
