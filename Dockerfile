ARG arch
FROM multiarch/debian-debootstrap:${arch}-stretch

ARG etcdversion
ARG arch
ARG goversion=1.9
ARG goarch

RUN apt-get update && apt-get install -y wget tar git
RUN wget -O -  "https://golang.org/dl/go${goversion}.linux-${goarch}.tar.gz" | tar xzC /usr/local
ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

RUN wget -O - "https://github.com/coreos/etcd/releases/download/${etcdversion}/${etcdversion}.tar.gz" | tar -xz &&\
    cd etcd-* &&\
    ./build && \
    mv ./bin/* /usr/bin/ &&\
    rm -fr etcd-* 


ENTRYPOINT /usr/bin/etcd
