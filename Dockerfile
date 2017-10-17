# for Frontend
FROM opensuse:tumbleweed

RUN zypper install -y \
    python \
    python2-pip \
    nodejs6 \
    npm6 \
    git \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*
RUN zypper install -y -t pattern devel_basis

RUN npm -g install gulp

WORKDIR /app
RUN git clone https://git.openstack.org/openstack/openstack-health
WORKDIR /app/openstack-health
RUN git pull https://git.openstack.org/openstack/openstack-health refs/changes/43/483843/2
RUN npm install
RUN /usr/local/bin/gulp prod

# ONBUILD COPY . /app
#ONBUILD RUN virtualenv /venv && /venv/bin/pip install -r /app/requirements.txt

EXPOSE 8080
WORKDIR /app/openstack-health/build
# FIXME: run nginx or something for build directory
CMD ["python", "-m", "SimpleHTTPServer", "8080"]
