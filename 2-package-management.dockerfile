FROM golang:1.8.5-jessie
# install dep
RUN go get github.com/golang/dep/cmd/dep
# create a working directory
WORKDIR /go/src/app
# add Gopkg.toml and Gopkg.lock
ADD Gopkg.toml Gopkg.toml
ADD Gopkg.lock Gopkg.lock
# install packages
# --vendor-only is used to restrict dep from scanning source code
# and finding dependencies
RUN dep ensure --vendor-only
# add source code
ADD src src
# run main.go
CMD ["go", "run", "src/main.go"]
