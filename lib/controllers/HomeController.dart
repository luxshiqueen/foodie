import 'package:flutter/material.dart';
import 'package:myapp/model/MealModel.dart';
import 'package:myapp/services/MealDBService.dart';

class HomeController extends ChangeNotifier {
  final MealDBService _mealDBService = MealDBService();
  List<Category> _categories = [];
  bool _isLoading = true;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  void fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();
      _categories = await _mealDBService.fetchCategories();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
