import 'dart:developer';
import 'package:frontend/models/auth.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class AuthRepository {
  final AuthProvider _provider = AuthProvider();

  // 사용자 로그인
  Future<String?> getOuathKakao(String email) async {
    final response = await _provider.fetchOauthKakao(email);
    return response;
  }
}
