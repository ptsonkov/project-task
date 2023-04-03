FROM golang:1.20.2-alpine AS builder
WORKDIR /gobuild 
COPY source/ ./
RUN go mod init api && go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o api .

FROM alpine:3.17.2
WORKDIR /app
COPY --from=builder /gobuild/api ./
EXPOSE 8080
CMD [ "/app/api" ]