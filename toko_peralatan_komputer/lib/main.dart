import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp widget wrapper utama aplikasi
    return MaterialApp(
      title: 'Toko Peralatan Komputer',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar halaman aplikasi
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea( // SafeArea memastikan konten tidak tertutup notch status bar
        child: Column( // Column menyusun header, kategori, dan daftar produk secara vertikal
          children: [
            Container( // Container header biru berisi judul toko dan search bar
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column( // Column untuk menyusun judul, subjudul, dan search bar secara vertikal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row( // Row  untuk judul toko dan icon notifikasi sejajar horizontal
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'FiqSTORE',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Container bungkus icon notifikasi
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4), // jarak antara judul dan subjudul

                  const Text(
                    'Peralatan Komputer Terlengkap',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  const SizedBox(height: 16), // jarak sebelum search bar

                  Container( // Container untuk bungkus TextField menjadi kotak putih
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cari',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.search,
                            size: 24,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // Row untuk menyusun 4 item kategori secara horizontal
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(Icons.keyboard, 'Keyboard', Colors.orange, Colors.orange.shade100),
                  _buildCategoryItem(Icons.mouse, 'Mouse', Colors.purple, Colors.purple.shade100),
                  _buildCategoryItem(Icons.sd_storage, 'Storage', Colors.green, Colors.green.shade100),
                  _buildCategoryItem(Icons.monitor, 'Monitor', Colors.pink, Colors.pink.shade100),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded( // Expanded agar daftar produk mengisi sisa ruang yang tersedia
              child: SingleChildScrollView( // SingleChildScrollView agar daftar produk bisa discroll
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column( // Column untuk menyusun seluruh card produk secara vertikal
                    children: [
                      buildProductCard(
                        'Keyboard Mechanical RGB',
                        'Switch Blue, Anti Ghosting',
                        'Rp450.000',
                        Icons.keyboard,
                        Colors.orange,
                        Colors.orange.shade100,
                      ),
                      const SizedBox(height: 14),
                      buildProductCard(
                        'Mouse Gaming Wireless',
                        'DPI 12000, Baterai Tahan Lama',
                        'Rp275.000',
                        Icons.mouse,
                        Colors.purple,
                        Colors.purple.shade100,
                      ),
                      const SizedBox(height: 14),
                      buildProductCard(
                        'SSD NVMe 1TB',
                        'Kecepatan Baca 3500MB/s',
                        'Rp1.200.000',
                        Icons.sd_storage,
                        Colors.green,
                        Colors.green.shade100,
                      ),
                      const SizedBox(height: 14),
                      buildProductCard(
                        'Monitor LED 24 inch',
                        'Full HD, Refresh Rate 75Hz',
                        'Rp1.850.000',
                        Icons.monitor,
                        Colors.pink,
                        Colors.pink.shade100,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar Container sebagai navigasi bawah aplikasi kaya beranda keranjang profil
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          // Row untuk menyusun 3 menu navigasi secara horizontal
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded untuk menu Beranda
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home, size: 24, color: Colors.blue),
                  SizedBox(height: 4),
                  Text('Beranda',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // Expanded menu Keranjang
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 24, color: Colors.grey.shade400),
                  const SizedBox(height: 4),
                  Text('Keranjang',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
                ],
              ),
            ),
            // Expanded untuk menu Profil
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 24, color: Colors.grey.shade400),
                  const SizedBox(height: 4),
                  Text('Profil',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi widget kategori untuk menampilkan  icon bulat berwarna dan label kategori dibawah pencarian
  Widget _buildCategoryItem(IconData icon, String label, Color warnaIkon, Color warnaLatar) {
    return Column( // Column untuk susun icon kategori dan label secara vertikal
      children: [
        Container( // Container kotak bulat berwarna sebagai latar icon kategori
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: warnaLatar,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, size: 24, color: warnaIkon),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Fungsi widget produk menampilkan 1 card produk lengkap gambar, nama, harga, tombol
  Widget buildProductCard(String nama, String deskripsi, String harga, IconData icon, Color warnaUtama, Color warnaLembut) {
    return Container( // Container ini untuk card pembungkus utama setiap produk
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row( // Row untuk menyusun gambar produk dan info produk secara horizontal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( // Container: kotak berwarna sebagai placeholder gambar/icon produk
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: warnaLembut,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 32, color: warnaUtama),
          ),
          const SizedBox(width: 12),

          // Expanded agar info produk mengisi sisa ruang pada Row
          Expanded(
            child: Column(
              // Column untuk menyusun nama, deskripsi, harga, dan tombol secara vertikal
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),

                // Text deskripsi singkat produk
                Text(
                  deskripsi,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 6),

                Container( // Container utnnuk badge harga berwarna lembut sesuai kategori
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: warnaLembut,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    harga,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: warnaUtama,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Container( // Container untuk tombol Masukkan Keranjang berwarna sesuai kategori
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: warnaUtama,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row( // Row untuk menyusun icon keranjang dan teks tombol sejajar tengah
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_cart, size: 16, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Masukkan Keranjang',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}