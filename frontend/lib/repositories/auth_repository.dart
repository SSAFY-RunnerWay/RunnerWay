import 'dart:developer';
import 'package:frontend/models/auth.dart';
import 'package:frontend/providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _provider = AuthProvider();

  // 사용자 로그인
  Future<String?> getOuathKakao(String email) async {
    final response = await _provider.fetchOauthKakao(email);
    return response;
  }

  // 회원가입 처리 (access token 반환)
  Future<String?> signupKakao(Auth authData) async {
    try {
      final response = await _provider.fetchSignupkakao(authData);
      // final accessToken = response['accessToken'];
      log('회원가입 성공: $response');
      return response['accessToken'];
    } catch (e) {
      log('회원가입 중 오류 발생: $e');
      throw e;
    }
  }

  // 선호 태그 등록 여부 확인
  Future<bool> checkFavoriteTag() async {
    try {
      return await _provider.checkFavoriteTag();
    } catch (e) {
      log('선호 태그 확인 중 오류 발생: $e');
      throw e;
    }
  }

  // 선호 태그 전송
  Future<void> sendFavoriteTag(Map<String, dynamic> requestBody) async {
    try {
      await _provider.sendFavoriteTag(requestBody);
      log('선호 태그 전송 성공');
    } catch (e) {
      log('선호 태그 전송 중 오류 발생: $e');
      throw e;
    }
  }
}
