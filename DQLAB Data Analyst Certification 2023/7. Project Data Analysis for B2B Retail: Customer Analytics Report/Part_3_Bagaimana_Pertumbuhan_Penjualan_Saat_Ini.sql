# Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)

# Dari tabel orders_1 lakukan penjumlahan pada kolom quantity dengan fungsi aggregate sum() dan beri nama “total_penjualan”, 
# kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut dan beri nama “revenue”
# Perusahaan hanya ingin menghitung penjualan dari produk yang terkirim saja, 
# jadi kita perlu mem-filter kolom ‘status’ sehingga hanya menampilkan order dengan status “Shipped”.


# Lakukan Langkah 1 & 2, untuk tabel orders_2.
# Notes: Jangan lupa untuk mengakhiri setiap statement dengan titik koma sehingga kedua statement dapat dijalankan bersamaan.(;)

SELECT SUM(quantity) AS total_penjualan, SUM(quantity*priceeach) AS revenue FROM orders_1;

SELECT SUM(quantity) AS total_penjualan, SUM(quantity*priceeach) AS revenue FROM orders_2 WHERE status = 'Shipped';

# Menghitung persentasi keseluruhan penjualan

# Kedua tabel orders_1 dan orders_2 masih terpisah, untuk menghitung persentasi keseluruhan penjualan dari kedua tabel tersebut perlu digabungkan :

# Pilihlah kolom “orderNumber”, “status”, “quantity”, “priceEach” pada tabel orders_1, dan 
# tambahkan kolom baru dengan nama “quarter” dan isi dengan value “1”. Lakukan yang sama dengan tabel orders_2, 
# dan isi dengan value “2”, kemudian gabungkan kedua tabel tersebut.

# Gunakan statement dari Langkah 1 sebagai subquery dan beri alias “tabel_a”.
# Dari “tabel_a”, lakukan penjumlahan pada kolom “quantity” dengan fungsi aggregate sum() dan beri nama “total_penjualan”, 
# dan kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut dan beri nama “revenue”

# Filter kolom ‘status’ sehingga hanya menampilkan order dengan status “Shipped”.
# Kelompokkan total_penjualan berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.

SELECT quarter,
       SUM(quantity) AS total_penjualan,
       SUM(quantity * priceeach) AS revenue
FROM (
     SELECT orderNumber, status, quantity, priceeach, '1' AS quarter
     FROM orders_1
     UNION
     SELECT orderNumber, status, quantity, priceeach, '2' AS quarter
     FROM orders_2
) AS table_a
WHERE status = 'Shipped'
GROUP BY 1;

# Perhitungan Growth Penjualan dan Revenue
# Untuk project ini, perhitungan pertumbuhan penjualan akan dilakukan secara manual menggunakan formula yang disediakan di bawah. 
# Adapun perhitungan pertumbuhan penjualan dengan SQL dapat dilakukan menggunakan “window function” yang akan dibahas di materi DQLab berikutnya.

# %Growth Penjualan = (6717 – 8694)/8694 = -22%

# %Growth Revenue = (607548320 – 799579310)/ 799579310 = -24%
