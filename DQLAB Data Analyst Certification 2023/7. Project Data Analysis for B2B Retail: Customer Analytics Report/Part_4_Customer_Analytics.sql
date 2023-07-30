# Apakah jumlah customers xyz.com semakin bertambah?
# Penambahan jumlah customers dapat diukur dengan membandingkan total jumlah customers yang registrasi di periode saat ini 
# dengan total jumlah customers yang registrasi diakhir periode sebelumnya.

# Dari tabel customer, pilihlah kolom customerID, createDate dan tambahkan kolom baru dengan menggunakan fungsi QUARTER(…) 
# untuk mengekstrak nilai quarter dari CreateDate dan beri nama “quarter”

# Filter kolom “createDate” sehingga hanya menampilkan baris dengan createDate antara 1 Januari 2004 dan 30Juni 2004
# Gunakan statement Langkah 1 & 2 sebagai subquery dengan alias tabel_b
# Hitunglah jumlah unik customers à tidak ada duplikasi customers dan beri nama “total_customers”
# Kelompokkan total_customer berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.

SELECT quarter, COUNT(DISTINCT customerID) AS total_customers
FROM (SELECT customerID, createDate, quarter(createDate) AS quarter FROM customer WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') AS tabel_b
GROUP BY quarter;

# Seberapa banyak customers tersebut yang sudah melakukan transaksi?
# Problem ini merupakan kelanjutan dari problem sebelumnya yaitu dari sejumlah customer yang registrasi di periode quarter-1 dan quarter-2, berapa banyak yang sudah melakukan transaksi

# Dari tabel customer, pilihlah kolom customerID, createDate dan tambahkan kolom baru dengan menggunakan fungsi QUARTER(…) untuk mengekstrak nilai quarter dari CreateDate dan beri nama “quarter”
# Filter kolom “createDate” sehingga hanya menampilkan baris dengan createDate antara 1 Januari 2004 dan 30 Juni 2004
# Gunakan statement Langkah A&B sebagai subquery dengan alias tabel_b
# Dari tabel orders_1 dan orders_2, pilihlah kolom customerID, gunakan DISTINCT untuk menghilangkan duplikasi, kemudian gabungkan dengan kedua tabel tersebut dengan UNION.
# Filter tabel_b dengan operator IN() menggunakan 'Select statement langkah 4' , sehingga hanya customerID yang pernah bertransaksi (customerID tercatat di tabel orders) yang diperhitungkan.
# Hitunglah jumlah unik customers (tidak ada duplikasi customers) di statement SELECT dan beri nama “total_customers”
# Kelompokkan total_customer berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.

SELECT quarter(createdate) AS quarter, COUNT(DISTINCT customerid) AS total_customers FROM 
      (SELECT customerid,createdate,quarter(createdate) AS quarter FROM customer
       WHERE createdate BETWEEN '2004-01-01' AND '2004-06-30' AND customerid IN 
       (SELECT DISTINCT customerid FROM orders_1 UNION SELECT DISTINCT customerid FROM orders_2)) AS tabel_b
GROUP BY quarter(createdate);

# Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2?
# Untuk mengetahui kategori produk yang paling banyak dibeli, maka dapat dilakukan dengan menghitung total order dan jumlah penjualan dari setiap kategori produk.

# Dari kolom orders_2, pilih productCode, orderNumber, quantity, status
# Tambahkan kolom baru dengan mengekstrak 3 karakter awal dari productCode yang merupakan ID untuk kategori produk; dan beri nama categoryID
# Filter kolom “status” sehingga hanya produk dengan status “Shipped” yang diperhitungkan
# Gunakan statement Langkah 1, 2, dan 3 sebagai subquery dengan alias tabel_c
# Hitunglah total order dari kolom “orderNumber” dan beri nama “total_order”, dan jumlah penjualan dari kolom “quantity” dan beri nama “total_penjualan”
# Kelompokkan berdasarkan categoryID, dan jangan lupa menambahkan kolom ini pada bagian select.
# Urutkan berdasarkan “total_order” dari terbesar ke terkecil

SELECT * FROM 
      (SELECT categoryID, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan FROM 
       ( 
       SELECT 
       productCode, 
       orderNumber, 
       quantity,
       status, 
       LEFT(productCode,3) AS categoryID
FROM orders_2
WHERE status = "Shipped") tabel_c
GROUP BY categoryID ) a 
ORDER BY total_order DESC

# Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya?
# Mengetahui seberapa banyak customers yang tetap aktif menunjukkan apakah xyz.com tetap digemari oleh customers untuk memesan kebutuhan bisnis mereka. Hal ini juga dapat menjadi dasar bagi tim product dan business untuk pengembangan product dan business kedepannya. Adapun metrik yang digunakan disebut retention cohort. Untuk project ini, kita akan menghitung retention dengan query SQL sederhana, sedangkan cara lain yaitu JOIN dan SELF JOIN akan dibahas dimateri selanjutnya :

# Oleh karena baru terdapat 2 periode yang Quarter 1 dan Quarter 2, maka retention yang dapat dihitung adalah retention dari customers yang berbelanja di Quarter 1 dan kembali berbelanja di Quarter 2, sedangkan untuk customers yang berbelanja di Quarter 2 baru bisa dihitung retentionnya di Quarter 3.

# Dari tabel orders_1, tambahkan kolom baru dengan value “1” dan beri nama “quarter”
# Dari tabel orders_2, pilihlah kolom customerID, gunakan distinct untuk menghilangkan duplikasi
# Filter tabel orders_1 dengan operator IN() menggunakan 'Select statement langkah 2', sehingga hanya customerID yang pernah bertransaksi di quarter 2 (customerID tercatat di tabel orders_2) yang diperhitungkan.
# Hitunglah jumlah unik customers (tidak ada duplikasi customers) dibagi dengan total_ customers dalam percentage, pada Select statement dan beri nama “Q2”
# Hasilnya sebagai berikut :

#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;
#output = 25
SELECT "1" as quarter, (COUNT(DISTINCT customerID)*100)/25 as q2 FROM orders_1 where customerid in (SELECT DISTINCT customerID FROM orders_2);
