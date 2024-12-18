class PasswordFormModel {
  // final int? id;
  // final int? userId;
  final String? platform;
  final String? email;
  final bool? generate;
  final int? length;
  final int? uppercase;
  final int? number;
  final int? symbol;
  final String? password;
  final int? categoryId;
  final String? imgPlatform;

  PasswordFormModel({
    // this.id,
    // this.userId,
    this.platform,
    this.email,
    this.generate,
    this.length,
    this.uppercase,
    this.number,
    this.symbol,
    this.imgPlatform,
    this.categoryId,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final data = {
      // 'id': id,
      // 'user_id': userId,
      'platform': platform,
      'email': email,
      'generate': generate,
      'length': length,
      'uppercase_count': uppercase,
      'number_count': number,
      'symbol_count': symbol,
      'img_platform': imgPlatform,
      'category_id': categoryId,
      'password': password,
    };

    return data;
  }
}
