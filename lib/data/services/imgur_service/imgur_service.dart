import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'dart:collection';

class ImgurService {
  final Dio _dio = Dio();
  final String clientId = '95013e355db2e74'; // Thay bằng Client ID của bạn
  final String baseUrl = 'https://api.imgur.com/3';

  Future<String?> uploadImage(File imageFile) async {
    try {
      // Tạo form data
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      // Gọi API upload
      final response = await _dio.post(
        '$baseUrl/image',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Trả về link ảnh
        return response.data['data']['link'];
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi upload ảnh: $e');
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> getImage(String imageId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/image/$imageId',
        options: Options(
          headers: {'Authorization': 'Client-ID $clientId'},
        ),
      );
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi lấy ảnh: $e');
      }
      return {};
    }
  }

  // Lấy tất cả ảnh từ gallery
  Future<List<Map<String, dynamic>>?> getAllImages({
    String section = 'hot', // 'hot', 'top', 'user'
    String sort = 'viral', // 'viral', 'top', 'time'
    int page = 0,
    bool showViral = true,
    String window = 'day', // 'day', 'week', 'month', 'year', 'all'
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/gallery/$section/$sort/$window/$page',
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
        queryParameters: {
          'showViral': showViral,
        },
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response data: ${response.data}');
        }
        final List<dynamic> items = response.data['data'];
        return items
            .where((item) => item['type']?.startsWith('image/') ?? false)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi lấy danh sách ảnh: $e');
      }
      return null;
    }
  }

  // Lấy ảnh theo trang cụ thể
  Future<Map<String, dynamic>?> getGalleryPage({
    required int page,
    String section = 'hot',
    String sort = 'viral',
    String window = 'day',
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/gallery/$section/$sort/$window/$page',
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'data': response.data['data'],
          'success': response.data['success'],
          'status': response.statusCode,
        };
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi lấy trang ảnh: $e');
      }
      return null;
    }
  }

  // Lấy ảnh từ account
  Future<List<Map<String, dynamic>>?> getUserImages() async {
    try {
      // Thêm delay 1 giây trước khi gọi API
      await Future.delayed(Duration(seconds: 1));

      final response = await _dio.get(
        '$baseUrl/account/me/images',
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
          // Thêm validateStatus để xử lý lỗi 429
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> items = response.data['data'];
        return items.map((item) => item as Map<String, dynamic>).toList();
      } else if (response.statusCode == 429) {
        // Xử lý khi vượt quá giới hạn
        if (kDebugMode) {
          print('Đã vượt quá giới hạn request. Đợi một lát và thử lại.');
        }
        await Future.delayed(Duration(seconds: 5));
        return getUserImages(); // Thử lại sau 5 giây
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi lấy ảnh user: $e');
      }
      return null;
    }
  }

  // Hoặc lấy ảnh từ section user của gallery
  Future<List<Map<String, dynamic>>?> getUserGalleryImages({
    int page = 0,
    String sort = 'time', // 'viral', 'top', 'time'
    String window = 'all', // 'day', 'week', 'month', 'year', 'all'
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/gallery/user/$sort/$window/$page', // Endpoint cho user gallery
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response data: ${response.data}');
        }
        final List<dynamic> items = response.data['data'];
        return items
            .where((item) => item['type']?.startsWith('image/') ?? false)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi lấy ảnh gallery user: $e');
      }
      return null;
    }
  }

  // Lấy ảnh đã upload của một user cụ thể
  Future<List<Map<String, dynamic>>?> getUserUploads(String username) async {
    try {
      final response = await _dio.get(
        '$baseUrl/account/$username/images',
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response data: ${response.data}');
        }
        final List<dynamic> items = response.data['data'];
        return items.map((item) => item as Map<String, dynamic>).toList();
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi lấy ảnh uploads: $e');
      }
      return null;
    }
  }
}

// Rate Limiter class
class RateLimiter {
  final int maxRequests;
  final Duration duration;
  final Queue<DateTime> _requests = Queue();

  RateLimiter({
    required this.maxRequests,
    required this.duration,
  });

  Future<bool> tryAcquire() async {
    final now = DateTime.now();

    // Xóa các request cũ
    while (_requests.isNotEmpty && now.difference(_requests.first) > duration) {
      _requests.removeFirst();
    }

    if (_requests.length < maxRequests) {
      _requests.add(now);
      return true;
    }
    return false;
  }
}
