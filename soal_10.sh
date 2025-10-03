# masuk ke Node Melkor
telnet 10.15.43.32 5222
# jalankan perintah ping ke Node Eru dengan jumlah paket 100 sampai selesai
ping -c 100 10.81.1.1
# buat file hasil-ping.txt yang berisi hasil ping
ping -c 100 10.81.1.1 | tee ping_out.txt
# catat apakah ada paket yang hilang
# ada 0% packet loss
# logout dari Node Melkor
exit