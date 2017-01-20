FROM ubuntu:14.04
MAINTAINER Kuanying <exq4mi@gmail.com>

WORKDIR /opt
RUN apt-get update
RUN apt-get install wget python gfortran cmake zip gzip tar g++ gcc
RUN apt-get upgrade

EXPOSE 80
