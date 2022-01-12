FROM centos:latest
RUN mkdir /usr/src/cmake-example
COPY . /usr/src/cmake-example

# Install all packaged dependencies   
RUN yum -y update
RUN yum -y install \
    which \
    yum-utils \
    gcc \
    gcc-c++ \
    openssl-devel \  
    make \
    wget \
    curl \
    gcc-gfortran \
    python3 \
    git \
    autoconf \
    openssl \
    bzip2.x86_64 \
    bzip2-devel.x86_64 \
    xz-devel.x86_64 \
    zlib-devel.x86_64 \
    libcurl-devel.x86_64 \
    automake \
    c-ares-devel \
    bison \
    c-ares-devel \
    elfutils-libelf-devel  \
    flex \
    graphviz \
    json-c-devel \
    libcap-devel \
    libtool \
    libxml2-devel \
    net-snmp-devel \
    pam-devel  \
    pcre2-devel \
    pkgconfig \
    #protobuf-devel-2.5.0-8.el7.x86_64  \
    pam-devel  \
    python3-devel \
    #python3-sphinx-1.2.3-6.el7.noarch \
    readline-devel \
    #texinfo-5.1-5.el7.x86_64 \
    valgrind

#Need to add as rpms
# libcmocka-devel-1.1.5-1.el7.x86_64 doxygen-1.8.5-4.el7.x86_64 groff-1.22.2-8.el7.x86_64 lcov-1.13-1.el7.noarch protobuf-devel-2
# .5.0-8.el7.x86_64 python3-sphinx-1.2.3-6.el7.noarch texinfo-5.1-5.el7.x86_64

#Install CMake
WORKDIR /tmp
RUN wget https://cmake.org/files/v3.22/cmake-3.22.0-rc3.tar.gz
RUN tar -xzvf cmake-3.22.0-rc3.tar.gz
WORKDIR /tmp/cmake-3.22.0-rc3
RUN ./bootstrap --prefix=/usr/local
RUN make -j2
RUN make install

#Install Boost
WORKDIR /tmp
RUN wget -O boost_1_77_0.tar.gz https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.gz
RUN tar xzvf boost_1_77_0.tar.gz
WORKDIR /tmp/boost_1_77_0
RUN ./bootstrap.sh --prefix=/usr/local
RUN chmod -R a=rwx ./b2 
  


# Install Python3
WORKDIR /tmp
RUN curl -O https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz
RUN tar zxvf Python-3.9.7.tgz
WORKDIR /tmp/Python-3.9.7
RUN ./configure
RUN make -j2
RUN make install


# Protobuf C++ Install
WORKDIR /tmp
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.19.1/protobuf-cpp-3.19.1.tar.gz 
RUN tar -xf protobuf-cpp-3.19.1.tar.gz 
WORKDIR /tmp/protobuf-3.19.1
RUN ./configure
RUN make 
RUN make check 
RUN make install 
RUN ldconfig


WORKDIR /usr/src/cmake-example
#RUN git submodule update --init --recursive
RUN mkdir /usr/src/cmake-example/build
RUN echo "PWD is: $PWD"
#RUN cmake -S . -B build -DWARNINGS_AS_ERRORS=OFF  \ -DBOOST_INCLUDEDIR=/usr/local/include/boost \ -DBOOST_LIBRARYDIR=/tmp/boost_1_77_0/libs
#RUN cmake --build build


cmake -S . -B build -DWARNINGS_AS_ERRORS=OFF                 \
                    -DBOOST_INCLUDEDIR=/usr/local/include/boost \
                    -DBOOST_LIBRARYDIR=/usr/local/lib


