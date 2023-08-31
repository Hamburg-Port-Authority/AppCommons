FROM alpine:3.17.2
# add testing repository and install dependencies
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add bash grep zsh kubeseal@testing \
    && apk add --no-cache --update python3 py3-pip \
    && apk add --no-cache --update --virtual=build gcc musl-dev python3-dev libffi-dev openssl-dev cargo make \
    && pip3 install --no-cache-dir --prefer-binary azure-cli \
    && apk del --purge build
#add worker user
RUN adduser -s /bin/zsh -h /home/worker -D -u 1000 worker \
    && mkdir -p /home/worker/.local/bin \
    && chown -R worker:worker /home/worker/.local
ENV PATH="$PATH:/home/worker/.local/bin"
# copy shell scripts to local env
COPY src/shell/ /home/worker/.local/bin
# create default folders
RUN mkdir /tmp/tcp-connection-check
RUN chmod 777 -R /tmp
USER worker
