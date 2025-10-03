
# memasukkan command yang ingin selalu dijalankan di node tersebut ke file agar saat di restart tidak hilang

# Eru 
nano /root/.bashrc 
apt update && apt install iptables -y
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.81.0.0/16
# Pada Eru ketik iptables agar semua komputer di jaringan lokal bisa berbagi 1 IP untuk akses internet.

# Pada Ainur lain
nano /root/.bashrc
echo nameserver 192.168.122.1 > /etc/resolv.conf