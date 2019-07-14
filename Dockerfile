FROM centos:7.6.1810

ENV JAVA_PACKAGE_NAME=java-1.8.0-alibaba-dragonwell
ENV JAVA_HOME=/opt/alibaba/java
ENV PATH=$JAVA_HOME/bin:$PATH

RUN set -eux; \
    printf '# plus packages provided by Aliyun Linux dev team\n[plus]\nname=AliYun-2.1903 - Plus - mirrors.aliyun.com\nbaseurl=https://mirrors.aliyun.com/alinux/2.1903/plus/$basearch/\ngpgcheck=1\ngpgkey=https://mirrors.aliyun.com/alinux/RPM-GPG-KEY-ALIYUN' > /etc/yum.repos.d/alinux-plus.repo; \
    yum install -y $JAVA_PACKAGE_NAME; \
    ln -s $(rpm -q --scripts ${JAVA_PACKAGE_NAME}|grep -oP 'JAVA_HOME=\K([a-zA-Z0-9/\.-]*)') $JAVA_HOME ; \
    rm -rf $JAVA_HOME/src.zip $JAVA_HOME/demo $JAVA_HOME/sample; \
    echo "JAVA_VERSION=$(rpm -q ${JAVA_PACKAGE_NAME} --qf '%{VERSION}')" >> /etc/profile.d/java.sh; \
    yum clean all; \
    rm -rf /var/cache/yum; \
    javac -version; \
    java -version; \
    exit 0
