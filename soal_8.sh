# masuk ke Node Ulmo
telnet 10.15.43.32 5221 
# download file 8.zip dari Node Ulmo dan ekstrak
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O ramalan-cuaca.zip
unzip ramalan-cuaca.zip     
# ubah isi vstfpd.conf agar Node Eru bisa masuk ke Node Ulmo menggunakan ftp
nano /etc/vsftpd.conf
# restart vsftpd
service vsftpd restart
# list untuk melihat file ramalan-cuaca.sh
ls
# jalankan ftp dari Node Ulmo ke Node Eru
ftp 10.81.1.1 
# masukkan username ainur dan password ainur
# coba upload file cuaca.txt    
put cuaca.txt
# coba upload file mendung.jpg
put mendung.jpg
#berhasil upload kedua file
# logout dari ftp
bye
