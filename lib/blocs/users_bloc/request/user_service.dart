import 'package:dio/dio.dart';

class UserService {
  late final Dio _dio;

  UserService() {
    _dio = Dio(
      BaseOptions(baseUrl: 'https://gallery.prod1.webant.ru/api/'),
    );
  }

  Future<dynamic> getUserById(String id) async {
    try {
      final response = await _dio.get('users/$id');

      print(response.data);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on Exception {}
  }
}
