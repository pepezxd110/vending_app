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

  @override
  void initState() {
    super.initState();

    player = Player();

    controller = VideoController(
      player,
      configuration: const VideoControllerConfiguration(
        vo: 'libmpv',
        hwdec: 'auto',
        enableHardwareAcceleration: false,
      ),
    );

    player.open(
      Media("asset:///assets/videos/garrafon.mp4"),
      play: true,
    );

    // 🔁 Repetir video infinitamente
    player.setPlaylistMode(PlaylistMode.loop);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Video(
          controller: controller,
          controls: null,   // ❌ Sin barra de controles
        ),
      ),
    );
  }
}
