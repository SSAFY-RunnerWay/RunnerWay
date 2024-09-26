import 'dart:developer';
import 'package:frontend/utils/dio_client2.dart';
import '../models/auth.dart';

class AuthProvider {
  final dioClient = DioClient();

  // 사용자 회원 여부 확인 _ 이메일로 확인
  Future<String?> fetchOauthKakao(String email) async {
    try {
      final response = await dioClient.dio.post('oauth/kakao/${email}');
      log('사용자 이메일 조회 provider: $response');
      // 서버의 응답이 200 OK인 경우 데이터 반환 -> 회원가입 진행
      if (response.statusCode == 200) {
        return response.data['email']; // 서버에서 반환한 이메일 데이터
        // 이미 가입되어 있는 경우
      } else if (response.statusCode == 303) {
        // 이미 있는 회원이라 토큰 넘겨주고 메인페이지로 이동
        return response.data['accessToken'];
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
      log('${authData.toJson()}');
      final response =
          await dioClient.dio.post('/members/sign-up', data: authData.toJson());

      if (response.statusCode == 200) {
        log('회원가입 성공 provider: ${response.data}');
        return response.data;
      } else {
        // 500에러
        throw Exception('회원가입 실패 provider: 서버 응답 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('회원가입 중 오류 발생 provider: $e');
      throw e;
    }
  }

  // 선호 태그 등록 여부 조회
  Future<bool> checkFavoriteTag() async {
    try {
      final response = await dioClient.dio.get(
        'members/tags',
      );

      if (response.statusCode == 200) {
        return response.data == true;
      } else {
        throw Exception('선호 태그 조회 실패: 서버 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('선호 태그 조회 중 오류 발생: $e');
      throw e;
    }
  }

  // 선호 태그 등록
  Future<void> sendFavoriteTag(Map<String, dynamic> requestBody) async {
    try {
      final response = await dioClient.dio.post(
        '/members/tags', // 실제 API 경로
        data: requestBody,
      );

      if (response.statusCode == 200) {
        log('선호 태그 등록 성공');
      } else {
        throw Exception('선호 태그 등록 실패: 서버 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('선호 태그 등록 중 오류 발생: $e');
      throw e;
    }
  }
}
