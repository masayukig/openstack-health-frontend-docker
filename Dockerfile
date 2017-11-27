# for Frontend
FROM opensuse:latest

RUN zypper install -y \
    python \
    python-pip \
    nodejs6 \
    npm6 \
    git \
    gcc-c++ \
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
RUN cp ../etc/config.json ./
# FIXME: run nginx or something for build directory
CMD ["python", "-m", "SimpleHTTPServer", "8080"]
