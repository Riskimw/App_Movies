import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
import 'video_detail.dart';

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
    const String baseUrl = 'http://192.168.1.3:8000/storage/';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          Icon(Icons.search, color: Color.fromARGB(255, 255, 255, 255)),
        ],
        title: const Text(
          'MovieVel',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            // Banner di atas
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Grid
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Film>>(
                future: _filmList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final films = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: films.length,
                        //settingan posisi gambar film
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 3 / 4.2,
                            ),
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
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gambar film
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    '$baseUrl${film.foto}',
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // Judul film
                                Text(
                                  film.namaFilm,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Gagal memuat video"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
