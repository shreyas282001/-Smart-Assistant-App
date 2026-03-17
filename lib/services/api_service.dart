class ApiService {

  Future<Map<String, dynamic>> getSuggestions(int page) async {
    await Future.delayed(const Duration(milliseconds: 800));

    List data = List.generate(10, (index) {
      int id = (page - 1) * 10 + index + 1;

      return {
        "id": id,
        "title": "AI Task $id",
        "description": "Smart AI suggestion $id"
      };
    });

    return {
      "status": "success",
      "data": data,
      "pagination": {
        "current_page": page,
        "total_pages": 5,
        "has_next": page < 5
      }
    };
  }

  Future<Map<String, dynamic>> sendChat(String msg) async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "status": "success",
      "reply": "AI says: $msg processed successfully 🚀"
    };
  }
}