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
<img width="1423" height="740" alt="Screenshot 2025-09-30 121541" src="https://github.com/user-attachments/assets/d9e10460-2131-477d-8259-fe77f497d540" />
-Lalu, lakukan `ip a` dan pastikan ip sesuai, simpan hasilnya 

-ulmo = `10.81.2.3` 

-varda = `10.81.2.2` 

-melkor = `10.81.1.2` 

-manwe = `10.81.1.3` 

-nameserver = `192.168.122.1` 

***

2.
Konfigurasi agar Eru yang berperan sebagai Router dapat terhubung dengan internet. Hal ini bertujuan untuk memberikan akses konektivitas eksternal sehingga jaringan lokal yang telah dibangun dapat berkomunikasi dengan jaringan global. Agar terhubung ke jaringan global, menggunakan

```
cat /etc/resolv.conf
```

pada Eru, lalu 
```
ping google.com
```

<img width="1212" height="172" alt="Screenshot 2025-09-30 131550" src="https://github.com/user-attachments/assets/617479ea-83b0-4632-9039-eb37e23259e1" /> 

***
3.
Agar setiap Ainur (Client) dapat terhubung satu sama lain, perlu mencobanya satu per satu. Contohnya menghubungkan Manwe ke Ulmo, yaitu dengan memasukkan
```
root@Manwe:~# ping 10.81.2.3
```
<img width="819" height="111" alt="Screenshot 2025-09-30 133031" src="https://github.com/user-attachments/assets/054486d1-c060-4a96-a931-d9643e3a7d4c" />

***

4.
Eru ingin agar setiap Ainur (Client) dapat mandiri. Oleh karena itu pastikan agar setiap Client dapat tersambung ke internet.
-Yaitu dengan
```
cat /etc/resolv.conf
```
 ke Eru lalu akan muncul 
 ```
nameserver 192.168.122.1
```

<img width="1212" height="172" alt="Screenshot 2025-09-30 131550" src="https://github.com/user-attachments/assets/e4feac25-2af2-4c76-aeea-13c03127aaae" />
-Langkah selanjutnya kita mencoba 1 per 1 hingga semua terhubung ke internet dengan menggunakan 

```
echo nameserver 192.168.122.1 > /etc/resolv.conf 
 ping google.com
```
<img width="1203" height="196" alt="Screenshot 2025-09-30 134227" src="https://github.com/user-attachments/assets/c99569b8-d413-442f-9bc8-0159764e77f9" /> 

*** 

<img width="1222" height="169" alt="Screenshot 2025-09-30 134725" src="https://github.com/user-attachments/assets/d9b1cb24-a975-4f7d-94b0-4e9913e3879d" /> 

*** 

<img width="1199" height="168" alt="Screenshot 2025-09-30 134845" src="https://github.com/user-attachments/assets/397a0471-91be-4bcb-b6c3-d8d5bc2a302b" /> 

*** 

<img width="1198" height="191" alt="Screenshot 2025-09-30 134944" src="https://github.com/user-attachments/assets/55f058be-5876-46d0-a505-094629144636" />

***

5.
Agar semua konfigurasi yang telah dilakukan tidak hilang ketika node di-restart, maka setiap pengaturan jaringan perlu disimpan secara permanen pada masing-masing perangkat. Hal ini meliputi konfigurasi alamat IP, Default Gateway, serta DNS Server. caranya yaitu memasukkan command yang ingin selalu dijalankan di node tersebut ke file `/root/.bashrc` di bagian paling bawah. Untuk Eru kita memasukkan `iptables` dan yang lain menggunakan `echo nameserver`

```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.81.0.0/16  
echo nameserver 192.168.122.1 > /etc/resolv.conf
```

<img width="1702" height="654" alt="Screenshot 2025-09-30 144622" src="https://github.com/user-attachments/assets/5451b21d-3339-4570-860f-d11274860ee6" /> 

***

<img width="1451" height="632" alt="Screenshot 2025-09-30 144713" src="https://github.com/user-attachments/assets/6a7f56a4-c8c5-4d9f-862f-dba851b1b735" />

***
6.
Melkor mencoba melakukan penyusupan (interception) terhadap komunikasi antara Manwe dan Eru. Untuk itu, file uji yang telah disediakan diunduh menggunakan perintah wget, kemudian dijalankan pada node Manwe. Selanjutnya dilakukan packet sniffing menggunakan Wireshark pada koneksi antara Manwe dan Eru. Setelah itu, diterapkan display filter untuk menampilkan seluruh paket yang berasal dari atau menuju alamat IP milik Manwe.
-Pada terminal node Manwe, unduh file wget
```
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5' -O traffic.zip
```
-Unzip file
```
unzip traffic.zip
```
-lalu, akan ada 2 file yaitu `traffic.sh` dan `traffic.zip`, pilih `traffic.sh`
```
cat traffic.sh
```
-Berikan izin eksekusi pada file
```
chmod x+ traffic.sh
```
-Jalankan file tersebut
```
./traffic.sh
```
-Setelah proses packet sniffing dijalankan, Wireshark akan menampilkan paket-paket komunikasi antara Manwe dan Eru sesuai dengan display filter yang telah diterapkan. Proses capture dibiarkan berlangsung hingga seluruh komunikasi yang dibutuhkan berhasil ditangkap. Setelah itu, proses capture dihentikan dan hasil tangkapan paket disimpan

***







