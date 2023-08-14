FROM python:3.11
LABEL maintainer = "meli_challenge_anibal"

ENV PYTHONUNBUFFERED 1
EXPOSE 8000

COPY ./requirements.txt /requirements.txt
# WORKDIR /app
COPY ./app /app

RUN pip install --upgrade pip && \
    pip install -r /requirements.txt && \
    rm -rf /requirements.txt
