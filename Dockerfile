FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER Stefan Biermann 

ENV FHEM_VERSION 5.8

RUN apk add --update perl \
		     perl-device-serialport \
                     perl-io-socket-ssl \
                     perl-libwww \
                     perl-xml-simple \
                     perl-json \
                     tzdata \
        && rm -rf /var/cache/apk/*
RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN mkdir -p /opt/fhem addgroup fhem && \
    adduser -D -G fhem -G dialout -h /opt/fhem -u 1000 fhem

ADD http://fhem.de/fhem-${FHEM_VERSION}.tar.gz /fhem.tar.gz
RUN cd /opt && tar xvf /fhem.tar.gz && cd fhem-${FHEM_VERSION} &&\
    mv * ../fhem && cd .. && rm -rf fhem-${FHEM_VERSION} /fhem.tar.gz &&\
    mkdir /config && mv fhem/fhem.cfg /config &&\
    ln -s /config/fhem.cfg /opt/fhem/fhem.cfg
RUN echo 'attr global nofork 1\n' >> /opt/fhem/fhem.cfg


EXPOSE 8083 8084 8085 7072
VOLUME ["/opt/fhem/log","/opt/fhem/www","/config"]

USER fhem
COPY start-fhem.sh /start-fhem.sh
CMD /start-fhem.sh
