FROM registry.access.redhat.com/openshift3/jenkins-agent-maven-35-rhel7

EXPOSE 8080

USER root

# TODO: Remove MAVEN_OPTS env once cri-o pushes the $HOME variable in /etc/passwd
ENV LANG=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  PYTHON_VERSION=3.6 \
  PATH=$HOME/.local/bin/:$PATH \
  PYTHONUNBUFFERED=1 \
  PYTHONIOENCODING=UTF-8 \
  PIP_NO_CACHE_DIR=off

ADD ./contrib/etc/yum.repos.d /etc/yum.repos.d/
ADD ./scripts/bootstrap.sh /tmp/bootstrap.sh

# Install Python
# RUN chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh
RUN DISABLE_REPOS=--disablerepo='rhel-*' \
  INSTALL_PYTHON_PKGS="rh-python36 rh-python36-python-devel rh-python36-python-setuptools \
    rh-python36-python-wheel rh-python36-python-pip nss_wrapper httpd24 httpd24-httpd-devel \
    httpd24-mod_ssl httpd24-mod_auth_kerb httpd24-mod_ldap httpd24-mod_session atlas-devel \
    gcc-gfortran libffi-devel libtool-ltdl enchant" \
  echo "enabled=0" >> /etc/yum/pluginconf.d/subscription-manager.conf \
  yum -y update \
  yum install -y --nogpgcheck $INSTALL_PYTHON_PKGS \
  rpm -V $INSTALL_PYTHON_PKGS \
  yum -y clean all --enablerepo='*' \
  source scl_source enable rh-python36 \
  scl enable rh-python36 \
  python3 -m pip install twine pylint pylint-django

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl_enable'.
ADD ./contrib/usr/local/bin /usr/local/bin/
#ADD ./contrib/settings.xml $HOME/.m2/

#ADD scl_enable /usr/share/container-scripts/

#RUN chown -R 1001:0 $HOME && \
#  chmod -R g+rw $HOME

USER 1001
