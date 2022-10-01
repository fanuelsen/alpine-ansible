FROM alpine:latest

LABEL maintainer="Per-Ole Fanuelsen" 

RUN apk --no-cache add \
        ansible \
        py3-pip \
        ca-certificates  
RUN apk --no-cache add --virtual build-dependencies

RUN pip3 install --upgrade pip wheel cryptography mitogen jmespath pywinrm && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    rm -rf /root/.cargo

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]
