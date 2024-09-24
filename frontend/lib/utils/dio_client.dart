import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  late final Dio _dio;
  final _storage = FlutterSecureStorage();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://j11b304.p.ssafy.io/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          log('Request[${options.method}] => PATH: ${options.path}');

          // 주석 부분은 로그인 구현 후 사용
          final accessToken = await _storage.read(key: 'ACCESS_TOKEN');
          if (accessToken != null && !_isAuthorizationExcluded(options.path)) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsImVtYWlsIjoidGVzMnQyM3cyNEBleGFtcGxlLmNvbTIiLCJuaWNrbmFtZSI6InJ1bm4ydzMyNDIiLCJpYXQiOjE3MjU5NTc2ODMsImV4cCI6MTcyOTU1NzY4M30.64u_30Q6t3lXGYyNwLhSxfilMRtYgWKWSnqGP4XGG6k';
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response[${response.statusCode}] => DATA: ${response.data}');

          // 특정 응답에서 Authorization 헤더 추출 및 저장
          if (response.headers['authorization'] != null) {
            String? newToken = response.headers['authorization']?.first;
            // Secure Storage를 활용한 토큰 저장 로직
            _saveToken(newToken);
          }

          handler.next(response);
        },
        onError: (DioException e, handler) {
          log('Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  // Authorization 토큰을 저장하는 함수
  Future<void> _saveToken(String? token) async {
    if (token != null && token.isNotEmpty) {
      await _storage.write(key: 'ACCESS_TOKEN', value: token);
      log('토큰 저장: $token');
    }
  }

  // 토큰 필요 없는 path 확인
  bool _isAuthorizationExcluded(String path) {
    const excludedPaths = [
      '/oauth/kakao',
      '/members/tags',
      '/members/sign-up',
      '/members/duplication-nickname'
    ];
    return excludedPaths.any((excluded) => path.contains(excluded));
  }
}
