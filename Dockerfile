FROM alpine:latest as builder
WORKDIR /root
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache git make build-base && \
    git clone --branch master --single-branch https://api.ineko.cc/gh/https://github.com/Wind4/vlmcsd.git && \
    cd vlmcsd/ && \
    make

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
EXPOSE 1688/tcp
CMD [ "/usr/bin/vlmcsd", "-D", "-d","-e","-v"]
