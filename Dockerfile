FROM alpine:latest

LABEL maintainer="Per-Ole Fanuelsen" 

RUN apk --no-cache add \
        openssh \
        ansible \
        py3-pip \
        py3-requests \
        py3-netaddr \
        ca-certificates  

RUN apk --no-cache add --virtual build-dependencies

RUN apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    rm -rf /root/.cargo

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]
