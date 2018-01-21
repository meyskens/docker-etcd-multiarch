ARG arch
FROM multiarch/debian-debootstrap:${arch}-stretch

ARG etcdurl
ARG arch
ARG goversion=1.9.2
ARG goarch

RUN apt-get update && apt-get install -y wget tar git
RUN wget -O -  "https://golang.org/dl/go${goversion}.linux-${goarch}.tar.gz" | tar xzC /usr/local
ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

RUN wget -O - ${etcdurl} | tar -xz &&\
    cd etcd-* &&\
    ./build && \
    mv ./bin/* /usr/bin/ &&\
    rm -fr etcd-* 


CMD /usr/bin/etcd
