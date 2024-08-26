FROM python:3.12.5-bookworm AS builder

RUN apt -y update && apt -y upgrade

RUN python -m venv /build/python/.venv

ENV PATH=/build/python/.venv/bin:$PATH

RUN pip install poetry

COPY pyproject.toml /build/pyproject.toml
COPY vpn_api/ /build/vpn_api/
COPY README.md /build

WORKDIR /build

RUN poetry install


RUN poetry build -o dist -f sdist

RUN ls -ahl dist/vpn_api*.tar.gz

FROM python:3.12.5-bookworm

ARG PACKAGE_NAME=vpn_api*.tar.gz
ENV ENV_DIR=/etc/vpn_api

ENV API_USER=api
ENV API_USER_HOME_DIR=${ENV_DIR}
ENV API_USER_UID=999

RUN groupadd --gid ${API_USER_UID} ${API_USER} \
    && useradd -m --uid ${API_USER_UID} --gid ${API_USER_UID} \
    --shell /bin/bash ${API_USER}

WORKDIR ${ENV_DIR}

RUN python -m venv .venv

ENV PATH=${ENV_DIR}/.venv/bin:$PATH

COPY --from=builder --chown=${API_USER}:${API_USER} /build/dist/${PACKAGE_NAME} ${ENV_DIR}/

RUN pip install ./${PACKAGE_NAME}

ENV HOST=0.0.0.0
ENV PORT=80
ENV WORKER=1

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE ${PORT}

CMD [ "uvicorn" ]
