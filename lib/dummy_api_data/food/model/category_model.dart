import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';  // Yeh generated file hogi

@JsonSerializable()
class Category {
  @JsonKey(name: 'idCategory')
  final String idCategory;

  @JsonKey(name: 'strCategory')
  final String strCategory;

  @JsonKey(name: 'strCategoryThumb')
  final String strCategoryThumb;

  @JsonKey(name: 'strCategoryDescription')
  final String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoriesResponse {
  final List<Category> categories;

  CategoriesResponse({required this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}