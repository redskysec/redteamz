FROM  ubuntu
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt-get install -y locales locales-all
# Set default locale for the environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


#RUN  apt-get update \
#     && apt-get install -y --no-install-recommends \
#        build-essential \
#        git \
#        libsqlite3-dev \
#        nodejs \
#        software-properties-common sqlite3 \
#        netcat curl iputils-ping \
#     && apt-add-repository -y ppa:brightbox/ruby-ng \
#     && apt-get update \
#     && apt-get install -y \
#        ruby2.4 \
#        ruby2.4-dev \
#        zlib1g \
#        zlib1g-dev \
#    && rm -rf /var/lib/apt/lists/*

# Base packages
RUN apt-get update && apt-get -y install git bundler nodejs \
    zlib1g-dev libsqlite3-dev libcurl4 libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8 && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale  && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 



RUN git clone git://github.com/beefproject/beef.git /opt/beef

WORKDIR /opt/beef
ADD configs/beef.yaml /opt/beef/beef.yaml
ADD configs/metasploit-conf.yaml /opt/beef/extensions/metasploit/config.yaml

RUN bundle install

EXPOSE 3000

ADD entrypoint.sh entrypoint.sh
#CMD ["./beef", '-c', '/opt/beef/beef.yaml']
entrypoint bash entrypoint.sh
