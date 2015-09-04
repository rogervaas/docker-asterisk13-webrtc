FROM centos:centos6
MAINTAINER Alexandr Opryshko "sclif13@gmail.com" 
RUN yum -y clean all && yum -y update && yum -y install epel-release && yum -y install wget vim tar htop gcc-c++ make gnutls-devel kernel-devel libxml2-devel ncurses-devel subversion doxygen texinfo curl-devel net-snmp-devel neon-devel uuid-devel libuuid-devel sqlite-devel sqlite git speex-devel gsm-devel libtool && ldconfig

WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/certified-asterisk-13.1-current.tar.gz && tar -zxvf certified-asterisk-13.1-current.tar.gz

WORKDIR /usr/src/certified-asterisk-13.1-cert2/contrib/scripts
RUN ./install_prereq install && ./install_prereq install-unpackaged && ./get_mp3_source.sh

WORKDIR /usr/src/certified-asterisk-13.1-cert2
RUN ./configure CFLAGS='-g -O2' --libdir=/usr/lib64 && make && make install && make samples

WORKDIR /root
CMD ["/usr/sbin/asterisk", "-vvvvvvv"]