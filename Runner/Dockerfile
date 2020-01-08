FROM alpine:latest

ARG TERRAFORM_VERSION=0.11.10
ARG TERRAFORM_PROVIDER_ARCHIVE_VERSION=1.1.0
ARG TERRAFORM_PROVIDER_AWS_VERSION=1.33.0
ARG TERRAFORM_PROVIDER_TEMPLATE_VERSION=1.0.0
ARG TERRAFORM_PROVIDER_TERRAFORM_VERSION=1.0.2
ARG TERRAFORM_PROVIDER_TLS_VERSION=1.2.0
ARG PACKER_VERSION=1.2.5
ARG ANSIBLE_VERSION=2.6.2
ARG ANSIBLE_LINT_VERSION=3.4.23
ARG PYWINRM_VERSION==0.2.2


RUN rm -rf /var/cache/apk/* && \
     rm -rf /tmp/*
RUN apk upgrade --update
RUN apk add --no-cache ca-certificates
RUN apk add --no-cache python2 make openssh-client git zip curl coreutils sed bash json-glib-dev bind-tools jq 
RUN apk add --no-cache --virtual build-dependencies python2-dev build-base openldap-dev python3-dev gcc musl-dev libffi-dev libressl-dev && \
    python2 -m ensurepip && \
    rm -rf /usr/lib/python*/ensurepip && \
    pip install --no-cache --upgrade pip setuptools && \
    pip install --no-cache --upgrade boto3 awscli && \
    pip install --no-cache --upgrade dnspython && \
    pip install --no-cache --upgrade c7n-org && \
    pip install --no-cache --upgrade "ansible==${ANSIBLE_VERSION}" "pywinrm>=${PYWINRM_VERSION}" && \
    pip install --no-cache --upgrade "ansible-lint==${ANSIBLE_LINT_VERSION}" && \
    pip install --no-cache --upgrade python-ldap && \
    rm -rf /root/.cache && \
    apk del build-dependencies
# Needed for Ansible Runtime
RUN apk add --update-cache gcc python2-dev linux-headers musl-dev openldap-dev && \
    rm -rf /root/.cache && \
    pip2 install --no-cache --upgrade python-ldap setuptools

# Downloaded from https://releases.hashicorp.com/terraform-provider-aws/
COPY terraform_${TERRAFORM_VERSION}_linux_amd64.zip . 
COPY packer_${PACKER_VERSION}_linux_amd64.zip . 
COPY terraform-provider-aws_${TERRAFORM_PROVIDER_AWS_VERSION}_linux_amd64.zip . 
COPY terraform-provider-terraform_${TERRAFORM_PROVIDER_TERRAFORM_VERSION}_linux_amd64.zip . 
COPY terraform-provider-template_${TERRAFORM_PROVIDER_TEMPLATE_VERSION}_linux_amd64.zip .
COPY terraform-provider-archive_${TERRAFORM_PROVIDER_ARCHIVE_VERSION}_linux_amd64.zip .
COPY terraform-provider-tls_${TERRAFORM_PROVIDER_TLS_VERSION}_linux_amd64.zip . 
RUN mkdir /usr/lib/custom-terraform-plugins 
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin/ 
RUN unzip terraform-provider-aws_${TERRAFORM_PROVIDER_AWS_VERSION}_linux_amd64.zip -d /usr/lib/custom-terraform-plugins 
RUN unzip terraform-provider-terraform_${TERRAFORM_PROVIDER_TERRAFORM_VERSION}_linux_amd64.zip -d /usr/lib/custom-terraform-plugins 
RUN unzip terraform-provider-template_${TERRAFORM_PROVIDER_TEMPLATE_VERSION}_linux_amd64.zip -d /usr/lib/custom-terraform-plugins 
RUN unzip terraform-provider-archive_${TERRAFORM_PROVIDER_ARCHIVE_VERSION}_linux_amd64.zip -d /usr/lib/custom-terraform-plugins 
RUN unzip terraform-provider-tls_${TERRAFORM_PROVIDER_TLS_VERSION}_linux_amd64.zip -d /usr/lib/custom-terraform-plugins 
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/

CMD ["/bin/sh"] 
ENV PATH=/usr/local/bin/:${PATH}

