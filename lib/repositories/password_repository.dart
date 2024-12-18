import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:passhub/models/password_form_model.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/repositories/auth_repository.dart';
import 'package:passhub/shared/shared_baseUrl.dart';

class PasswordRepository {
  Future<List<PasswordModel>> getPassword() async {
    try {
      final token = await AuthRepository().getToken();

      final res = await http.get(
          Uri.parse(
            '$baseURl/passwords',
          ),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

      if (res.statusCode == 200) {
        return List<PasswordModel>.from(jsonDecode(res.body)
            .map((passwords) => PasswordModel.fromJson(passwords))).toList();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PasswordModel> createPassword(PasswordFormModel data) async {
    try {
      final token = await AuthRepository().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseURl/passwords',
        ),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );

      if (res.statusCode == 201) {
        PasswordModel password = PasswordModel.fromJson(jsonDecode(res.body));

        return password;
      } else {
        throw jsonDecode(res.body)['message'] ?? 'Gagal membuat Password';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePassword(int id) async {
    try {
      final token = await AuthRepository().getToken();
      final res = await http.delete(
          Uri.parse(
            '$baseURl/passwords/$id',
          ),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'] ?? 'Failed To delete Password';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PasswordModel>> getPasswordByCategory(int categoryId) async {
    try {
      final token = await AuthRepository().getToken();
      final res = await http.get(
          Uri.parse(
            '$baseURl/passwords/category/$categoryId',
          ),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

      if (res.statusCode == 200) {
        return List<PasswordModel>.from(jsonDecode(res.body)
            .map((passwords) => PasswordModel.fromJson(passwords))).toList();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
