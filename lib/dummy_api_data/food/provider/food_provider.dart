import 'package:flutter/material.dart';
import 'package:tryde_partner/dummy_api_data/food/model/category_model.dart';
import 'package:tryde_partner/dummy_api_data/food/model/meal_model.dart';
import 'package:tryde_partner/dummy_api_data/food/service/service.dart';

class MealProvider with ChangeNotifier {
  final FoodService _service = FoodService();
  
  // For Categories
  List<Category> _categories = [];
  bool _isLoadingCategories = false;
  String? _errorCategories;

  List<Category> get categories => _categories;
  bool get isLoadingCategories => _isLoadingCategories;
  String? get errorCategories => _errorCategories;

  // For Meals by Area
  List<Meal> _meals = [];
  bool _isLoadingMeals = false;
  String? _errorMeals;
  String _currentArea = '';  // Track current area for loading

  List<Meal> get meals => _meals;
  bool get isLoadingMeals => _isLoadingMeals;
  String? get errorMeals => _errorMeals;
  String get currentArea => _currentArea;

  // Load categories (existing)
  Future<void> loadCategories() async {
    _isLoadingCategories = true;
    _errorCategories = null;
    notifyListeners();

    try {
      final response = await _service.getCategories();
      _categories = response.categories;
    } catch (e) {
      _errorCategories = e.toString();
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  // New: Load meals by area
  Future<void> loadMealsByArea(String area) async {
    _currentArea = area;
    _isLoadingMeals = true;
    _errorMeals = null;
    notifyListeners();

    try {
      final response = await _service.getMealsByArea(area);
      _meals = response.meals;
    } catch (e) {
      _errorMeals = e.toString();
    } finally {
      _isLoadingMeals = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}