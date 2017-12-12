openstack-health-frontend-docker
================================

.. image::
    https://img.shields.io/docker/build/masayukig/openstack-health-frontend.svg
    :target: https://hub.docker.com/r/masayukig/openstack-health-frontend/builds/
.. image::
    https://img.shields.io/docker/automated/masayukig/openstack-health-frontend.svg
    :target: https://hub.docker.com/r/masayukig/openstack-health-frontend/

This is a fontend of openstack-health docker image.

How to build
------------

You can build this docker image like below::

  $ docker build -t masayukig/openstack-health-frontend:latest .

Or if you'd like to update the openstack-health code base, you can do it::

  $ docker build --no-cache -t masayukig/openstack-health-frontend:latest .


How to run
----------

You can specify the listen port like below::

  $ docker run -d -p 8080:8080 --rm masayukig/openstack-health-frontend:latest

