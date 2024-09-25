import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../models/auth.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository = AuthRepository();

  // 사용자 이메일 가져오기
  Future<String?> getOuathKakao(String email) async {
    final auth = await _repository.getOuathKakao(email);
    return auth;
  }
}
