FROM --platform=linux/amd64 ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git wget cmake build-essential m4 \
    x11proto-xext-dev libglu1-mesa-dev libxi-dev libxmu-dev libtbb-dev

WORKDIR /opt
COPY setup.sh .
RUN chmod +x setup.sh && ./setup.sh

RUN echo "source /opt/parsec-benchmark/env.sh" > /etc/profile.d/parsec-env.sh
ENV xxPARSECDIRxx=/opt/parsec-benchmark
WORKDIR /opt/parsec-benchmark
CMD ["/bin/bash", "--login"]
