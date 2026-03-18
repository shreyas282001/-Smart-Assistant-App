import 'dart:async';

class ApiService {
  Future<Map<String, dynamic>> getSuggestions(int page, int limit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    List allData = List.generate(20, (i) => {
          "id": i + 1,
          "title": "Ask about topic ${i + 1}",
          "description": "Try something interesting"
        });

    int start = (page - 1) * limit;
    int end = start + limit;

    return {
      "status": "success",
      "data": allData.sublist(
        start,
        end > allData.length ? allData.length : end,
      ),
      "pagination": {"has_next": end < allData.length}
    };
  }

  Future<Map<String, dynamic>> sendChat(String message) async {
    await Future.delayed(const Duration(seconds: 1));

    String msg = message.toLowerCase();
    String reply;

    if (msg.contains("flutter")) {
      reply = "Flutter is a UI toolkit by Google.";
    } else if (msg.contains("hello")) {
      reply = "Hello 👋 How can I help?";
    } else {
      reply = "Interesting 🤔 Tell me more!";
    }

    return {"status": "success", "reply": reply};
  }

  Future<Map<String, dynamic>> getChatHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {"status": "success", "data": []};
  }
}