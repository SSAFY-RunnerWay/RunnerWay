import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/auth.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository = AuthRepository();
  Dio dio = Dio();

  // 사용자 이메일 확인
  Future<dynamic> getOuathKakao(String email) async {
    final auth = await _repository.getOuathKakao(email);
    log('service: $auth');
    return auth;
  }

// 사용자 회원가입
  Future<String?> signupKakao(Auth authData) async {
    try {
      final accessToken = await _repository.signupKakao(authData);
      log('회원가입 성공 service: $accessToken');
      return accessToken;
    } catch (e) {
      log('회원가입 중 오류 발생 service: $e');
      throw e;
    }
  }

// 닉네임 중복 체크 함수 추가
  Future<bool> checkNicknameDuplicate(String nickname) async {
    try {
      return await _repository.nickNameCheck(nickname);
    } catch (e) {
      throw Exception('닉네임 중복 확인 중 오류 발생 service: $e');
    }
  }

  // 선호 태그 전송
  Future<void> sendFavoriteTag(Map<String, dynamic> requestBody) async {
    try {
      await _repository.sendFavoriteTag(requestBody);
    } catch (e) {
      throw Exception('선호 태그 전송 중 오류 발생 service: $e');
    }
  }

  // 선호 태그 등록 여부 확인
  Future<bool> checkFavoriteTag() async {
    try {
      return await _repository.checkFavoriteTag();
    } catch (e) {
      throw Exception('선호 태그 확인 중 오류 발생: $e');
    }
  }
}
