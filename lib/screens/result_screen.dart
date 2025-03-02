import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatelessWidget {
  final String result;

  const ResultScreen({super.key, required this.result});

  void _launchURL() async {
    final Uri url = Uri.parse(result);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Scan Result',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black45, blurRadius: 2, offset: Offset(1, 1))],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6A1B9A), Color(0xFF1976D2), Color(0xFF42A5F5)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scanned Result:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGradientButton(
                      icon: Icons.copy,
                      label: 'Copy',
                      gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: result));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Copied to clipboard'),
                            backgroundColor: Colors.blueAccent.withOpacity(0.9),
                          ),
                        );
                      },
                    ),
                    if (result.startsWith('http'))
                      _buildGradientButton(
                        icon: Icons.open_in_browser,
                        label: 'Open',
                        gradient: const LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
                        onPressed: _launchURL,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required IconData icon,
    required String label,
    required LinearGradient gradient,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}