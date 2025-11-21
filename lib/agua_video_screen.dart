import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter/material.dart';

class AguaVideoScreen extends StatefulWidget {
  const AguaVideoScreen({super.key});

  @override
  State<AguaVideoScreen> createState() => _AguaVideoScreenState();
}

class _AguaVideoScreenState extends State<AguaVideoScreen> {
  late final Player player = Player();
  late final VideoController controller = VideoController(player);
  bool ready = false;
  String? videoPath;

  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  Future<void> loadVideo() async {
    // 1. Cargar el asset como bytes
    final bytes = await rootBundle.load('assets/videos/garrafon.mp4');

    // 2. Obtener carpeta temporal
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/garrafon.mp4');

    // 3. Guardar bytes en archivo físico
    await file.writeAsBytes(bytes.buffer.asUint8List());

    videoPath = file.path;

    // 4. Reproducir
    await player.open(
      Media(videoPath!),
      play: true,
    );

    setState(() => ready = true);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ready
            ? Video(controller: controller)
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
