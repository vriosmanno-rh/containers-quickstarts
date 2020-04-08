#!/bin/bash
DISABLE_REPOS=--disablerepo='rhel-*'
INSTALL_PYTHON_PKGS="rh-python36 rh-python36-python-devel rh-python36-python-setuptools \
  rh-python36-python-wheel rh-python36-python-pip nss_wrapper httpd24 httpd24-httpd-devel \
  httpd24-mod_ssl httpd24-mod_auth_kerb httpd24-mod_ldap httpd24-mod_session atlas-devel \
  gcc-gfortran libffi-devel libtool-ltdl enchant"

# Silence annoying subscription messages.
echo "enabled=0" >> /etc/yum/pluginconf.d/subscription-manager.conf
#rm -f /etc/yum.repos.d/content.repo
yum -y update;
#yum clean all;
#yum-config-manager --enablerepo='*'
#yum repolist

#yum $DISABLE_REPOS install -y --nogpgcheck yum-utils
yum install -y --nogpgcheck $INSTALL_PYTHON_PKGS
rpm -V $INSTALL_PYTHON_PKGS
yum -y clean all --enablerepo='*'
source scl_source enable rh-python36
scl enable rh-python36
python3 -m pip install twine pylint pylint-django
#mkdir -p $HOME/.m2
