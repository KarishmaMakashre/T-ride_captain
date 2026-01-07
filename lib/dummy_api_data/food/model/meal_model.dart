import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';  // Generated file hogi

@JsonSerializable()
class Meal {
  @JsonKey(name: 'strMeal')
  final String strMeal;

  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;

  @JsonKey(name: 'idMeal')
  final String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@JsonSerializable()
class MealsResponse {
  final List<Meal> meals;

  MealsResponse({required this.meals});

  factory MealsResponse.fromJson(Map<String, dynamic> json) => _$MealsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealsResponseToJson(this);
}