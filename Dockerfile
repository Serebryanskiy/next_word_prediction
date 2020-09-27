FROM python:3.8.5-buster

LABEL maintainer="Bhaumik Mehta <bhaumikmehta2017@gmail.com>"

# RUN apt-get update && \
#     apt-get install -y apt-transport-https && \
#     apt-get install -y python3 python3-dev python3-pip nginx 

WORKDIR /app

COPY ./requirements.txt ./

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip freeze > rq1.txt

COPY ./ .

EXPOSE 5000

# ENTRYPOINT [ "/bin/bash","-c"]

CMD gunicorn --reload wsgi:app --log-level=debug -b 0.0.0.0:5000 --threads 4 -w 4 --timeout=500