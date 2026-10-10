import 'package:flutter/material.dart';

// ProfilePage StatelessWidget karena hanya menampilkan data tetap
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Column menyusun header profil dan info secara vertikal
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          // Column foto profil, nama, dan email
          child: Column(
            children: [
              // Container lingkaran sebagai latar foto profil
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 56, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Pengguna FiqSTORE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              const Text(
                'syafiq@gmail.com',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ],
          ),
        ),

        // Padding memberi jarak untuk kartu info
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(16),
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
            // Column baris info
            child: Column(
              children: [
                _buildInfoRow(Icons.phone, 'No. Telepon', '0812-3456-7890'),
                const Divider(),
                _buildInfoRow(Icons.location_on, 'Alamat', 'Samarinda, Kalimantan Timur'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget satu baris info icon, label, dan isi
  Widget _buildInfoRow(IconData icon, String label, String value) {
    // Row icon dan teks sejajar horizontal
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        // Column label dan isi secara vertikal
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}