import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/model/MealModel.dart';

class MealDBService {
  Future<List<Category>> fetchCategories() async {
    const url = 'https://www.themealdb.com/api/json/v1/1/categories.php';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categories = data['categories'];
      return categories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
