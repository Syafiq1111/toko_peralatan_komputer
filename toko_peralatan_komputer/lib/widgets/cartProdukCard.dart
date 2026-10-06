import 'package:flutter/material.dart';

// CartProductCard jadi StatefulWidget karena input jumlah punya state
class CartProductCard extends StatefulWidget {
  final String nama;
  final String deskripsi;
  final String harga;
  final String gambar;
  final int quantity; // jumlah saat ini dari state MyApp
  final int maxQuantity; // batas maksimal (stok + yang sudah di keranjang)
  final void Function(int) onQuantityChanged; // callback ke CartPage

  const CartProductCard({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.quantity,
    required this.maxQuantity,
    required this.onQuantityChanged,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late TextEditingController quantityController;

  // initState dijalankan sekali, mengisi controller dengan jumlah awal
  @override
  void initState() {
    super.initState();
    quantityController =
        TextEditingController(text: '${widget.quantity}');
  }

  // didUpdateWidget menyamakan teks dengan quantity bila ada perubahan dari luar kartu
  @override
  void didUpdateWidget(covariant CartProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity &&
        quantityController.text != '${widget.quantity}') {
      quantityController.text = '${widget.quantity}';
    }
  }

  // dispose membuang controller saat kartu dihapus agar tidak bocor memori
  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  // Validasi input ubah teks ke angka, batasi 1 sampai maxQuantity, kirim lewat callback
  void updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;
    final clamped = parsed.clamp(1, widget.maxQuantity).toInt();
    if (clamped != parsed) {
      quantityController.text = '$clamped'; // koreksi teks bila melebihi batas
    }
    widget.onQuantityChanged(clamped);
  }

  @override
  Widget build(BuildContext context) {
    // Container pembungkus kartu dengan bayangan
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      // Row gambar, info produk, dan kuantitas secara horizontal
      child: Row(
        children: [
          // Image.asset menampilkan gambar produk
          Image.asset(widget.gambar, width: 90, height: 90, fit: BoxFit.cover),
          const SizedBox(width: 14),

          // Expanded info produk mengisi sisa ruang Row
          Expanded(
            // Column nama, deskripsi, harga secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.nama, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.deskripsi, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                const SizedBox(height: 8),
                // Container badge harga
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.harga,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Column label "Jumlah" di atas kotak input
          Column(
            children: [
              Text('Jumlah', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
              const SizedBox(height: 4),
              // SizedBox mengatur ukuran kotak input
              SizedBox(
                width: 48,
                height: 48,
                // TextField jumlah controller dan onChanged memanggil updateQuantity
                child: TextField(
                  controller: quantityController,
                  onChanged: updateQuantity,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
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