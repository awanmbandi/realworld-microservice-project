FROM amazonlinux:2
ENV JAVA_HOME /opt/java/openjdk
ENV M2_HOME /opt/maven
ENV PATH $PATH:$JAVA_HOME/bin:$M2_HOME/bin
ENV PATH $PATH:/node-v16.18.0-linux-x64/bin
RUN yum install git -y && \
    yum install wget -y && \
    yum install tar -y && \
    yum install gzip -y && \
    yum install xz -y && \
    amazon-linux-extras install docker -y

RUN wget https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
RUN tar -xvf /node-v16.18.0-linux-x64.tar.xz
RUN mkdir -p /opt/java && \
    mkdir /opt/app
RUN wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && \
    tar xzf openjdk-11+28_linux-x64_bin.tar.gz -C /tmp && \
    mv /tmp/jdk-11 $JAVA_HOME && \
    rm openjdk-11+28_linux-x64_bin.tar.gz
RUN wget  https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz && \
    tar xzf apache-maven-3.8.6-bin.tar.gz -C /tmp && \
    mv /tmp/apache-maven-3.8.6 $M2_HOME && \
    rm apache-maven-3.8.6-bin.tar.gz
RUN curl -LO https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/
RUN wget  https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz && \
    tar xzf helm-v3.7.0-linux-amd64.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/ && \
    rm helm-v3.7.0-linux-amd64.tar.gz
RUN /usr/local/bin/helm plugin install https://github.com/belitre/helm-push-artifactory-plugin --version v0.3.0
