FROM registry.cn-hangzhou.aliyuncs.com/dragonwell/dragonwell8:8.1.1-GA_alpine_x86_64_8u222-b67_slim as upstream
RUN set -eux; \
    ln -s $JAVA_HOME /opt/alibaba/java; \
    echo "JAVA_VERSION=${JAVA_HOME##*-}" >> /opt/alibaba/java.sh
FROM centos:7.7.1908 as base
ENV JAVA_HOME=/opt/alibaba/java
ENV PATH=$JAVA_HOME/bin:$PATH

COPY --from=upstream /opt/alibaba /opt/alibaba/
RUN set -eux; \
    mv /opt/alibaba/java.sh /etc/profile.d/; \
    javac -version; \
    java -version; \
    exit 0
