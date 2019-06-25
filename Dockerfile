# for Frontend
FROM alpine:latest

RUN apk add \
    python \
    py-pip \
    nodejs \
    npm \
    git \
    nginx \
    make gcc g++ \
  && pip install virtualenv \
  && npm -g install gulp

WORKDIR /app
RUN git clone https://git.openstack.org/openstack/openstack-health
WORKDIR /app/openstack-health

RUN npm install
RUN gulp prod

EXPOSE 8080
WORKDIR /app/openstack-health/build
COPY ./etc/config.json ./
RUN cp -r . /srv/www/htdocs/

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

USER nobody

ENTRYPOINT ["/usr/bin/nginx"]
CMD ["-g", "daemon off;"]
