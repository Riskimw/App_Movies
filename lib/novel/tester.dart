import 'package:flutter/material.dart';

class Tester extends StatefulWidget {
  const Tester({super.key});

  @override
  State<Tester> createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [Text('Novel disini', style: TextStyle(fontSize: 50))],
      ),
    );
  }
}
