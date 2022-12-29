FROM python:alpine

RUN apk --update add alpine-sdk gcc musl-dev libffi-dev openssl-dev bash curl tar openssh-client sshpass git ca-certificates nano gcc clang lld

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh && \
    sh /tmp/rustup.sh -y && \
    source /root/.cargo/env && \
    rm -Rf /tmp/rustup.sh && \
    mkdir -p /ansible/playbooks/roles /ansible/library /ansible/lib /ansible/bin /etc/ansible

ENV PATH /root/.cargo/bin:/ansible/bin:$PATH

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install ansible python-keyczar docker-py

WORKDIR /ansible

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

ENTRYPOINT ["ansible-playbook"]
