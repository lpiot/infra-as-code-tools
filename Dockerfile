FROM google/cloud-sdk:alpine
MAINTAINER "Ludovic Piot <ludovic.piot@thegaragebandofit.com>"

# OpenSSL
RUN apk add openssl

# Git
RUN apk add git

# GCP vars
#ENV GOOGLE_SERVICE_ACCOUNT=myproject-terraform-accnt@lof-ws-test.iam.gserviceaccount.com
#ENV GOOGLE_PROJECT=myproject

# GCP configuration
WORKDIR /
#RUN gcloud config set account ${GOOGLE_SERVICE_ACCOUNT}
#RUN gcloud config set project ${GOOGLE_PROJECT}

# GCP extra components install
RUN gcloud components install beta --quiet
RUN gcloud components install kubectl --quiet
RUN gcloud components update --quiet

# Terraform vars
ENV TERRAFORM_VERSION=0.12.13

# Terraform install
WORKDIR /usr/bin
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -f ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Packer vars
ENV PACKER_VERSION=1.4.5

# Packer install
WORKDIR /usr/bin
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip ./packer_${PACKER_VERSION}_linux_amd64.zip && \
    rm -f ./packer_${PACKER_VERSION}_linux_amd64.zip

ENTRYPOINT [ "/bin/sh" ]
