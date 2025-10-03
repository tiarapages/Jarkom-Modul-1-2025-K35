 # masuk ke Node Melkor
telnet 10.15.43.32 5222
# masuk ke GNS client dan capture paket antara Melkor dan Eru
# jalankan wireshark pada GNS3
# kembali ke terminal Node Melkor
# masukkan user baru upin dan password upin
adduser upin
# install openbsd -inetd pada Node Melkor
apt-get update
apt-get install openbsd-inetd
# edit file /etc/inetd.conf
nano /etc/inetd.conf
# uncomment baris berikut
ftp     stream  tcp     nowait  root    /usr/sbin/tcpd  /usr/sbin/in.ftpd -l -a
# restart inetd
service openbsd-inetd restart
# pindah terminal ke Node Eru
telnet 10.15.43.32 5216
# jalankan telnet dari Node Eru ke Node Melkor
telnet 10.81.1.2
# masukkan username upin dan password upin
# akan masuk ke upin@melkor:~$
# keluar dari telnet
exit
