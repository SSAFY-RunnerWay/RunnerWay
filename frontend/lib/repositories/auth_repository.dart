import 'package:frontend/providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _provider = AuthProvider();

  // 사용자 로그인
  Future<String?> getOuathKakao(String email) async {
    final response = await _provider.fetchOauthKakao(email);
    return response;
  }
}
