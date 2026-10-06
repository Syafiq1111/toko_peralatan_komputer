import 'package:flutter/material.dart';
import 'package:toko_peralatan_komputer/product.dart';

// TotalPage menampilkan hasil berhasil setelah tombol di keranjang ditekan
class TotalPage extends StatelessWidget {
  final int total; // total belanja yang dikirim dari MyApp
  final VoidCallback onBack; // callback tombol Kembali

  const TotalPage({super.key, required this.total, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        // Column menyusun ikon, teks, dan tombol secara vertikal
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container lingkaran biru sebagai latar ikon centang
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 56, color: Colors.white), // Icon centang berhasil
            ),
            const SizedBox(height: 16),
            const Text('Total', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(
              formatRupiah(total),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            // SizedBox agar tombol selebar layar
            SizedBox(
              width: double.infinity,
              height: 48,
              // ElevatedButton Kembali memanggil onBack (setState di MyApp)
              child: ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}