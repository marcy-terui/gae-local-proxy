FROM debian:jessie

RUN apt-get update && apt-get install -y \
        git \
        gcc \
        make \
        bison \
        ruby \
        wget \
    && gem install rake

RUN apt-get install -y libssl-dev
RUN apt-get install -y libyaml-dev
RUN apt-get install -y libpcre3-dev

WORKDIR /usr/local/src
RUN git clone -b v1.14.15 https://github.com/matsumoto-r/ngx_mruby.git
WORKDIR /usr/local/src/ngx_mruby
RUN git submodule init
RUN git submodule update
COPY build_config.rb /usr/local/src/ngx_mruby/build_config.rb
RUN sh build.sh
RUN make install
RUN ln -s /usr/local/src/ngx_mruby/build/nginx /usr/local/nginx

ADD hook /usr/local/nginx/hook
ADD conf /usr/local/nginx/conf

CMD ["/usr/local/nginx/sbin/nginx"]
