import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:passhub/models/sign_in_form_model.dart';
import 'package:passhub/models/sign_up_form_model.dart';
import 'package:passhub/models/user_model.dart';
import 'package:passhub/shared/shared_baseUrl.dart';

class AuthRepository {
  // Future<int?> getUserId() async {
  //   final token = await
  // }
  Future<UserModel> register(SignUpFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseURl/auth/register'),
        body: data.toJson(),
      );

      if (res.statusCode == 201) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));

        await storeCredentialToLocal(user);
        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseURl/auth/login'),
        body: jsonEncode(data.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        try {
          UserModel user = UserModel.fromJson(jsonDecode(res.body));
          await storeCredentialToLocal(user);
          return user;
        } catch (e) {
          throw 'Invalid JSON response';
        }
      } else {
        try {
          throw jsonDecode(res.body)['message'];
        } catch (e) {
          throw 'Unexpected error: ${res.body}';
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();

      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'username', value: user.username);
      await storage.write(key: 'pin', value: user.pin);
      await storage.write(key: 'id', value: user.id.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();

      Map<String, String> values = await storage.readAll();
      if (values['username'] == null || values['pin'] == null) {
        throw 'authenticated';
      } else {
        final SignInFormModel data = SignInFormModel(
          username: values['username'],
          pin: values['pin'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';
    const storage = FlutterSecureStorage();

    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer ' + value;
    }

    return token;
  }

  Future<int?> getUserId() async {
    int? userId;
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'id');

    if (value != null) {
      try {
        userId = int.parse(value);
      } catch (e) {
        rethrow;
      }
    }
    return userId;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();

    await storage.deleteAll();
  }
}
