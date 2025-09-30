# Jarkom-Modul-1-2025-K35

| Nama | NRP |
|---|---|
| Tiara Putri Prasetya | 5027241013 |
| Naufal Ardhana | 5027241118 |

 # 1. 
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

# 2.
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
# 3.
Agar setiap Ainur (Client) dapat terhubung satu sama lain, perlu mencobanya satu per satu. Contohnya menghubungkan Manwe ke Ulmo, yaitu dengan memasukkan
```
root@Manwe:~# ping 10.81.2.3
```
<img width="819" height="111" alt="Screenshot 2025-09-30 133031" src="https://github.com/user-attachments/assets/054486d1-c060-4a96-a931-d9643e3a7d4c" />

***

# 4.
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

# 5.
Agar semua konfigurasi yang telah dilakukan tidak hilang ketika node di-restart, maka setiap pengaturan jaringan perlu disimpan secara permanen pada masing-masing perangkat. Hal ini meliputi konfigurasi alamat IP, Default Gateway, serta DNS Server. caranya yaitu memasukkan command yang ingin selalu dijalankan di node tersebut ke file `/root/.bashrc` di bagian paling bawah. Untuk Eru kita memasukkan `iptables` dan yang lain menggunakan `echo nameserver`

```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.81.0.0/16  
echo nameserver 192.168.122.1 > /etc/resolv.conf
```

<img width="1702" height="654" alt="Screenshot 2025-09-30 144622" src="https://github.com/user-attachments/assets/5451b21d-3339-4570-860f-d11274860ee6" /> 

***

<img width="1451" height="632" alt="Screenshot 2025-09-30 144713" src="https://github.com/user-attachments/assets/6a7f56a4-c8c5-4d9f-862f-dba851b1b735" />

***
# 6.
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

# 14.
- How many packets are recorded in the pcapng file? `500358`

<img width="176" height="63" alt="Screenshot 2025-09-29 183216" src="https://github.com/user-attachments/assets/07a5f318-8ee7-40e6-9dab-0cb4a9f7bcb7" />

- What are the user that successfully logged in? `n1enna:y4v4nn4_k3m3nt4r1`

<img width="1872" height="848" alt="Screenshot 2025-09-29 182650" src="https://github.com/user-attachments/assets/6a125162-b639-4f1c-b51a-f3598fc17afa" />

- In which stream were the credentials found? `41824`

<img width="255" height="81" alt="Screenshot 2025-09-29 182832" src="https://github.com/user-attachments/assets/becb65f4-37d2-4cf6-a92c-3a43a262baca" />

- What tools are used for brute force? `Fuzz Faster U Fool v2.1.0-dev`

<img width="423" height="42" alt="Screenshot 2025-09-29 183124" src="https://github.com/user-attachments/assets/5e11c485-3cdb-46b1-a62b-0ed96d7700c1" />

```
Congratulations! Here is your flag: KOMJAR25{Brut3_F0rc3_XL99oxmMPifll1JV9benttW21}
```

<img width="691" height="382" alt="Screenshot 2025-09-30 154504" src="https://github.com/user-attachments/assets/0f27068e-f5bb-4b8a-8a95-dcb2dbc352e5" />

# 15.
- What device does Melkor use? `Keyboard`

menggunakan `usb.bDescriptorType == 0x03 and usb.data_len > 0`

<img width="781" height="136" alt="Screenshot 2025-09-29 175400" src="https://github.com/user-attachments/assets/980606ad-6dcb-404f-9f2f-bd5c5620c43e" />

-What did Melkor write? `UGx6X3ByMHYxZGVfeTB1cl91czNybjRtZV80bmRfcDRzc3cwcmQ=`

<img width="1089" height="578" alt="image" src="https://github.com/user-attachments/assets/dac53f66-d035-4711-bc0c-cecd748289bf" />

Pertama kita gunakan filter untuk membuat file dari n0 15 hanya menampilkan info URB_INTERRUPT in dari pcapng.

