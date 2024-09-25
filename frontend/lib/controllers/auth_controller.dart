import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/views/auth/signup_view.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var isLoggedIn = false.obs;

  final AuthService _authService = AuthService();
  final _storage = FlutterSecureStorage(); // 토큰 저장

  // 카카오톡 로그인
  Future<void> loginWithKakao() async {
    try {
      // 기본 카카오 로그인
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      log('카카오 로그인 성공: ${token.accessToken}');
      // 토큰을 스토리지에 저장
      await _saveToken(token);

      // 저장된 토큰을 바로 불러와서 확인
      String? accessToken = await _storage.read(key: 'ACCESS_TOKEN');
      if (accessToken != null) {
        log('카카오톡으로 로그인 성공: ${token.accessToken}');
      } else {
        log('토큰 저장 실패: 불러올 수 없습니다.');
      }
      // 사용자 정보 요청
      await requestUserInfo();

      // 로그인 성공 상태
      isLoggedIn.value = true;
    } catch (error) {
      log('카카오톡 로그인 실패: $error');
      Get.snackbar('오류', '카카오톡 로그인에 실패했습니다.');
    }
  }

// 토큰 저장
  Future<void> _saveToken(OAuthToken token) async {
    log('저장할 accessToken: ${token.accessToken}');
    if (token.accessToken != null) {
      await _storage.write(key: 'ACCESS_TOKEN', value: token.accessToken);
      log('토큰 저장 성공');
    } else {
      log('토큰 저장 실패: accessToken이 없습니다.');
    }
  }

  // 서버로 이메일을 보내 회원 여부 확인
  Future<void> checkUserEmailOnServer(String userEmail) async {
    try {
      final response = await _authService.getOuathKakao(userEmail);
      // log('서버 응답 이메일: ${response}');
      if (response != null) {
        // TODO
        // email.value = response;
        email.value = 'tmdxkr5@hanmail.net';
        // 회원가입 페이지로 이동
        Get.to(SignUpView());
      } else {
        print('이미 존재하는 회원입니다. 로그인 처리');
        // 메인페이지로 이동
      }
    } catch (e) {
      log('회원 여부 확인 중 오류 발생: $e');
    }
  }

  // 카카오 사용자 정보 가져오기
  Future<void> requestUserInfo() async {
    log('토큰 저장 확인 시작');
    String? accessToken = await _storage.read(key: 'ACCESS_TOKEN');

    // 저장된 토큰이 없으면 에러 처리
    if (accessToken != null) {
      log('저장된 토큰 확인: $accessToken');
    } else {
      log('토큰 저장 실패: 불러올 수 없습니다.');
    }

    // AccessToken을 설정
    // AccessTokenStore.instance.setToken(OAuthToken(accessToken: accessToken));
    try {
      User user = await UserApi.instance.me();

      if (user.kakaoAccount?.emailNeedsAgreement == true) {
        List<String> scopes = ['account_email'];
        OAuthToken token = await UserApi.instance.loginWithNewScopes(scopes);
        user = await UserApi.instance.me();
      }

      email.value = user.kakaoAccount?.email ?? "Unknown";
      log('사용자 정보 요청 성공: ${email.value}');
      await checkUserEmailOnServer(email.value);
    } catch (error) {
      log('사용자 정보 요청 실패: $error');
      Get.snackbar('오류', '사용자 정보를 가져오지 못했습니다.');
    }
  }

  // 로그아웃 함수
  Future<void> logout() async {
    try {
      await UserApi.instance.logout();
      await _storage.deleteAll(); // 저장된 토큰 삭제
      isLoggedIn.value = false;
      email.value = '';
      log('로그아웃 성공');
    } catch (error) {
      log('로그아웃 실패: $error');
      Get.snackbar('오류', '로그아웃에 실패했습니다.');
    }
  }
}
