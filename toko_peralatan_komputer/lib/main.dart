import 'package:flutter/material.dart';
import 'package:toko_peralatan_komputer/product.dart';
import 'package:toko_peralatan_komputer/cartPage.dart';
import 'package:toko_peralatan_komputer/totalPage.dart';

void main() {
  runApp(const MyApp());
}

// MyApp menggunakan statefull widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State Daftar produknya
  final List<Product> products = [
    Product(
      name: 'Keyboard Mechanical RGB',
      description: 'Switch Blue, Anti Ghosting',
      price: 450000,
      image: 'assets/keyboard.png',
      color: Colors.orange,
      softColor: Colors.orange.shade100,
      stock: 5,
    ),
    Product(
      name: 'Mouse Gaming Wireless',
      description: 'DPI 12000, Baterai Tahan Lama',
      price: 275000,
      image: 'assets/mouse.png',
      color: Colors.purple,
      softColor: Colors.purple.shade100,
      stock: 5,
    ),
    Product(
      name: 'SSD NVMe 1TB',
      description: 'Kecepatan Baca 3500MB/s',
      price: 1200000,
      image: 'assets/ssd.jpg',
      color: Colors.green,
      softColor: Colors.green.shade100,
      stock: 3,
    ),
    Product(
      name: 'Monitor LED 24 inch',
      description: 'Full HD, Refresh Rate 75Hz',
      price: 1850000,
      image: 'assets/monitor.jpg',
      color: Colors.pink,
      softColor: Colors.pink.shade100,
      stock: 2,
    ),
  ];

  int currentTab = 0;
  int? lastTotal; // Total Harga

  // State turunan Total dihitung dari isi keranjang
  int get grandTotal {
    int total = 0;
    for (final p in products) {
      total += p.price * p.cartQty;
    }
    return total;
  }

  // Dipanggil dari tombol Masukkan Keranjang di Beranda setState memperbarui stok dan keranjang
  void addToCart(Product product) {
    if (product.stock <= 0) return;
    setState(() {
      product.stock -= 1;
      product.cartQty += 1;
    });
  }

  // Dipanggil dari input jumlah di CartProductCard lewat CartPage dan setState menyesuaikan stok
  void changeQuantity(Product product, int newQty) {
    setState(() {
      product.stock -= newQty - product.cartQty;
      product.cartQty = newQty;
    });
  }

  // Dipanggil dari tombol di halaman keranjang simpan total, kosongkan keranjang
  void checkout() {
    final total = grandTotal;
    setState(() {
      for (final p in products) {
        p.cartQty = 0;
      }
      lastTotal = total; // isi total body berganti menjadi TotalPage
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan halaman yang tampil berdasarkan state
    Widget page;
    if (lastTotal != null) {
      page = TotalPage(
        total: lastTotal!,
        onBack: () => setState(() {
          lastTotal = null;
          currentTab = 0;
        }),
      );
    } else if (currentTab == 0) {
      page = MyHomePage(products: products, onAddToCart: addToCart);
    } else if (currentTab == 1) {
      page = CartPage(
        items: products.where((p) => p.cartQty > 0).toList(),
        grandTotal: grandTotal,
        onQuantityChanged: changeQuantity,
        onCheckout: checkout,
      );
    } else {
      page = const Center(child: Text('Halaman Profil'));
    }

    // MaterialApp widget wrapper utama aplikasi
    return MaterialApp(
      title: 'Toko Peralatan Komputer',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      // Scaffold struktur dasar halaman, dipakai oleh semua tab
      home: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(child: page), // SafeArea agar tidak tertutup notch
        // NavigationBar navigasi bawah setState mengganti tab aktif
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: currentTab,
          onDestinationSelected: (index) {
            setState(() {
              currentTab = index;
              lastTotal = null;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

// Beranda jadi StatefulWidget karena punya state searchQuery
class MyHomePage extends StatefulWidget {
  final List<Product> products;
  final void Function(Product) onAddToCart; // callback ke MyApp.addToCart

  const MyHomePage({super.key, required this.products, required this.onAddToCart});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = ''; // Kata kunci ppencariann

  @override
  Widget build(BuildContext context) {
    // Produk tampil stok > 0 DAN nama mengandung searchQuery
    final visibleProducts = widget.products.where((product) {
      return product.stock > 0 &&
          product.name.toLowerCase().contains(searchQuery);
    }).toList();

    // Column menyusun header, kategori, dan daftar produk secara vertikal
    return Column(
      children: [
        // Container header biru berisi judul toko dan search bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.blue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row judul toko dan icon notifikasi sejajar horizontal
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
              const SizedBox(height: 4), // jarak judul dan subjudul
              const Text(
                'Peralatan Komputer Terlengkap',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
              const SizedBox(height: 16), // jarak sebelum search bar

              // Container pembungkus TextField menjadi kotak putih
              Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                // TextField pencarian onChanged dipanggil tiap pengguna mengetik
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
        // Padding dengan Row untuk 4 item kategori secara horizontal
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
                  // Jika hasil pencarian kosong tampilkan pesan, jika ada tampilkan card
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
    // Container pembungkus utama card
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
                // Text deskripsi + stok (stok ikut berubah saat state berubah)
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
                  // ElevatedButton aktif jika stok > 0, nonaktif (null) jika habis
                  child: ElevatedButton(
                    onPressed: product.stock > 0
                        ? () => widget.onAddToCart(product)
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