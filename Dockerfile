FROM golang:1.9-alpine3.6 as builder

RUN apk update && apk add git libvirt-dev make gcc musl-dev && mkdir -p /go/src/github.com/docker && cd /go/src/github.com/docker && git clone https://github.com/docker/infrakit
WORKDIR /go/src/github.com/docker/infrakit
RUN make get-tools && make binaries

FROM alpine:3.6 as runner
WORKDIR /root
COPY --from=builder /go/src/github.com/docker/infrakit/build/* ./

ENTRYPOINT [ "./infrakit" ]