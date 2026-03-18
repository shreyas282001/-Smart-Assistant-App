import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SuggestionProvider extends ChangeNotifier {
  final ApiService api = ApiService();

  List<Map<String, dynamic>> suggestions = [];
  int page = 1;
  bool hasNext = true;
  bool isLoading = false;

  Future<void> fetchSuggestions() async {
    if (isLoading || !hasNext) return;

    isLoading = true;
    notifyListeners();

    final res = await api.getSuggestions(page, 5);

    suggestions.addAll(List<Map<String, dynamic>>.from(res['data']));
    hasNext = res['pagination']['has_next'];
    page++;

    isLoading = false;
    notifyListeners();
  }
}