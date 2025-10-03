# download vsftpd
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
# buat user baru ainur dan melkor
adduser ainur
adduser melkor
# tambahakan tiga baris berikut pada akhir file 
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
# edit file /etc/vsftpd.userlist
echo "ainur" | tee /etc/vsftpd.userlist
# restart vsftpd
service vsftpd restart
# buat file rahasia di home ainur
echo "ini file khusus ainur." | tee /home/ainur/file_rahasia.txt
# install ftp
apt-get install ftp
# login sebagai ainur dari Node Eru
ftp 10.81.1.1
# masukkan username ainur dan password ainur
# cek file rahasia ainur
ls
# coba write file sebagai ainur
echo "coba write file" | tee coba.txt
# coba read file sebagai ainur
put coba.txt
# logout dari ftp
bye
# login sebagai melkor dari Node Eru
ftp 10.81.1.1 
# masukkan username melkor dan password melkor
# melkor tidak memiliki akses
# login failed
# logout dari ftp
bye