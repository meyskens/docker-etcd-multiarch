ARG arch
FROM multiarch/debian-debootstrap:${arch}-stretch

ARG etcdversion
ARG arch
ARG goversion=1.9

RUN apt-get update && apt-get install -y wget tar git
RUN wget -O -  "https://golang.org/dl/go${goversion}.linux-${arch}.tar.gz" | tar xzC /usr/local
ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

RUN wget -O - "https://github.com/coreos/etcd/releases/download/${etcdversion}/${etcdversion}.tar.gz" | tar -xz &&\
    ls && cd etcd-* &&\
    ./build && \
    mv /usr/src/etcd/bin/* /usr/bin/ &&\
    rm -fr etcd-* 


ENTRYPOINT /usr/bin/etcd
