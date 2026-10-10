import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_peralatan_komputer/providers/cart_provider.dart';
import 'package:toko_peralatan_komputer/homePage.dart';
import 'package:toko_peralatan_komputer/cartPage.dart';
import 'package:toko_peralatan_komputer/totalPage.dart';
import 'package:toko_peralatan_komputer/profilePage.dart';

void main() {
  runApp(
    // MultiProvider untuk tempat mendaftarkan provider yang dibutuhkan
    MultiProvider(
      providers: [
        // ChangeNotifierProvider membuat dan menyediakan CartProvider ke semua widget di bawahnya
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// MyApp tetap Stateful hanya menyimpan state lokal (tab aktif & total hasil checkout)
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentTab = 0; // tab aktif (0 Beranda, 1 Keranjang, 2 Profil)
  int? lastTotal; // total checkout; null = TotalPage tidak ditampilkan

  // Checkout untuk context.read mengambil provider satu kali tanpa mendengarkan perubahan
  void checkout() {
    final total = context.read<CartProvider>().grandTotal;
    context.read<CartProvider>().checkout();
    setState(() => lastTotal = total);
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan halaman yang tampil berdasarkan state lokal
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
      page = const MyHomePage();
    } else if (currentTab == 1) {
      page = CartPage(onCheckout: checkout);
    } else {
      page = const ProfilePage();
    }

    // MaterialApp widget wrapper utama aplikasi
    return MaterialApp(
      title: 'Toko Peralatan Komputer',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      // Scaffold struktur dasar halaman, dipakai bersama semua tab
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