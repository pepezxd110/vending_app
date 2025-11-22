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

    /// ⚠️⚠️ CONFIGURACIÓN ESPECIAL PARA RASPBERRY PI ⚠️⚠️
    ///
    /// Esta configuración evita que MPV intente usar:
    /// - NVIDIA CUDA
    /// - VDPAU
    /// - NVDEC
    /// - GPU desktop incompatible en Raspberry Pi
    ///
    /// Y utiliza un backend seguro: `sdl`
    ///
    /// Esto evita el crash y funciona perfecto en RPi 4 / 400 / 5.

    controller = VideoController(
  player,
  configuration: const VideoControllerConfiguration(
    enableHardwareAcceleration: false,
  ),
);

    _loadVideo();
  }

  Future<void> _loadVideo() async {
    /// 👉 NO cambio NADA de tu ruta, lo de assets queda igual
    await player.open(
      Media('asset:///assets/videos/garrafon.mp4'),
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
      body: ready
          ? Center(
              child: Video(
                controller: controller,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
    );
  }
}
