#!/bin/bash
DISABLE_REPOS=--disablerepo='rhel-*'
INSTALL_MAVEN_PKGS="java-11-openjdk.x86_64 java-11-openjdk-javadoc.x86_64 java-11-openjdk-devel.x86_64 rh-maven35*"
INSTALL_PYTHON_PKGS="rh-python36 rh-python36-python-devel rh-python36-python-setuptools \
  rh-python36-python-wheel rh-python36-python-pip nss_wrapper httpd24 httpd24-httpd-devel \
  httpd24-mod_ssl httpd24-mod_auth_kerb httpd24-mod_ldap httpd24-mod_session atlas-devel \
  gcc-gfortran libffi-devel libtool-ltdl enchant"

rm -f /etc/yum.repos.d/content.repo
yum $DISABLE_REPOS install -y --nogpgcheck yum-utils
yum-config-manager -q --enablerepo='*'
#yum-config-manager --enable='epel'
yum install -y --nogpgcheck $INSTALL_MAVEN_PKGS $INSTALL_PYTHON_PKGS
rpm -V $INSTALL_MAVEN_PKGS $INSTALL_PYTHON_PKGS
yum -y clean all --enablerepo='*'
source scl_source enable rh-python36
scl enable rh-python36 bash
python3 -m pip install twine pylint pylint-django
mkdir -p $HOME/.m2
