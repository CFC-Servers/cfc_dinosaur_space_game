FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine as builder

RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container

ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY entrypoint.sh entrypoint.sh

CMD apk add --no-cache --upgrade sudo apt unzip curl jq

RUN sh entrypoint.sh

USER container
