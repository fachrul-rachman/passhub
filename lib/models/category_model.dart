class CategoryModel {
  final int? id;
  final String? categoryName;
  final int? userId;

  const CategoryModel({
    this.id,
    this.categoryName,
    this.userId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        categoryName: json['category_name'],
        userId: json['user_id'],
      );
}
