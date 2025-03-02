import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_codee_scannerr/screens/result_screen.dart';
import 'package:qr_codee_scannerr/services/history_service.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  bool isTorchOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _toggleTorch() async {
    await controller.toggleTorch();
    setState(() {
      isTorchOn = !isTorchOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Scan QR Code',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black45, blurRadius: 2, offset: Offset(1, 1))],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isTorchOn ? Icons.flash_on : Icons.flash_off, color: Colors.white),
            onPressed: _toggleTorch,
          ),
        ],
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
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    HistoryService.addToHistory(barcode.rawValue!);
                    controller.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(result: barcode.rawValue!),
                      ),
                    ).then((_) => controller.start());
                    break;
                  }
                }
              },
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                    ),
                    child: const Text(
                      'Align QR code within frame to scan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}