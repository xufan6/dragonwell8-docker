FROM centos:7.6.1810

ENV JAVA_HOME /usr/local/dragonwell8
ENV PATH $JAVA_HOME/bin:$PATH

ENV Jdk_Version="8.0-preview" \
    Jdk_file_sha256="e05f05ce62ab6ecb3c18fb18b08541812dcefaacdac0abff14341daa55986097"
ENV Jdk_file_name="Alibaba_Dragonwell8_Linux_x64_"$Jdk_Version".tar.gz" \
    Jdk_Base_Url="https://github.com/alibaba/dragonwell8/releases/download"

RUN set -eux; \
    curl -s -L -o "$Jdk_file_name" "$Jdk_Base_Url"/"$Jdk_Version"/"$Jdk_file_name" && \
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
