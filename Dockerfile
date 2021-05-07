FROM nginx:alpine
MAINTAINER Sebastian Carlier sebastiancarlier@gmail.com

ENV HUGO_VERSION="0.83.1"
ENV GITHUB_USERNAME="c4rlier"
ENV DOCKER_IMAGE_NAME="hugo-blog"
ENV BASE_URL="blog.binarybelt.com"

USER root

RUN apk add --update \
    wget \
    git \
    tar \
    ca-certificates

RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -xvf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    chmod +x hugo && \
    mv hugo /usr/local/bin/hugo && \
    rm -rf hugo_${HUGO_VERSION}_linux_amd64/ hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN git clone https://github.com/${GITHUB_USERNAME}/${DOCKER_IMAGE_NAME}.git

RUN hugo -s ${DOCKER_IMAGE_NAME} -d /usr/share/nginx/html/ --baseURL ${BASE_URL}

CMD nginx -g "daemon off;"