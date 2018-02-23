FROM golang:1.8.5-jessie
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
# build main.go
RUN go build src/main.go
# run the binary
CMD ["./main"]
