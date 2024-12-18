import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:passhub/models/category_form_model.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/repositories/auth_repository.dart';
import 'package:passhub/shared/shared_baseUrl.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getCategory() async {
    try {
      final token = await AuthRepository().getToken();
      final res = await http.get(
          Uri.parse(
            '$baseURl/categories',
          ),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
      print('Category Fetch Status Code: ${res.statusCode}');
      print('Category Fetch Response Body: ${res.body}');

      if (res.statusCode == 200) {
        final jsonData = jsonDecode(res.body);

        // Pastikan struktur data benar
        if (jsonData is List) {
          final categories = jsonData
              .map<CategoryModel>(
                  (category) => CategoryModel.fromJson(category))
              .toList();

          print('Parsed Categories: $categories');
          return categories;
        } else {
          throw 'Invalid JSON format';
        }
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryModel> createCategory(CategoryFormModel data) async {
    try {
      final token = await AuthRepository().getToken();
      final res = await http.post(
        Uri.parse('$baseURl/categories'),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 201) {
        // Periksa struktur JSON
        final responseBody = jsonDecode(res.body);

        // Jika responseBody adalah List, ambil item pertama
        if (responseBody is List) {
          return CategoryModel.fromJson(responseBody.first);
        }
        // Jika sudah Map, langsung parsing
        else if (responseBody is Map<String, dynamic>) {
          return CategoryModel.fromJson(responseBody);
        }

        throw 'Invalid response format';
      } else {
        throw jsonDecode(res.body)['message'] ?? 'Gagal Menambahkan Category!';
      }
    } catch (e) {
      print('Error in createCategory: $e');
      rethrow;
    }
  }
}
