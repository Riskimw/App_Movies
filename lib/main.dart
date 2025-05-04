import 'package:flutter/material.dart';
import 'halaman_utama.dart';
import 'tester.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App film',
      home: const HalamanVideo(), //mainpage untuk bisa menampilkan tombol
      // routes: {
      //   '/Berita': (context) => const Berita(), // Contoh halaman berita
      //   '/tentangsaya': (context) => const aboutme(), // Contoh halaman aboutme
      // },
    );
  }
}
