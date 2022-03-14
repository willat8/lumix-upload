FROM ubuntu:impish AS builder

RUN apt-get update && apt-get install -y golang make ca-certificates

ADD https://github.com/willat8/gphotos-uploader-cli/archive/main.tar.gz /

RUN tar zxf main.tar.gz

WORKDIR /gphotos-uploader-cli-main

RUN make build

FROM ubuntu:impish

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:willat8/gphoto \
 && apt-get install -y gphotofs \
 && apt-get purge -y software-properties-common \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /gphotos-uploader-cli-main/gphotos-uploader-cli /usr/bin

ENTRYPOINT ["/bin/bash", "-c", "mkdir -v ~/photos && gphotofs --port=ip:${1:-camera} --camera='Panasonic LumixGSeries' ~/photos && GPHOTOS_CLI_TOKENSTORE_KEY= gphotos-uploader-cli push", "argv0"]

