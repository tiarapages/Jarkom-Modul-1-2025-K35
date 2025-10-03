# masuk ke Node Eru
telnet 10.15.43.32 5216
# update dan install openshh-server
apt update && apt install openssh-server
# mulai service ssh
service ssh start
# aktifkan service ssh
service ssh enable
# tambahkan user eru
adduser eru
# pindah terminal dan masuk ke Node Varda
telnet 10.15.43.32 5220
# masuk ssh eru lewat node varda
ssh eru@10.81.1.1
# masukkan password eru
# nanti kita sudah masuk ke node eru dengan nama eru@eru
# dan apapun yang kita ketik di terminal eru akan dieksekusi di node eru@eru    
# selesai