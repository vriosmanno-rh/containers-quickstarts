FROM registry.redhat.io/openshift3/jenkins-agent-maven-35-rhel7

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

# Install Maven
RUN chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl_enable'.
ADD ./contrib/usr/local/bin /usr/local/bin/
#ADD ./contrib/settings.xml $HOME/.m2/

#ADD scl_enable /usr/share/container-scripts/

#RUN chown -R 1001:0 $HOME && \
#  chmod -R g+rw $HOME

USER 1001
