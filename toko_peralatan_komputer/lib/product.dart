import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final int price;
  final String image;
  final Color color;
  final Color softColor;
  int stock; // jumlah stok tersedia
  int cartQty; // jumlah produk ini di keranjang (0 = belum masuk keranjang)

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.color,
    required this.softColor,
    required this.stock,
    this.cartQty = 0,
  });
}

// ubah angka contoh 1200000 menjadi 'Rp1.200.000'
String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return 'Rp$buffer';
}