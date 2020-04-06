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
ADD ./contrib/bin/redhat.repo /etc/yum.repos.d/redhat.repo
ADD ./scripts/bootstrap.sh /tmp/bootstrap.sh

# Install Maven
RUN chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl_enable'.
ADD contrib/bin/scl_enable /usr/local/bin/scl_enable
ADD contrib/bin/configure-agent /usr/local/bin/configure-agent
ADD ./contrib/settings.xml $HOME/.m2/

RUN chown -R 1001:0 $HOME && \
  chmod -R g+rw $HOME

USER 1001
