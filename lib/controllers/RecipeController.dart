import 'package:flutter/material.dart';
import 'package:myapp/model/RecipeModel.dart';
import '../services/RecipeService.dart';

class RecipeController extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _recipes = [];
  bool _isLoading = false;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;

  void loadRecipes() async {
    _isLoading = true;
    notifyListeners();

    _recipeService.getUserRecipes().listen((recipes) {
      _recipes = recipes;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _recipeService.addRecipe(recipe);
  }
}