<img width="1589" height="674" alt="image" src="https://github.com/user-attachments/assets/d45371fc-e3b1-42c8-a433-c6eb0b2fbde9" />
Kemudian kita bisa export spesified file dan menamainya bisa final.pcapng
<img width="778" height="370" alt="image" src="https://github.com/user-attachments/assets/602f4fc2-d347-41c5-90c4-9899cd611347" />
Setelah itu buka terminal dan masuk ke dalam dir yang terdapat file pcapnya, dan jalankan command ini `tshark -r ~/Downloads/final.pcapng -Y "usb.capdata" -T fields -e usb.capdata | tr -d : >> keystroke.txt
` untuk menemukan usb.capdata pada file tersbut dan memasukann hasilnya pada keystroke.txt
<img width="780" height="60" alt="image" src="https://github.com/user-attachments/assets/f518d74b-2da0-4e75-b242-a463c1759607" />
Buat sebuah file solver yang nantinya akan digunakan untuk decode file final.pcapng. FIle berupa file phyton dengan nama `decode_keystroke.py`
```
#!/usr/bin/env python3
# decode_keyboard.py
# Usage:
#   python3 decode_keyboard.py keystroke.txt
import sys, os

# mappings
l = {i: chr(ord('a') + (i-4)) for i in range(4, 30)}   # 4..29 -> a..z
nums = {
 30:('1','!'),31:('2','@'),32:('3','#'),33:('4','$'),34:('5','%'),
 35:('6','^'),36:('7','&'),37:('8','*'),38:('9','('),39:('0',')')
}
for k,(low,up) in nums.items():
    l[k]=low

others = {
 40:('','\n'), 44:(' ',' '),45:('-','_'),46:('=','+'),47:('[','{'),48:(']','}'),
 49:('\\','|'),51:(';',':'),52:("'",'"'),53:('`','~'),54:(',','<'),55:('.','>'),56:('/','?')
}
for k,(low,up) in others.items():
    l[k]=low

# reverse uppercase map handled by shift flag (we will use upper() for letters; numbers use nums)
def decode_report(hexline):
    s = hexline.strip().replace(':','').replace(' ','')
    if len(s) < 6:
        return ''
    try:
        ba = bytearray.fromhex(s)
    except:
        return ''
    if len(ba) < 3:
        return ''
    mod = ba[0]
    key = ba[2]
    if key == 0:
        return ''
    shift = (mod & 0x02) != 0 or (mod & 0x20) != 0
    # letters
    if 4 <= key <= 29:
        ch = chr(ord('a') + (key - 4))
        return ch.upper() if shift else ch
    # numbers with shift symbols
    if key in nums:
        return nums[key][1] if shift else nums[key][0]
    # other mapped keys
    if key in others:
        low,up = others[key]
        return up if shift else low
    # fallback: unknown -> return empty or hex
    return ''

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 decode_keyboard.py keystroke.txt", file=sys.stderr); sys.exit(1)
    path = sys.argv[1]
    if not os.path.exists(path):
        print("File not found:", path, file=sys.stderr); sys.exit(1)
    out=[]
    with open(path,'r',errors='ignore') as f:
        for line in f:
            ch = decode_report(line)
            if ch:
                out.append(ch)
    print(''.join(out))

if __name__ == '__main__':
    main()
