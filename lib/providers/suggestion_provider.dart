import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SuggestionProvider extends ChangeNotifier {
  final api = ApiService();

  List suggestions = [];
  int page = 1;
  bool isLoading = false;
  bool hasNext = true;

  Future<void> fetchSuggestions() async {
    if (isLoading || !hasNext) return;

    isLoading = true;
    notifyListeners();

    final res = await api.getSuggestions(page);

    suggestions.addAll(res['data']);
    hasNext = res['pagination']['has_next'];
    page++;

    isLoading = false;
    notifyListeners();
  }
}