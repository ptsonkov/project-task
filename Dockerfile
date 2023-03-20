FROM alpine:3.17.2

WORKDIR /app

COPY bin/api .

EXPOSE 8080

CMD [ "/app/api" ]