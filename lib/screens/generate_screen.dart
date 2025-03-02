import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final TextEditingController _textController = TextEditingController();
  String qrData = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Generate QR Code',
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter text to generate a QR code:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
                  ),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                      labelText: 'Text or URL',
                      hintText: 'e.g., https://example.com or Hello World',
                      labelStyle: TextStyle(color: Colors.black54),
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qrData = _textController.text.trim();
                      });
                    },
                    child: const Text(
                      'Generate QR Code',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (qrData.isNotEmpty) ...[
                  Text(
                    'Generated QR Code:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                      ),
                      child: QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: 200.0,
                        backgroundColor: Colors.white,
                        errorCorrectionLevel: QrErrorCorrectLevel.M,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Data: $qrData',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      'Enter text and press "Generate" to see the QR code',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}