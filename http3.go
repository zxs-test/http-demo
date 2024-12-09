package main

import (
	"fmt"
	"io"
	"net/http"
)

type Serv struct{}

func (s Serv) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
	data, _ := io.ReadAll(request.Body)
	writer.WriteHeader(200)
	result := fmt.Sprintf("you are trying to access %s with method %s,receive data %s", request.URL.Path, request.Method, string(data))
	fmt.Println(result)
	writer.Write([]byte(result))
}

func main() {
	http.ListenAndServe(":80", &Serv{})
}
