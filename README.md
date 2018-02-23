# go-docker

A simple web app written in Go, with dockerfiles for development and production.

Build and run using any dockerfile:

```bash
$ docker build -f [dockerfile] -t go-docker .
$ docker run --rm -it -p 8080:8080 go-docker
```

See branch [glide](https://github.com/shahidhk/go-docker/tree/glide) for glide based workflow instead of dep.
