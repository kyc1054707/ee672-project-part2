FROM ubuntu:14.04
MAINTAINER Kuanying <exq4mi@gmail.com>

WORKDIR /opt
RUN apt-get -y update
RUN apt-get -y install wget python gfortran cmake zip gzip tar g++ gcc liblapack-dev python-dev build-essential
RUN apt-get -y upgrade

RUN wget https://sourceforge.net/projects/math-atlas/files/Stable/3.10.3/atlas3.10.3.tar.bz2
RUN wget http://www.netlib.org/lapack/lapack-3.4.0.tgz
RUN wget https://github.com/cvxopt/cvxopt/archive/master.zip
RUN wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.3.tar.gz

RUN tar jxvf atlas3.10.3.tar.bz2
RUN tar -zxvf lapack-3.4.0.tgz
RUN tar -xf SuiteSparse-4.5.3.tar.gz
RUN unzip master.zip

WORKDIR /opt/lapack-3.4.0




EXPOSE 80
