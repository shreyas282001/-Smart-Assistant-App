import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ChatProvider extends ChangeNotifier {
  final api = ApiService();

  List<Map<String, String>> messages = [];
  bool isTyping = false;

  Future<void> sendMessage(String msg) async {
    if (msg.trim().isEmpty) return;

    messages.add({"sender": "user", "message": msg});
    isTyping = true;
    notifyListeners();

    final res = await api.sendChat(msg);

    messages.add({
      "sender": "assistant",
      "message": res['reply']
    });

    isTyping = false;
    notifyListeners();
  }
}