FROM sumanmukherjee03/ruby:2.2.3
MAINTAINER Suman Mukherjee <sumanmukherjee03@gmail.com>

RUN apt-get -qq update

USER webapp

RUN source /.bash_profile && gem install rails --version 4.2.5

USER root
