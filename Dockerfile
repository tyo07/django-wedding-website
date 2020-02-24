FROM python:3.6-alpine
ENV PYTHONUNBUFFERED 1
# Creating working directory
# Copying requirements
RUN mkdir ./apps
COPY . ./apps
RUN ls -al ./apps
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip install -r ./apps/requirements.txt

WORKDIR ./apps
RUN python ./manage.py migrate
CMD [ "python", "./manage.py", "runserver","0.0.0.0:8000" ]