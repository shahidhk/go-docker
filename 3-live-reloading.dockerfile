FROM golang:1.8.5-jessie
# install dep
RUN go get github.com/golang/dep/cmd/dep
# install gin
RUN go get github.com/codegangsta/gin
# create a working directory
WORKDIR /go/src/app
# add Gopkg.toml and Gopkg.lock
ADD Gopkg.toml Gopkg.toml
ADD Gopkg.lock Gopkg.lock
# install packages
RUN dep ensure --vendor-only
# add source code
ADD src src
# run main.go
CMD ["go", "run", "src/main.go"]

## live reloading usage:
##   $ docker build -f 3-live-reloading.dockerfile -t go-docker-dev .
##   $ docker run --rm -it -p 8080:8080 -v $(pwd):/go/src/app go-docker-dev bash
##
##   root@id:/go/src/app# gin --path src --port 8080 run main.go
