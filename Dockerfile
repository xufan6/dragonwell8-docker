FROM centos:7.6.1810

ENV JAVA_HOME /usr/local/dragonwell8
ENV PATH $JAVA_HOME/bin:$PATH

ENV Jdk_Version="8.0.0-GA" \
    Jdk_file_sha256="0ba706b8e0d9e6511e7f15b3faccde55e13f6d2f698431c75aeb2c98cfed1375"
ENV Jdk_file_name="Alibaba_Dragonwell_"$Jdk_Version"_Linux_x64.tar.gz" \
    Jdk_Base_Url="https://github.com/alibaba/dragonwell8/releases/download"

RUN set -eux; \
    curl -v -L -o "$Jdk_file_name" "$Jdk_Base_Url"/v"$Jdk_Version"/"$Jdk_file_name" && \
    echo -n "$Jdk_file_sha256 $Jdk_file_name"|sha256sum -c - && \
    mkdir -p "$JAVA_HOME"; \
    tar --extract \
        --file "$Jdk_file_name" \
        --directory "$JAVA_HOME" \
        --strip-components 1 \
        --no-same-owner \
    ; \
    rm -f "$Jdk_file_name"; \
    rm -f "$JAVA_HOME"/src.zip; \
    javac -version; \
    java -version; \
    exit 0
