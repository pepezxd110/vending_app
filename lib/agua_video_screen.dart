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
      body: Row(
        children: [
          // -----------------------------------
          // IZQUIERDA — VIDEO con fondo blanco
          // -----------------------------------
          Expanded(
  flex: 1,
  child: ClipRect(
    child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FittedBox(
        fit: BoxFit.fill,   // <-- llena TODO el espacio disponible
        child: SizedBox(
          width: 1280,      // <-- ancho real del video
          height: 720,      // <-- alto real del video
          child: Video(
            controller: controller,
            controls: null,
          ),
        ),
      ),
    ),
  ),
),



          // -----------------------------------
          // DERECHA — TEXTO
          // -----------------------------------
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  "LLENANDO GARRAFÓN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
