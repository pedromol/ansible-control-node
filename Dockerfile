FROM python:alpine

RUN apk --update add alpine-sdk gcc musl-dev libffi-dev openssl-dev bash curl tar openssh-client sshpass git ca-certificates nano && \
    python3 -m pip install ansible python-keyczar docker-py && \
    mkdir -p /ansible/playbooks/roles /ansible/library /ansible/lib /ansible/bin /etc/ansible

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
