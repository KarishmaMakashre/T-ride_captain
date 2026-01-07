// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
  strMeal: json['strMeal'] as String,
  strMealThumb: json['strMealThumb'] as String,
  idMeal: json['idMeal'] as String,
);

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
  'strMeal': instance.strMeal,
  'strMealThumb': instance.strMealThumb,
  'idMeal': instance.idMeal,
};

MealsResponse _$MealsResponseFromJson(Map<String, dynamic> json) =>
    MealsResponse(
      meals: (json['meals'] as List<dynamic>)
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealsResponseToJson(MealsResponse instance) =>
    <String, dynamic>{'meals': instance.meals};
