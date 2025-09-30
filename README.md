# Jarkom-Modul-1-2025-K35

| Nama | NRP |
|---|---|
| Tiara Putri Prasetya | 5027241013 |
| Naufal Ardhana | 5027241118 |

1. 
Pada tahap perancangan, Eru yang berperan sebagai Router menambahkan dua buah Switch/Gateway untuk mendistribusikan koneksi jaringan. Switch 1 dikonfigurasikan agar terhubung dengan dua Client, yaitu Melkor dan Manwe. Sedangkan Switch 2 dikonfigurasikan untuk terhubung dengan dua Client lainnya, yaitu Varda dan Ulmo. Dengan demikian, keempat Client tersebut dapat berkomunikasi melalui jaringan yang dikelola oleh Router Eru.
-Pertama,  setting network masing-masing node dengan fitur Edit network configuration, Prefix IP menggunakan `10.81` untuk kelompok 35
Eru
```auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address [Prefix IP].1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address [Prefix IP].2.1
	netmask 255.255.255.0
```
Melkor
```auto eth0
iface eth0 inet static
	address 10.81.1.2
	netmask 255.255.255.0
	gateway 10.81.1.1
```
Manwe
```auto eth0
iface eth0 inet static
	address 10.81.1.3
	netmask 255.255.255.0
	gateway 10.81.1.1
```
Varda
```auto eth0
iface eth0 inet static
	address 10.81.2.2
	netmask 255.255.255.0
	gateway 10.81.2.1
```
Ulmo
```auto eth0
iface eth0 inet static
	address 10.81.2.3
	netmask 255.255.255.0
	gateway 10.81.2.1
```
-Lalu, Start semua nodes hingga semua berubah menjadi warna hijau
-Lalu, lakukan `ip a` dan pastikan ip sesuai
<img width="1423" height="740" alt="Screenshot 2025-09-30 121541" src="https://github.com/user-attachments/assets/d9e10460-2131-477d-8259-fe77f497d540" />
***
2.
Konfigurasi agar Eru yang berperan sebagai Router dapat terhubung dengan internet. Hal ini bertujuan untuk memberikan akses konektivitas eksternal sehingga jaringan lokal yang telah dibangun dapat berkomunikasi dengan jaringan global. 
