import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tryde_partner/dummy_api_data/food/model/category_model.dart';
import 'package:tryde_partner/dummy_api_data/food/model/meal_model.dart';


class FoodService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Existing: Get categories
  Future<CategoriesResponse> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories.php'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return CategoriesResponse.fromJson(data);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // New: Get meals filtered by area (country)
  Future<MealsResponse> getMealsByArea(String area) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/filter.php?a=$area'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Handle empty meals case
        if (data['meals'] == null) {
          return MealsResponse(meals: []);
        }
        return MealsResponse.fromJson(data);
      } else {
        throw Exception('Failed to load meals for $area: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching meals for $area: $e');
    }
  }
}