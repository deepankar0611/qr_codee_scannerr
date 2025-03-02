import 'package:flutter/material.dart';
import 'package:qr_codee_scannerr/services/history_service.dart';
import 'package:qr_codee_scannerr/screens/result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Scan History',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black45, blurRadius: 2, offset: Offset(1, 1))],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.redAccent, Colors.deepOrange]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  HistoryService.clearHistory();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  );
                },
              ),
            ),
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
        child: SafeArea(
          child: FutureBuilder<List<String>>(
            future: HistoryService.getHistory(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              final history = snapshot.data!;
              if (history.isEmpty) {
                return Center(
                  child: Text(
                    'No scan history yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Transform.rotate(
                      angle: 0.02 * (index % 2 == 0 ? 1 : -1), // Slight alternating tilt
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                        ),
                        child: ListTile(
                          title: Text(
                            history[index],
                            style: const TextStyle(color: Colors.black87),
                          ),
                          subtitle: Text(
                            'Scanned on ${DateTime.now().toString().substring(0, 19)}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(result: history[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}