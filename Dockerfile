FROM golang:1.19.4 as build_context

ENV GOPROXY=https://goproxy.cn,direct

ENV OUTDIR=/out
RUN mkdir -p ${OUTDIR}/usr/local/bin/

WORKDIR /workspace
ADD http3.go /workspace/

RUN env CGO_ENABLED=0 go build -o /usr/local/bin/server http3.go

FROM alpine:3.16.2
COPY --from=build_context /usr/local/bin/server /usr/local/bin/server

CMD ["/usr/local/bin/server"]
