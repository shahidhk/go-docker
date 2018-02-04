FROM golang:1.8.5-jessie
# create a working directory
WORKDIR /go/src/app
# add source code
ADD src src
# run main.go
CMD ["go", "run", "src/main.go"]
