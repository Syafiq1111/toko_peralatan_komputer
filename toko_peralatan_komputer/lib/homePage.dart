import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_peralatan_komputer/product.dart';
import 'package:toko_peralatan_komputer/providers/cart_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Consumer mendengarkan perubahan CartProvider builder dijalankan ulang saat notifyListeners()
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // Produk tampil stok > 0 DAN nama mengandung searchQuery
        final visibleProducts = cart.products.where((product) {
          return product.stock > 0 &&
              product.name.toLowerCase().contains(searchQuery);
        }).toList();

        // Column menyusun header, kategori, dan daftar produk secara vertikal
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row judul toko dan icon notifikasi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'FiqSTORE',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      // Container bungkus icon notifikasi
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.notifications, size: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Peralatan Komputer Terlengkap',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // TextField pencarian setState mengubah searchQuery
                    child: TextField(
                      onChanged: (value) =>
                          setState(() => searchQuery = value.toLowerCase()),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cari',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.search, size: 24, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Padding dan Row untuk 4 item kategori secara horizontal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
            // Expanded agar daftar produk mengisi sisa ruang
            Expanded(
              // SingleChildScrollView agar daftar bisa discroll
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Pesan jika hasil pencarian kosong
                      if (visibleProducts.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text('Produk tidak ditemukan'),
                        ),
                      for (final product in visibleProducts) ...[
                        buildProductCard(product),
                        const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget kategori icon kotak berwarna dan label
  Widget _buildCategoryItem(IconData icon, String label, Color warnaIkon, Color warnaLatar) {
    // Column menyusun icon dan label secara vertikal
    return Column(
      children: [
        // Container kotak berwarna sebagai latar icon
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: warnaLatar,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, size: 24, color: warnaIkon),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Widget card produk gambar, nama, stok, harga, tombol
  Widget buildProductCard(Product product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      // Row gambar dan info produk secara horizontal
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset menampilkan gambar dari folder assets
          Image.asset(product.image, width: 72, height: 72, fit: BoxFit.cover),
          const SizedBox(width: 12),

          // Expanded agar info mengisi sisa ruang Row
          Expanded(
            // Column nama, deskripsi, harga, tombol secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(
                  '${product.description} • Stok: ${product.stock}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 6),

                // Container badge harga
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: product.softColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    formatRupiah(product.price),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: product.color),
                  ),
                ),
                const SizedBox(height: 8),

                // SizedBox mengatur lebar tombol agar memenuhi card
                SizedBox(
                  width: double.infinity,
                  // ElevatedButton context.read memanggil addToCart tanpa mendengarkan perubahan
                  child: ElevatedButton(
                    onPressed: product.stock > 0
                        ? () => context.read<CartProvider>().addToCart(product)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    // Row icon keranjang dan teks tombol
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, size: 16),
                        SizedBox(width: 6),
                        Text('Masukkan Keranjang', style: TextStyle(fontSize: 12)),
                      ],
                    ),
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