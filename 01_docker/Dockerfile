FROM python:3.6-alpine
LABEL maintainer="Ulrich NOUMSI"
WORKDIR /opt
COPY . /opt/
RUN pip install flask
EXPOSE 8080
ENV ODOO_URL="https://www.odoo.com/"
ENV PGADMIN_URL=" https://www.pgadmin.org/"

ENTRYPOINT ["python", "app.py"]