// Это бы в пакет вынести
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class ImageService {
  late final Dio _dio;

  ImageService() {
    _dio = Dio(
      BaseOptions(baseUrl: 'https://gallery.prod1.webant.ru/api/'),
    );
  }

  Future<dynamic> getImages(int page, bool popular, bool newMedia) async {
    try {
      final response = await _dio.get(
        'photos',
        queryParameters: {
          'limit': 10,
          'page': page,
          'popular': popular,
          'new': newMedia,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      final message = e.toString();
      if (message.contains('SocketException')) {
        throw const SocketException('Отсутствует интернет соединение');
      }
    }
  }
}
