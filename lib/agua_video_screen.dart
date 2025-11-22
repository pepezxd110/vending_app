import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class AguaVideoScreen extends StatefulWidget {
  const AguaVideoScreen({super.key});

  @override
  State<AguaVideoScreen> createState() => _AguaVideoScreenState();
}

class _AguaVideoScreenState extends State<AguaVideoScreen> {
  late final Player player;
  late final VideoController controller;
  bool ready = false;

  @override
  void initState() {
    super.initState();

    player = Player();
    controller = VideoController(
      player,
      // Para Linux/Raspberry podemos desactivar HW-decoding:
      // configuration: const VideoControllerConfiguration(hwdec: 'no'),
    );

    _start();
  }

  Future<void> _start() async {
    await player.open(
      Media(
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
      ),
    );
    setState(() {
      ready = true;
    });
  }

  @override
  void dispose() {
    player.dispose(); // controller ya no se disposea aparte
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ready
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Video(controller: controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
