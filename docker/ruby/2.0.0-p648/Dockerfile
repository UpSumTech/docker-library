FROM sumanmukherjee03/rbenv:1.0.0
MAINTAINER Suman Mukherjee <sumanmukherjee03@gmail.com>

RUN apt-get -qq update

USER webapp

RUN echo 'gem: --no-rdoc --no-ri' >> /home/webapp/.gemrc
RUN source /.bash_profile && rbenv install 2.0.0-p648
RUN source /.bash_profile && rbenv global 2.0.0-p648
RUN source /.bash_profile && gem install bundler

USER root
