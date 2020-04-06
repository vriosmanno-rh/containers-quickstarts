FROM quay.io/openshift/origin-jenkins-agent-base:4.2

EXPOSE 8080

# TODO: Remove MAVEN_OPTS env once cri-o pushes the $HOME variable in /etc/passwd
ENV MAVEN_VERSION=3.5 \
  BASH_ENV=/usr/local/bin/scl_enable \
  ENV=/usr/local/bin/scl_enable \
  PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
  LANG=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  MAVEN_OPTS="-Duser.home=$HOME" \
  PYTHON_VERSION=3.6 \
  PATH=$HOME/.local/bin/:$PATH \
  PYTHONUNBUFFERED=1 \
  PYTHONIOENCODING=UTF-8 \
  PIP_NO_CACHE_DIR=off

ADD ./contrib/bin/ubi.repo /etc/yum.repos.d/ubi.repo
ADD ./contrib/bin/epel.repo /etc/yum.repos.d/epel.repo
ADD ./contrib/bin/epel-testing.repo /etc/yum.repos.d/epel-testing.repo

# Install Maven
RUN INSTALL_PKGS=" \
    java-11-openjdk-devel java-1.8.0-openjdk-devel rh-maven35* rh-python36 \
    rh-python36-python-devel rh-python36-python-setuptools rh-python36-python-wheel \
    rh-python36-python-pip nss_wrapper httpd24 httpd24-httpd-devel httpd24-mod_ssl \
    httpd24-mod_auth_kerb httpd24-mod_ldap httpd24-mod_session atlas-devel gcc-gfortran \
    libffi-devel libtool-ltdl enchant" && \
  DISABLE_REPOS=--disablerepo='rhel-*' && \
  yum $DISABLE_REPOS install -y yum-utils && \
  yum -y --setopt=tsflags=nodocs $DISABLE_REPOS install $INSTALL_PKGS && \
  rpm -V $INSTALL_PKGS && \
  yum -y clean all --enablerepo='*' && \
  mkdir -p $HOME/.m2 && \
  python3 -m pip install twine pylint pylint-django

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl_enable'.
ADD contrib/bin/scl_enable /usr/local/bin/scl_enable
ADD contrib/bin/configure-agent /usr/local/bin/configure-agent
ADD ./contrib/settings.xml $HOME/.m2/

RUN chown -R 1001:0 $HOME && \
  chomod -R g+rw $HOME

USER 1001