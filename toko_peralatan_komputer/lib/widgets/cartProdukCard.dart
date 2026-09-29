import 'package:flutter/material.dart';

class CartProductCard extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String harga;
  final String gambar;

  const CartProductCard({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    // Container sebagai pembungkus kartu, sekarang tanpa border tapi dengan bayangan
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow( // BoxShadow bayangan agar kartu terlihat bagus
            color: Colors.blue.shade100,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row( // Row menyusun gambar, info produk, dan kuantitas secara horizontal
        children: [
          Image.asset( // Image.asset menampilkan gambar produk dari folder assets
            gambar,
            width: 90,
            height: 90,
            fit: BoxFit.cover, // gambar memenuhi area 90x90
          ),

          const SizedBox(width: 14),

          // Expanded info produk mengisi sisa ruang pada Row
          Expanded(
            child: Column( // Column untuk menyusun nama, deskripsi, harga secara vertikal
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),

                // Container badge harga
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  // Text harga produk
                  child: Text(
                    harga,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Column label "Jumlah" di atas kotak input
          Column(
            children: [
              // Text label jumlah
              Text(
                'Jumlah',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 4),
              SizedBox( // SizedBox: mengatur ukuran kotak input jumlah
                width: 48,
                height: 48,
                child: TextField(
                  keyboardType: TextInputType.number, // keyboard hanya angka
                  textAlign: TextAlign.center, // angka di tengah kotak
                  decoration: InputDecoration(
                    hintText: '1',
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue.shade200),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}