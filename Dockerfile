FROM python:3.12.5-bookworm

RUN apt -y update && apt -y upgrade

RUN python -m venv /build/python/.venv

ENV PATH=/build/python/.venv:$PATH

RUN pip install poetry

CMD [ "poetry" ]
