import 'package:flutter/material.dart';
import 'halaman_utama.dart';
import 'novel/tester.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Movie',
      home: const MainPage(), //mainpage untuk bisa menampilkan tombol
      routes: {
        //  '/novel': (context) =>  Tester(), // Contoh halaman berita
        //'/tentangsaya': (context) => const aboutme(), // Contoh halaman aboutme
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HalamanVideo(),
    Tester(),
    //ProfilPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        fixedColor: const Color.fromARGB(255, 0, 0, 0),
        backgroundColor: const Color.fromARGB(139, 53, 53, 53),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Novel'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
