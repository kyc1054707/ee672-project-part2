FROM ubuntu:14.04
MAINTAINER KuanYing Chen <exq4mi@gmail.com>

WORKDIR /opt
RUN apt-get -y update
RUN apt-get -y install wget python gfortran cmake zip gzip tar g++ gcc python-cvxopt liblapack-dev python-dev build-essential
RUN apt-get -y upgrade

RUN wget https://sourceforge.net/projects/math-atlas/files/Stable/3.10.3/atlas3.10.3.tar.bz2
RUN wget http://www.netlib.org/lapack/lapack-3.4.0.tgz
RUN wget https://github.com/cvxopt/cvxopt/archive/master.zip
RUN wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.3.tar.gz

RUN tar jxvf atlas3.10.3.tar.bz2
RUN tar -zxvf lapack-3.4.0.tgz
RUN tar -xf SuiteSparse-4.5.3.tar.gz
RUN unzip master.zip
RUN mkdir atlas
RUN mv ATLAS/ ATLAS3.10.3
RUN mv cvxopt-master/ cvxopt

WORKDIR /opt/lapack-3.4.0
RUN mv make.inc.example make.inc
RUN sed -i 's/\#lib: blaslib variants lapacklib tmglib/lib: blaslib lapacklib tmglib/g' Makefile
RUN sed -i 's/lib: lapacklib tmglib/\#lib: lapacklib tmglib/g' Makefile
#RUN sed
#RUN sed
RUN make

WORKDIR /opt/ATLAS3.10.3
RUN mkdir ATLAS_build
WORKDIR /opt/ATLAS3.10.3/ATLAS_build/
RUN ../configure -b 64 -D c -DPentiumCPS=3499.998 -Fa alg -fPIC --with-netlib-lapack-tarfile=/opt/lapack-3.4.0.tgz --prefix=/opt/atlas
RUN make build
RUN make check
RUN make time
RUN make install

WORKDIR /opt
RUN  export CVXOPT_SUITESPARSE_SRC_DIR=$(pwd)/SuiteSparse
WORKDIR /opt/cvxopt
RUN sed -i "s/BLAS_LIB_DIR = '\/usr/BLAS_LIB_DIR = '\/opt\/atlas/g" setup.py 
RUN sed -i "s/BLAS_LIB = \['blas'\]/BLAS_LIB = \['cblas'\,'f77blas'\,'atlas'\]/g" setup.py
RUN python setup.py install

EXPOSE 80
