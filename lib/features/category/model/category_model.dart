class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class CategoriesResponse {
  final List<CategoryModel> data;

  CategoriesResponse({required this.data});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      data: (json['data'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }
}
