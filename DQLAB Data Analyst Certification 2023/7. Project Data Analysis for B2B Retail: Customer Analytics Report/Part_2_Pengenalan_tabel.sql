# Tabel yang akan digunakan pada project kali ini adalah sebagai berikut.

# Tabel orders_1 : Berisi data terkait transaksi penjualan periode quarter 1 (Jan – Mar 2004)
# Tabel Orders_2 : Berisi data terkait transaksi penjualan periode quarter 2 (Apr – Jun 2004)
# Tabel Customer : Berisi data profil customer yang mendaftar menjadi customer xyz.com

# Memahami table
# Sebelum memulai menyusun query SQL dan membuat Analisa dari hasil query, 
# hal pertama yang perlu dilakukan adalah menjadi familiar dengan tabel yang akan digunakan. 
# Hal ini akan sangat berguna dalam menentukan kolom mana sekiranya berkaitan dengan problem yang akan dianalisa, 
# dan proses manipulasi data apa yang sekiranya perlu dilakukan untuk kolom – kolom tersebut, karena tidak semua kolom pada tabel perlu untuk digunakan.

# Mengecek tabel orders_1 :SELECT * FROM orders_1 limit 5;
# Mengecek tabel orders_2 :SELECT * FROM orders_2 limit 5;
# Mengecek tabel customer :SELECT * FROM customer limit 5;
# Lakukan pengecekan data di query editor dan jika berhasil hasil sebagai berikut

SELECT * FROM orders_1 limit 5;

SELECT * FROM orders_2 limit 5;

SELECT * FROM customer limit 5;
