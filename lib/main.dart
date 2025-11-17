import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Forzar modo horizontal
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Para animar los botones cuando se presionan
  String pressed = "";

  void goTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Widget productButton({
    required BuildContext context,
    required IconData icono,
    required String label,
    required Widget screen,
  }) {
    bool isPressed = pressed == label;

    return GestureDetector(
      onTapDown: (_) {
        setState(() => pressed = label);
      },
      onTapCancel: () {
        setState(() => pressed = "");
      },
      onTapUp: (_) {
        setState(() => pressed = "");
        goTo(context, screen);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? Colors.blue.shade300 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isPressed ? 0.05 : 0.15),
              blurRadius: isPressed ? 4 : 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icono,
              size: 50,
              color: isPressed ? Colors.white : Colors.blue.shade700,
            ),
            const SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isPressed ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "17 NOV, 2025",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "10:30 AM",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- BOTONES ----------------
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  productButton(
                    context: context,
                    icono: Icons.water_drop,
                    label: "Agua",
                    screen: const AguaScreen(),
                  ),
                  productButton(
                    context: context,
                    icono: Icons.local_laundry_service, // Botella detergente
                    label: "Detergente",
                    screen: const DetergenteScreen(),
                  ),
                  productButton(
                    context: context,
                    icono: Icons.ac_unit, // Copo de nieve
                    label: "Hielo",
                    screen: const HieloScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////
//        PANTALLAS DE PRODUCTOS (VACÍAS POR AHORA)
//////////////////////////////////////////////////////////

class AguaScreen extends StatelessWidget {
  const AguaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agua")),
      body: const Center(
        child: Text("Pantalla de Agua", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class DetergenteScreen extends StatelessWidget {
  const DetergenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detergente")),
      body: const Center(
        child: Text("Pantalla de Detergente", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class HieloScreen extends StatelessWidget {
  const HieloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hielo")),
      body: const Center(
        child: Text("Pantalla de Hielo", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
