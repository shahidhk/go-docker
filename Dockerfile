FROM golang:1.8.5-jessie as builder
# install xz
RUN apt-get update && apt-get install -y \
    xz-utils \
&& rm -rf /var/lib/apt/lists/*
# install UPX
ADD https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz /usr/local
RUN xz -d -c /usr/local/upx-3.94-amd64_linux.tar.xz | \
    tar -xOf - upx-3.94-amd64_linux/upx > /bin/upx && \
    chmod a+x /bin/upx
# install dep
RUN go get github.com/golang/dep/cmd/dep
# create a working directory
WORKDIR /go/src/app
# add Gopkg.toml and Gopkg.lock
ADD Gopkg.toml Gopkg.toml
ADD Gopkg.lock Gopkg.lock
# install packages
RUN dep ensure --vendor-only
# add source code
ADD src src
# build the source
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main src/main.go
# strip and compress the binary
RUN strip --strip-unneeded main
RUN upx main

# use a minimal alpine image
FROM alpine:3.7
# add ca-certificates in case you need them
RUN apk add --no-cache ca-certificates
# set working directory
WORKDIR /root
# copy the binary from builder
COPY --from=builder /go/src/app/main .
# run the binary
CMD ["./main"]
