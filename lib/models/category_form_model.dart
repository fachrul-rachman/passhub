class CategoryFormModel {
  final int? userId;
  final int? id;
  final String? categoryName;

  CategoryFormModel({
    this.userId,
    this.id,
    this.categoryName,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'id': id,
      'category_name': categoryName,
    };
  }
}