```
Kode tersebut akan membuat file `final.pcapng` di decode dengan format pada phyton
<img width="782" height="33" alt="image" src="https://github.com/user-attachments/assets/19c54f19-a1dc-4474-94a1-678b89e69524" />
Dan didapatkan hasil sebagai berikut yang merupakan jawaban soal ke-2
<img width="984" height="141" alt="image" src="https://github.com/user-attachments/assets/4dfb0edc-8582-43cd-8196-b03614750af2" />
Kemudian kita gunakan decode base 64 dan didapatkan soal terakhir sehingga flag dapat ditemukan seutuhnya
<img width="1110" height="394" alt="image" src="https://github.com/user-attachments/assets/a2d4321c-1df6-43ce-a172-2ccf169e14ce" />



# 16.
- What credential did the attacker use to log in? `ind@psg420:{6r_6e#TfT1p`

<img width="1229" height="79" alt="Screenshot 2025-09-30 155516" src="https://github.com/user-attachments/assets/0fe35f97-b421-460a-8413-0aef1e493bce" />
<img width="421" height="101" alt="Screenshot 2025-09-30 155533" src="https://github.com/user-attachments/assets/85db3570-ad17-4618-b2ad-8eeb0cb84eab" />

- How many files are suspected of containing malware? `5` -> Menggunakan `ftp-data` lalu akan muncul 5 yaitu QWERT

File berekstensi `.exe` merupakan file eksekusi yang dijalankan oleh sistem operasi. Dalam konteks praktikum ini, file tersebut digunakan sebagai bagian dari simulasi komunikasi antara node. Oleh karena itu, file `.exe` harus disimpan terlebih dahulu agar dapat dijalankan di lingkungan uji. Perintah `sha256sum` digunakan untuk menghasilkan nilai hash dari suatu file. Nilai hash ini berfungsi sebagai “sidik jari digital” file, yang unik untuk setiap isi file. Setelah menjalankan perintah `sha256sum` nama_file.exe, sistem akan menampilkan deretan karakter heksadesimal sepanjang 64 digit.

- What is the hash of the first file (q.exe)? `a34b0926cdc3242bbfad1c4a0b42cc2750d90db9a272d92cfb6cb7034d2a3bd`

- What is the hash of the second file (q.exe)? `08eb941447078ef2c6ad8d91bb2f52256c09657ecd3d5344023edccf7291e9fc`

- What is the hash of the third file (e.exe)? `32e1b3732cd779af1bf7730d0ec8a7a87a084319f6a0870dc7362a15ddbd3199`

- What is the hash of the fourth file (r.exe)? `4ebd58007ee933a0a8348aee2922904a7110b7fb6a316b1c7fb2c6677e613884`

- What is the hash of the fifth file (t.exe)? `10ce4b79180a2ddd924fdc95951d968191af2ee3b7dfc96dd6a5714dbeae613a`

<img width="624" height="361" alt="Screenshot 2025-09-29 195038" src="https://github.com/user-attachments/assets/2bb64d2a-b407-4260-9af1-d28f6a830550" />

# 17.

Fitur Export Objects pada Wireshark digunakan untuk mengekstrak data atau objek yang ditangkap dari sebuah sesi komunikasi jaringan. Ketika protokol tertentu (misalnya HTTP, FTP, SMB, TFTP, dll.) terbaca dalam paket, Wireshark mampu merekonstruksi dan mengekstrak file yang ditransfer melalui protokol tersebut.HTTP menunjukkan bahwa Wireshark mendeteksi adanya lalu lintas HTTP di antara node yang sedang di-capture. Dengan menggunakan menu ini, pengguna dapat mengekspor file, halaman web, atau objek lain yang dikirim melalui protokol HTTP selama sesi komunikasi.

- What is the name of the first suspicious file? `Invoice&MSO-Request.doc`
  
- What is the name of the second suspicious file? `knr.exe`
  
- What is the hash of the second suspicious file (knr.exe)? `749e161661290e8a2d190b1a66469744127bc25bf46e5d0c6f2e835f4b92db18`

```
KOMJAR25{M4ster_4n4lyzer_5e8X5lLodU1wEOR4jIwlznzkA}
```

# 18.

Fitur Export Objects → SMB pada Wireshark digunakan untuk mengekstrak objek atau file yang ditransfer melalui protokol SMB (Server Message Block). Protokol SMB umumnya digunakan dalam sistem operasi berbasis Windows untuk layanan berbagi berkas (file sharing), printer, maupun komunikasi antar-proses. Dengan memilih opsi ini, Wireshark akan menampilkan daftar file atau objek yang berhasil ditangkap selama sesi komunikasi SMB. Dari daftar tersebut, pengguna dapat menyimpan file tertentu ke dalam komputer lokal untuk dianalisis lebih lanjut.

- How many files are suspected of containing malware? `2`
  
<img width="494" height="527" alt="Screenshot 2025-09-30 160949" src="https://github.com/user-attachments/assets/2df18c12-9fb9-4eca-aed9-3e178794ccf7" />
<img width="736" height="158" alt="Screenshot 2025-09-30 161015" src="https://github.com/user-attachments/assets/312598dd-1fa1-4e4c-b91a-bd7212dfaffb" />


- What is the name of the first malicious file? `d0p2nc6ka3f_fixhohlycj4ovqfcy_smchzo_ub83urjpphrwahjwhv_o5c0fvf6.exe `

- Apa nama file berbahaya yang kedua? `oiku9bu68cxqenfmcsos2aek6t07_guuisgxhllixv8dx2eemqddnhyh46l8n_di.exe`

- What is the hash of the first malicious file? `59896ae5f3edcb999243c7bfdc0b17eb7fe28f3a66259d797386ea470c010040`

- What is the hash of the second malicious file? `cf99990bee6c378cbf56239b3cc88276eec348d82740f84e9d5c343751f82560`

```
KOMJAR25{Y0u_4re_g0dl1ke_rd6nqSP2WXo3hnjT1XazFnLnk}
```

<img width="768" height="446" alt="Screenshot 2025-09-30 163143" src="https://github.com/user-attachments/assets/2d84543b-faa7-4728-900f-03a71ecf44f8" />

# 19.
Who sent the threatening message? `Your Life`

How much ransom did the attacker demand ($)? `1600`

What is the attacker's bitcoin wallet? `1CWHmuF8dHt7HBGx5RKKLgg9QA2GmE3UyL`

```
Congratulations! Here is your flag: KOMJAR25{Y0u_4re_J4rk0m_G0d_s0GIAQDBcilWt0UlOrrUXgl7y}
```
<img width="313" height="72" alt="Screenshot 2025-09-30 164224" src="https://github.com/user-attachments/assets/d632faba-a3c8-447c-8127-b3ded89e06a2" />
<img width="792" height="142" alt="Screenshot 2025-09-30 164238" src="https://github.com/user-attachments/assets/828c28ec-ae95-46c5-8d3f-a5f8c4ca0f4a" />

# 20.















