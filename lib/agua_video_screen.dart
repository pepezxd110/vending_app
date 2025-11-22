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
      Media("asset:///assets/videos/llenado.mp4"),
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
  child: Container(
    color: Colors.white,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final double targetWidth = 512;   // mitad izquierda (≈512 px)
        final double targetHeight = 600; // toda la altura (600 px)

        final double videoWidth = 720;
        final double videoHeight = 1280;

        // Escala necesaria para que el video LLENE el alto sin dejar barras
        double scale = targetHeight / videoHeight;

        return Center(
          child: Transform.scale(
            scale: scale,                 // reduce altura y ensancha proporcionalmente
            child: SizedBox(
              width: videoWidth,
              height: videoHeight,
              child: ClipRect(
                child: OverflowBox(
                  maxWidth: targetWidth / scale,   // expande horizontalmente
                  maxHeight: targetHeight / scale,
                  child: Video(
                    controller: controller,
                    controls: null,
                    fit: BoxFit.cover,             // recorta donde sea necesario
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
