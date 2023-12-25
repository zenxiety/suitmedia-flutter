import 'package:suitmedia_mobile_intern/models/users_model.dart';
import 'package:dio/dio.dart';

class UsersService {
  static final Dio _dio = Dio();

  static Future<UsersModel?> getUsers({required int page}) async {
    final String path = "https://reqres.in/api/users?page=$page&per_page=10";

    try {
      final response = await _dio.get(path);

      return UsersModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
