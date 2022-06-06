ARG ALPINE=alpine:latest
FROM ${ALPINE} as alpine
ARG ARCH

RUN apk add -U --no-cache bash bash-completion curl

# Kubectl CLI
ARG KUBECTL_VERSION=v1.24.1

RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl 

RUN apk add --no-cache wireguard-tools 

COPY wg-startup.sh /wg-startup.sh
RUN chmod 700 /wg-startup.sh

EXPOSE 51820/udp
ENTRYPOINT [ "/wg-startup.sh" ]