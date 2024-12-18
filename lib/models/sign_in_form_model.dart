class SignInFormModel {
  final String? username;
  final String? pin;

  SignInFormModel({
    this.username,
    this.pin,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'pin': pin,
    };
  }
}
