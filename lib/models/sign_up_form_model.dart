class SignUpFormModel {
  final String fullName;
  final String username;
  final String pin;

  SignUpFormModel({
    required this.fullName,
    required this.username,
    required this.pin,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'username': username,
      'pin': pin,
    };
  }
}
