import 'package:flutter/material.dart';
import 'dart:math' as math; // For transform rotation
import 'package:qr_codee_scannerr/screens/scanner_screen.dart';
import 'package:qr_codee_scannerr/screens/history_screen.dart';
import 'package:qr_codee_scannerr/screens/generate_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // Continuous rotation
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend gradient behind app bar
      appBar: AppBar(
        title: const Text(
          'QR Scanner & Generator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black45, blurRadius: 2, offset: Offset(1, 1))],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A1B9A), // Deep purple
              Color(0xFF1976D2), // Blue
              Color(0xFF42A5F5), // Light blue
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated rotating QR icon
                AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.qr_code,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                // Title with gradient text effect
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Colors.yellowAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: const Text(
                    'Welcome to QR Magic',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Base color for ShaderMask
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Fancy buttons with transform and shadow
                _buildFancyButton(
                  context: context,
                  icon: Icons.camera_alt,
                  label: 'Scan QR Code',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScannerScreen()),
                  ),
                  rotation: -0.05, // Slight tilt left
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.cyan],
                  ),
                ),
                const SizedBox(height: 20),
                _buildFancyButton(
                  context: context,
                  icon: Icons.qr_code_2,
                  label: 'Generate QR Code',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GenerateScreen()),
                  ),
                  rotation: 0.05, // Slight tilt right
                  gradient: const LinearGradient(
                    colors: [Colors.purpleAccent, Colors.deepPurple],
                  ),
                ),
                const SizedBox(height: 20),
                _buildFancyButton(
                  context: context,
                  icon: Icons.history,
                  label: 'View History',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  ),
                  rotation: 0, // No tilt
                  gradient: const LinearGradient(
                    colors: [Colors.greenAccent, Colors.teal],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFancyButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required double rotation,
    required LinearGradient gradient,
  }) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white, size: 28),
          label: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            backgroundColor: Colors.transparent, // Transparent to show gradient
            shadowColor: Colors.transparent, // Avoid double shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}