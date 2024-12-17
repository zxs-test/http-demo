FROM golang:1.22.5 as build_context

ENV GOPROXY=https://goproxy.cn,direct

ENV OUTDIR=/out
RUN mkdir -p ${OUTDIR}/usr/local/bin/

WORKDIR /workspace
ADD . /workspace/

RUN /bin/sh build.sh

FROM alpine:3.16.2
COPY --from=build_context /usr/local/bin/server /usr/local/bin/server

CMD ["/usr/local/bin/server"]
