FROM ubuntu:18.04

RUN set -ex; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
	libatlas3-base \
        libcurl3 \
        libgfortran3 \
        libgomp1 \
        libopenblas-base \
	openjdk-8-jdk-headless \
        runit \
        software-properties-common \
        wget && \
    add-apt-repository -y ppa:timsc/opencv-3.4 && \
    apt-get update && \
    apt-get install -y libopencv-imgcodecs3.4 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --home-dir /home/mxnetuser --create-home --shell /bin/bash --user-group mxnetuser

ENV LEIN_VERSION=2.8.1
ENV LEIN_INSTALL=/usr/local/bin/

RUN mkdir -p $LEIN_INSTALL \
    && wget -q https://raw.githubusercontent.com/technomancy/leiningen/$LEIN_VERSION/bin/lein-pkg \
    && echo "Comparing lein-pkg checksum ..." \
    && echo "019faa5f91a463bf9742c3634ee32fb3db8c47f0 *lein-pkg" | sha1sum -c - \
    && mv lein-pkg $LEIN_INSTALL/lein \
    && chmod 0755 $LEIN_INSTALL/lein \
    && wget -q https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip \
    && mkdir -p /usr/share/java \
    && mv leiningen-$LEIN_VERSION-standalone.zip /usr/share/java/leiningen-$LEIN_VERSION-standalone.jar

ENV PATH=$PATH:$LEIN_INSTALL
ENV LEIN_ROOT 1

COPY run-as-user.sh /usr/local/bin/

WORKDIR /home/mxnetuser/app

ENTRYPOINT ["/usr/local/bin/run-as-user.sh"]
