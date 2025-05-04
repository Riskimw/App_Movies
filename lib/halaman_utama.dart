import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
import 'video_detail.dart'; // Halaman detail

class HalamanVideo extends StatefulWidget {
  const HalamanVideo({super.key});

  @override
  State<HalamanVideo> createState() => _HalamanVideoState();
}

class _HalamanVideoState extends State<HalamanVideo> {
  late Future<List<Film>> _filmList;

  Future<List<Film>> fetchFilm() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.3:8000/api/index'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((json) => Film.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data film');
    }
  }

  @override
  void initState() {
    super.initState();
    _filmList = fetchFilm();
  }

  @override
  Widget build(BuildContext context) {
    final String baseUrl = 'http://192.168.1.3:8000/storage/';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 165, 165, 165),
        title: const Text(
          'Filmku',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 0, 149),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Film>>(
        future: _filmList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final films = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: films.length,
              itemBuilder: (context, index) {
                final film = films[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoDetailPage(film: film),
                      ),
                    );
                    //  print(film.foto);
                  },
                  child: GridTile(
                    child: Container(
                      color: Colors.black12,
                      child: Image.network('$baseUrl${film.foto}'),
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(film.namaFilm),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Gagal memuat video"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
