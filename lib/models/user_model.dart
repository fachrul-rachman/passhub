class UserModel {
  final int? id;
  final String? fullName;
  final String? username;
  final String? pin;
  final String? token;

  UserModel({
    this.id,
    this.fullName,
    this.username,
    this.pin,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      fullName: json['full_name'],
      username: json['username'],
      pin: json['pin'],
      token: json['token']);
}
