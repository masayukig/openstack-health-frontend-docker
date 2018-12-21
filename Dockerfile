# for Frontend
FROM opensuse:latest

RUN zypper install -y \
    python \
    python-pip \
    nodejs6 \
    npm6 \
    git \
    gcc-c++ \
    nginx \
  && pip install virtualenv
RUN zypper install -y -t pattern devel_basis

RUN npm -g install gulp

WORKDIR /app
RUN git clone https://git.openstack.org/openstack/openstack-health
WORKDIR /app/openstack-health

RUN npm install
RUN /usr/local/bin/gulp prod

# ONBUILD COPY . /app
#ONBUILD RUN virtualenv /venv && /venv/bin/pip install -r /app/requirements.txt

EXPOSE 8080
WORKDIR /app/openstack-health/build
COPY ./etc/config.json ./
RUN cp -r . /srv/www/htdocs/

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx", "-g", "daemon off;"]
