# masuk ke Node Eru
telnet 10.15.43.32 5216
# coba jalankan netcat dari Node Eru ke Node Melkor ke port  21 dan 80
nc -vz 10.81.1.2 21 80
# pertama akan gagal karena belum ada vsptpd dan apache di Node Eru
# install vsftpd dan apache2 pada Node Eru
apt-get update
apt-get install vsftpd apache2
# restart apache2
service apache2 restart
# restart vsftpd
service vsftpd restart
# coba jalankan netcat dari Node Eru ke Node Melkor ke port  21 dan 80
nc -zv 10.81.1.2 21 80
# sudah berhasil
# sekarang coba jalankan netcat ke port 666
nc -zv 10.81.1.2 21 80 666
# gagal karena belum ada yang buka port 666 di Node Melkor
# keluar dari Node Eru
exit
