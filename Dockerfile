FROM centos:7.6.1810

ENV JAVA_PACKAGE_NAME=java-1.8.0-alibaba-dragonwell

RUN set -eux; \
    printf '# plus packages provided by Aliyun Linux dev team\n[plus]\nname=AliYun-2.1903 - Plus - mirrors.aliyun.com\nbaseurl=https://mirrors.aliyun.com/alinux/2.1903/plus/$basearch/\ngpgcheck=1\ngpgkey=https://mirrors.aliyun.com/alinux/RPM-GPG-KEY-ALIYUN' > /etc/yum.repos.d/alinux-plus.repo; \
    yum install -y $JAVA_PACKAGE_NAME; \
    export JAVA_HOME=$(rpm -q --scripts ${JAVA_PACKAGE_NAME}|grep -oP 'JAVA_HOME=\K([a-zA-Z0-9/\.-]*)'); \
    export PATH=$JAVA_HOME/bin:$PATH; \
    export JAVA_VERSION=$(rpm -q ${JAVA_PACKAGE_NAME} --qf '%{VERSION}'); \
    rm -f $JAVA_HOME/src.zip; \
    yum clean all; \
    rm -rf /var/cache/yum; \
    javac -version; \
    java -version; \
    exit 0
