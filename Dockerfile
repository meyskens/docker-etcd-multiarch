ARG arch
FROM multiarch/alpine:${arch}-latest-stable

ARG etcdversion
ARG arch

RUN apk add --no-cache wget tar ca-certificates

RUN wget -O - "https://github.com/coreos/etcd/releases/download/${etcdversion}/etcd-${etcdversion}-linux-${arch}.tar.gz" | tar -xz &&\
    mv etcd-${etcdversion}-linux-${arch}/etcd /usr/bin/etcd &&\
    mv etcd-v${etcdversion}-linux-${arch}/etcdctl /usr/bin/etcdctl &&\
    rm -fr etcd-${etcdversion}-linux-${arch}

ENTRYPOINT /usr/bin/etcd
