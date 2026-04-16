FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o fizzbuzz .

FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /app/fizzbuzz .

EXPOSE 8080

CMD ["./fizzbuzz", "serve"]