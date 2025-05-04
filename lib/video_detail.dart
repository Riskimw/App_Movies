import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'movie.dart';

class VideoDetailPage extends StatefulWidget {
  final Film film;
  const VideoDetailPage({super.key, required this.film});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  final String baseUrl = 'http://192.168.1.3:8000/storage/';
  @override
  void initState() {
    super.initState();
    // Video URL diambil dari API
    _videoController = VideoPlayerController.network(
      '$baseUrl${widget.film.fileFilm}',
    );
    // Inisialisasi video
    _videoController
        .initialize()
        .then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoController,
              autoPlay: true,
              looping: false,
            );
          });
        })
        .catchError((error) {
          // Tangani error jika ada masalah pada inisialisasi video
          print("Error loading video: $error");
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Error'),
                  content: Text(
                    'Gagal memuat video. Pastikan URL benar dan file tersedia.',
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
          );
        });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.film.namaFilm)),
      body:
          _chewieController != null && _videoController.value.isInitialized
              ? Center(child: Chewie(controller: _chewieController!))
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
