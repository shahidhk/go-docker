package main

import (
	"fmt"
	"net/http"
	"os"

	log "github.com/sirupsen/logrus"
)

func sayHello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello World")
	log.Println("said hello")
}

func sayPongJSON(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	fmt.Fprint(w, `{"message":"pong"}`)
	log.Println("said pong")
}

func main() {
	http.HandleFunc("/", sayHello)
	http.HandleFunc("/ping", sayPongJSON)

	// get port env var
	port := "8080"
	portEnv := os.Getenv("PORT")
	if len(portEnv) > 0 {
		port = portEnv
	}

	log.Printf("Listening on port %s...", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
	// listen and serve on 0.0.0.0:8080 by default
	// set environment variable PORT if you want to change port
}
