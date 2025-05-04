class Film {
  final String namaFilm;
  final String foto;
  final String fileFilm;

  Film({required this.namaFilm, required this.fileFilm, required this.foto});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      namaFilm: json['nama_film'],
      fileFilm: json['file_film'],
      foto: json['foto'],
    );
  }
}
