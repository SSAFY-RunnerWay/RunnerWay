import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class DioClient {
  late final Dio _dio;
  final _storage = FlutterSecureStorage();
  bool _isRefreshing = false;
  Future<void>? _refreshTokenFuture;

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

          final accessToken = await _storage.read(key: 'ACCESS_TOKEN');
          if (accessToken != null && !_isAuthorizationExcluded(options.path)) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 && !_isRefreshing) {
            if (_refreshTokenFuture == null) {
              _isRefreshing = true;
              _refreshTokenFuture = _refreshToken();
              await _refreshTokenFuture;
              _isRefreshing = false;
            } else {
              await _refreshTokenFuture;
            }

            final newAccessToken = await _storage.read(key: 'ACCESS_TOKEN');
            if (newAccessToken != null) {
              e.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              // 요청을 다시 시도
              final clonedRequest = await _dio.request(
                e.requestOptions.path,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                ),
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              handler.resolve(clonedRequest);
            } else {
              handler.next(e); // 갱신 실패 시 에러 처리
            }
          } else {
            handler.next(e);
          }
        },
      ),
    );
  }

  Dio get dio => _dio;

  // 카카오 토큰 갱신 처리
  Future<void> _refreshToken() async {
    try {
      OAuthToken newToken = await AuthApi.instance.refreshToken();
      log('새로운 토큰: ${newToken.accessToken}');

      await _storage.write(key: 'ACCESS_TOKEN', value: newToken.accessToken);
      await _storage.write(key: 'REFRESH_TOKEN', value: newToken.refreshToken);
    } catch (e) {
      log('토큰 갱신 실패: $e');
    }
  }

  // 토큰이 필요 없는 경로 확인
  // TODO
  bool _isAuthorizationExcluded(String path) {
    const excludedPaths = [
      '/oauth/kakao',
      '/members/tags',
      '/members/sign-up',
      '/members/duplication-nickname'
    ];
    return excludedPaths.any((excluded) => path.contains(excluded));
  }

  // 서버로 이메일 전송하여 회원 여부 확인
  Future<Map<String, dynamic>> sendEmailForVerification(String email) async {
    try {
      log('서버로 이메일 전송: $email');

      // 이메일을 포함한 POST 요청
      final response = await _dio.post(
        'oauth/kakao/$email', // 서버의 이메일 확인 API 엔드포인트
      );

      if (response.statusCode == 200) {
        log('서버 응답 성공: ${response.data}');
        return response.data; // 서버에서 받은 데이터 반환
      } else {
        throw Exception('서버 응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      log('서버 통신 중 오류 발생: $e');
      throw e;
    }
  }
}
