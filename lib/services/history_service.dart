import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _historyKey = 'qr_history';

  static Future<void> addToHistory(String qrCode) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    if (!history.contains(qrCode)) {
      history.insert(0, qrCode);
      await prefs.setStringList(_historyKey, history);
    }
  }

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}