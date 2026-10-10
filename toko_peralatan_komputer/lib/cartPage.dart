import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_peralatan_komputer/product.dart';
import 'package:toko_peralatan_komputer/providers/cart_provider.dart';
import 'package:toko_peralatan_komputer/widgets/cartProdukCard.dart';

class CartPage extends StatefulWidget {
  final VoidCallback onCheckout; // callback ke MyApp.checkout

  const CartPage({super.key, required this.onCheckout});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Consumer mendengarkan perubahan CartProvider (keranjang, stok, total)
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // Produk yang ada di keranjang (jumlah > 0)
        final cartItems = cart.products.where((product) {
          return (cart.cartQuantities[product.id] ?? 0) > 0;
        }).toList();

        // Hasil pencarian di dalam keranjang
        final visibleItems = cartItems.where((product) {
          return product.name.toLowerCase().contains(searchQuery);
        }).toList();

        // State turunan untuk tombol aktif hanya jika Grand Total > 0
        final currentGrandTotal = cart.grandTotal;

        // Column menyusun header dan daftar produk secara vertikal
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row judul halaman dan ikon keranjang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Keranjang Saya',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      // Container lingkaran pembungkus ikon keranjang
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.shopping_cart, size: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${cartItems.length} produk siap dibeli',
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // Container pembungkus TextField menjadi kotak putih
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
                        hintText: 'Cari di keranjang',
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

            // Expanded area produk dan total mengisi sisa layar
            Expanded(
              // Stack menumpuk daftar produk dan box Total
              child: Stack(
                children: [
                  // SingleChildScrollView agar daftar bisa discroll
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 130),
                      // Column kartu produk vertikal
                      child: Column(
                        children: [
                          if (visibleItems.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Text('Keranjang kosong'),
                            ),
                          for (final Product product in visibleItems) ...[
                            CartProductCard(
                              key: ValueKey(product.id), // key agar controller tiap kartu tidak tertukar
                              nama: product.name,
                              deskripsi: product.description,
                              harga: formatRupiah(product.price),
                              gambar: product.image,
                              quantity: cart.cartQuantities[product.id] ?? 0,
                              maxQuantity: product.stock + (cart.cartQuantities[product.id] ?? 0),
                              // Perubahan jumlah diteruskan ke CartProvider.changeQuantity
                              onQuantityChanged: (qty) => cart.changeQuantity(product, qty),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Positioned mengunci box Total di bagian bawah Stack
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 12,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      // Row total harga dan tombol
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Belanja',
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                                ),
                                const SizedBox(height: 4),
                                // Text total belanja dari CartProvider.grandTotal
                                Text(
                                  formatRupiah(currentGrandTotal),
                                  style: const TextStyle(
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
                            // SizedBox mengatur tinggi tombol
                            child: SizedBox(
                              height: 48,
                              // ElevatedButton aktif hanya jika Grand Total > 0
                              child: ElevatedButton(
                                onPressed: currentGrandTotal > 0 ? widget.onCheckout : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                // Row icon dan teks tombol
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart, size: 20),
                                    SizedBox(width: 10),
                                    Text('Masukkan Keranjang', style: TextStyle(fontSize: 14)),
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
        );
      },
    );
  }
}