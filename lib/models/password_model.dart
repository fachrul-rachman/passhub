class PasswordModel {
  final int? id;
  final int? userId;
  final String? platform;
  final String? imgPlatform;
  final String? email;
  final String? password;
  final int? categoryId;
  final String? categoryName;

  PasswordModel({
    this.id,
    this.userId,
    this.platform,
    this.imgPlatform,
    this.email,
    this.password,
    this.categoryId,
    this.categoryName,
  });

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
        id: json['id'],
        userId: json['user_id'],
        platform: json['platform'],
        imgPlatform: json['img_platform'],
        email: json['email'],
        password: json['password'],
        categoryId: json['category_id'],
        categoryName:
            json['category'] != null ? json['category']['category_name'] : null,
      );
}
