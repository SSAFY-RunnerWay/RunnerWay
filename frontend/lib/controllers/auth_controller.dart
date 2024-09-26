import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/views/auth/signup_view.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:get/get.dart';
import '../views/auth/signup_view2.dart';
import '../views/main/main_view.dart';
import '../models/auth.dart';

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
      await _saveToken(token.accessToken);

      // 사용자 정보 요청
      await requestUserInfo();
    } catch (error) {
      log('카카오톡 로그인 실패: $error');
      Get.snackbar('오류', '카카오톡 로그인에 실패했습니다.');
    }
  }

  // 카카오 사용자 정보 가져오기
  Future<void> requestUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      email.value = user.kakaoAccount?.email ?? "Unknown";
      log('사용자 정보 요청 성공_controller: ${email.value}');
      await checkUserEmailOnServer(email.value);
    } catch (error) {
      log('사용자 정보 요청 실패_controller: $error');
      Get.snackbar('오류', '사용자 정보를 가져오지 못했습니다.');
    }
  }

// 서버로 이메일을 보내 회원 여부 확인
  Future<void> checkUserEmailOnServer(String userEmail) async {
    try {
      // provider에서 응답 받기
      final response = await _authService.getOuathKakao(userEmail);

      // 서버에서 받은 응답이 accessToken인 경우
      if (response != null && response.startsWith("Bearer ")) {
        // accessToken 저장
        await _saveToken(response);
        // 메인 페이지로 이동
        Get.offAll(MainView());
      }
      // 서버에서 받은 응답이 이메일인 경우 (회원가입 필요)
      else if (response == userEmail) {
        email.value = userEmail;
        Get.to(SignUpView(email: email.value));
      } else {
        log('서버 응답에서 예상치 못한 값이 있습니다.');
      }
    } catch (e) {
      log('회원 여부 확인 중 오류 발생: $e');
      Get.snackbar('오류', '회원 여부 확인 중 오류가 발생했습니다.');
    }
  }

  // 사용자 정보 입력
  Future<void> signup(Auth authData) async {
    try {
      final accessToken = await _authService.signupKakao(authData);
      if (accessToken != null) {
        log('회원가입 성공');
        await _saveToken(accessToken);
        Get.snackbar('성공', '선호태그 입력 페이지로 이동합니다.');
      } else {
        Get.snackbar('오류', '회원가입 중 오류가 발생했습니다.');
      }
    } catch (e) {
      log('회원가입 중 오류 발생: $e');
      Get.snackbar('오류', '회원가입에 실패했습니다.');
    }
  }

// 토큰 저장
  Future<void> _saveToken(String? accessToken) async {
    log('저장할 accessToken _ controller: ${accessToken}');
    if (accessToken != null) {
      await _storage.write(key: 'ACCESS_TOKEN', value: accessToken);
      log('토큰 저장 성공');
    } else {
      log('토큰 저장 실패: accessToken이 없습니다.');
    }
  }

// 선호 태그 등록 여부 확인
  Future<void> checkFavoriteTag() async {
    try {
      final isTagRegistered = await _authService.checkFavoriteTag();
      if (isTagRegistered) {
        Get.offAll(MainView());
      } else {
        Get.to(SignUpView2());
      }
    } catch (e) {
      log('선호 태그 확인 중 오류 발생: $e');
    }
  }

  // 선호 태그 전송
  Future<void> sendFavoriteTag(List<String> favoriteTags) async {
    try {
      Map<String, dynamic> requestBody = {
        "favoriteCourses": favoriteTags.map((tag) => {"tagName": tag}).toList()
      };
      await _authService.sendFavoriteTag(requestBody);

      Get.snackbar('성공', '선호 태그가 등록되었습니다.');
      Get.offAll(MainView());
    } catch (e) {
      Get.snackbar('오류', '선호 태그 등록 중 오류가 발생했습니다.');
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
