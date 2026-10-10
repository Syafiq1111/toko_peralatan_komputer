import 'package:flutter/material.dart';
import 'package:toko_peralatan_komputer/product.dart';

// CartProvider extends ChangeNotifier untuk menyimpan state bersama (produk dan keranjang)
class CartProvider extends ChangeNotifier {
  // Daftar produk beserta stok
  final List<Product> products = [
    Product(
      id: 'produk-1',
      name: 'Keyboard Mechanical RGB',
      description: 'Switch Blue, Anti Ghosting',
      price: 450000,
      image: 'assets/keyboard.png',
      color: Colors.orange,
      softColor: Colors.orange.shade100,
      stock: 5,
    ),
    Product(
      id: 'produk-2',
      name: 'Mouse Gaming Wireless',
      description: 'DPI 12000, Baterai Tahan Lama',
      price: 275000,
      image: 'assets/mouse.png',
      color: Colors.purple,
      softColor: Colors.purple.shade100,
      stock: 5,
    ),
    Product(
      id: 'produk-3',
      name: 'SSD NVMe 1TB',
      description: 'Kecepatan Baca 3500MB/s',
      price: 1200000,
      image: 'assets/ssd.jpg',
      color: Colors.green,
      softColor: Colors.green.shade100,
      stock: 3,
    ),
    Product(
      id: 'produk-4',
      name: 'Monitor LED 24 inch',
      description: 'Full HD, Refresh Rate 75Hz',
      price: 1850000,
      image: 'assets/monitor.jpg',
      color: Colors.pink,
      softColor: Colors.pink.shade100,
      stock: 2,
    ),
  ];

  // Jumlah tiap produk di keranjang key: id produk, value: jumlah
  final Map<String, int> cartQuantities = {};

  // State turunan Grand Total dihitung dari harga x jumlah di keranjang
  int get grandTotal => products.fold(0, (total, product) {
    return total + product.price * (cartQuantities[product.id] ?? 0);
  });

  // Menambah produk ke keranjang, kurangi stok, lalu beri tahu widget yang mendengarkan
  void addToCart(Product product) {
    if (product.stock == 0) return;
    product.stock--;
    cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + 1;
    notifyListeners();
  }

  // Mengubah jumlah produk di keranjang (dibatasi 1 sampai stok maksimal), sesuaikan stok
  void changeQuantity(Product product, int quantity) {
    final currentQuantity = cartQuantities[product.id] ?? 0;
    final maxQuantity = currentQuantity + product.stock;
    final nextQuantity = quantity.clamp(1, maxQuantity).toInt();
    product.stock += currentQuantity - nextQuantity;
    cartQuantities[product.id] = nextQuantity;
    notifyListeners();
  }

  // Checkout kosongkan keranjang (stok tetap berkurang)
  void checkout() {
    cartQuantities.clear();
    notifyListeners();
  }
}