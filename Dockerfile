FROM centos:6.6
MAINTAINER Carlos Lima <carlos@cpan.org>

RUN curl -s -L -O http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm \
        && rpm -i --nosignature epel-release-6-8.noarch.rpm && rm $_
RUN sed -i 's/verbose=0/verbose=1/' /etc/yum/pluginconf.d/fastestmirror.conf \
        && echo -e "include_only=.jp,.ko" >> /etc/yum/pluginconf.d/fastestmirror.conf
RUN yum install -y busybox git httpd install make man mysql-server net-snmp php php-bcmath php-imap \
        php-mbstring php-mysql php-pear php-posix php-process php-soap php-xml php-xmlrpc \
        rabbitmq-server redis strace sudo syslog time wget zip
RUN sed  's/;date.timezone =/date.timezone = "Asia\/Kuala_Lumpur"/' -i /etc/php.ini
RUN sed -i -r 's/^Defaults\s+requiretty/#&/' /etc/sudoers
RUN for name in runsv runsvdir sv chpst svlogd setuidgid; do \
        ln -s /sbin/busybox "/bin/${name}"; \
    done
COPY statsdaemon /usr/local/bin/statsdaemon
RUN pear install DB
