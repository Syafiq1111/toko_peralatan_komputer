import 'package:flutter/material.dart';
import 'package:toko_peralatan_komputer/widgets/cartProdukCard.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold struktur dasar halaman
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea( // SafeAre untuk konten tidak tertutup notch/status bar
        child: Column( // Column menyusun header dan daftar produk secara vertikal
          children: [
            // Container header biru berisi judul, ikon keranjang, dan search bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration( // BoxDecoration warna biru dan sudut bawah melengkung
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column( // Column untuk judul, subjudul, dan search bar secara vertikal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row( // Row judul halaman dan ikon keranjang sejajar horizontal
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text judul halaman
                      const Text(
                        'Keranjang Saya',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Container lingkaran pembungkus ikon keranjang
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  const Text(
                    '4 produk siap dibeli',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // Container pembungkus TextField menjadi kotak putih
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField( // TextField input pencarian
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cari di keranjang',
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

            // Expanded area produk + total mengisi sisa layar
            Expanded(
              child: Stack( // Stack menumpuk daftar produk dan box Total
                children: [
                  // SingleChildScrollView daftar produk bisa di-scroll
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: 130,
                      ),
                      child: Column( // Column untuk menyusun kartu produk vertikal
                        children: const [
                          CartProductCard(
                            nama: 'Keyboard Mechanical RGB',
                            deskripsi: 'Switch Blue, Anti Ghosting',
                            harga: 'Rp450.000',
                            gambar: 'assets/keyboard.png',
                          ),
                          SizedBox(height: 16),
                          CartProductCard(
                            nama: 'Mouse Gaming Wireless',
                            deskripsi: 'DPI 12000, Baterai Tahan Lama',
                            harga: 'Rp275.000',
                            gambar: 'assets/mouse.png',
                          ),
                          SizedBox(height: 16),
                          CartProductCard(
                            nama: 'SSD NVMe 1TB',
                            deskripsi: 'Kecepatan Baca 3500MB/s',
                            harga: 'Rp1.200.000',
                            gambar: 'assets/ssd.jpg',
                          ),
                          SizedBox(height: 16),
                          CartProductCard(
                            nama: 'Monitor LED 24 inch',
                            deskripsi: 'Full HD, Refresh Rate 75Hz',
                            harga: 'Rp1.850.000',
                            gambar: 'assets/monitor.jpg',
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned( // Positioned untuk mengunci box Total di bagian bawah Stack
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container( // Container untuk box Total dengan bayangan dan sudut atas melengkung
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [ // BoxShadow bayangan ke atas agar box terlihat melayang
                          BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 12,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Row( // Row: total harga dan tombol berdampingan
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Belanja',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Rp3.775.000',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart, size: 20),
                                    SizedBox(width: 10),
                                    Text(
                                      'Masukkan Keranjang',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar( // NavigationBar tab Keranjang aktif
        backgroundColor: Colors.white,
        selectedIndex: 1,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pop(context); // Navigator.pop kembali ke Beranda (hapus halaman ini dari stack)
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}