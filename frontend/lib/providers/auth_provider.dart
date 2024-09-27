import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/utils/dio_client2.dart';
import '../models/auth.dart';

class AuthProvider {
  final dioClient = DioClient();
  Dio dio = Dio();
  final _storage = FlutterSecureStorage();

  // 사용자 회원 여부 확인 _ 이메일로 확인
  Future<dynamic> fetchOauthKakao(String email) async {
    try {
      // final response = await dioClient.dio.post('oauth/kakao/${email}');
      final response = await dio.post(
          'https://j11b304.p.ssafy.io/api/oauth/kakao/${Uri.encodeComponent(email)}',
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      log('사용자 이메일 조회 provider: ${response.data}');

      if (response.statusCode == 200) {
        return response.data['email']; // 서버에서 반환한 이메일 데이터
      } else if (response.statusCode == 303) {
        return response.data;
      } else {
        throw Exception('회원가입 실패: 서버 응답 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('카카오 회원가입 중 오류 발생 provider: $e');
      throw e;
    }
  }

  // 회원가입
  Future<Map<String, dynamic>> fetchSignupkakao(Auth authData) async {
    try {
      log('autoData: ${authData.toJson()}');
      // final response =
      //     await dioClient.dio.post('/members/sign-up', data: authData.toJson());
      final response = await dio.post(
        'https://j11b304.p.ssafy.io/api/members/sign-up',
        data: authData.toJson(),
      );
      log('서버 응답 provider: ${response.data}');

      if (response.statusCode == 200) {
        log('회원가입 성공 provider: ${response.data}');
        return {'accessToken': response.data};
      } else {
        // 500에러
        throw Exception('회원가입 실패 provider: 서버 응답 오류 (${response.statusCode})');
      }
    } on DioException catch (e) {
      log('회원가입 중 오류 발생 provider: ${e}');
      throw Exception('회원가입 중 오류 발생 provider: ${e}');
    }
  }

  // 선호 태그 등록 여부 조회
  Future<bool> checkFavoriteTag() async {
    try {
      // final response = await dioClient.dio.get(
      //   'members/tags',
      // );
      final response = await dio.get(
        'https://j11b304.p.ssafy.io/members/tags',
      );

      if (response.statusCode == 200) {
        return response.data == true;
      } else {
        throw Exception('선호 태그 조회 실패: 서버 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('선호 태그 조회 중 오류 발생 provider: $e');
      throw e;
    }
  }

  // 선호 태그 등록
  Future<void> sendFavoriteTag(Map<String, dynamic> requestBody) async {
    log('${requestBody}');
    final accessToken = await _storage.read(key: 'ACCESS_TOKEN');
    log('${accessToken}');
    log('아 왜그래');

    try {
      // final response = await dioClient.dio.post(
      //   '/members/tags',
      //   data: requestBody,
      // );
      final response =
          await dio.post('https://j11b304.p.ssafy.io/api/members/tags',
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${accessToken}',
                  'Content-Type': 'application/json', // 필요에 따라 추가
                },
              ),
              data: requestBody);
      if (response.statusCode == 200) {
        log('선호 태그 등록 성공');
      } else {
        throw Exception('선호 태그 등록 실패: 서버 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('선호 태그 등록 중 오류 발생 provider: $e');
      throw e;
    }
  }
}
