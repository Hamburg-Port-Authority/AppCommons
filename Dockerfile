FROM alpine:3.17.2
# add testing repository and install dependencies
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add bash grep zsh kubeseal@testing \
    && apk add bash make py-pip \
    && apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python2-dev \
    && pip install azure-cli \
    && apk del --purge build
#add worker user
RUN adduser -s /bin/zsh -h /home/worker -D -u 1000 worker \
    && mkdir -p /home/worker/.local/bin \
    && chown -R worker:worker /home/worker/.local
ENV PATH="$PATH:/home/worker/.local/bin"
# copy shell scripts to local env
COPY src/shell/ /home/worker/.local/bin
USER worker
