# masuk ke Node Manwe
telnet 10.15.32.43 5219
# masuk ke GNS client dan capture paket antara Manwe dan Eru
# jalankan wireshark pada GNS3
# kembali ke terminal Node Manwe
# download file kitab_penciptaan.zip dari Node Manwe dan ekstrak
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip 
# install vsftpd pada Node Manwe
apt-get update
apt-get install vsftpd
# edit file konfigurasi vsftpd
nano /etc/vsftpd.conf
# hapus tanda # pada baris berikut
write_enable=YES
chroot_local_user=YES
# tambahkan baris berikut pada akhir file
allow_writeable_chroot=YES
# restart vsftpd
service vsftpd restart
# install ftp pada Node Manwe
apt-get install ftp 
# pindah terminal ke Node Eru
telnet 10.15.32.43 5216
# edit vsptd.conf agar akses ainur ke kitab_penciptaan.txt menjadi read only
nano /etc/vsftpd.conf
# tambahkan baris berikut pada akhir file
/etc/vsftpd/user_conf/ainur
write_enable=NO
# restart vsftpd
service vsftpd restart
# kembali ke terminal Node Manwe
telnet 10.15.32.43 5219
# jalankan ftp dari Node Manwe ke Node Eru
ftp 10.81.1.1 
# masukkan username ainur dan password ainur
# cek file kitab_penciptaan.txt
ls
# coba read file kitab_penciptaan.txt
cat kitab_penciptaan.txt
# coba put file kitab_penciptaan.txt
put kitab_penciptaan.txt
# gagal upload file karena akses ainur read only
# logout dari ftp
bye
