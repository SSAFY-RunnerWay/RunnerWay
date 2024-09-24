import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:get/get.dart';
import 'package:frontend/utils/dio_client2.dart'; // DioClient를 사용해 서버와 통신

class AuthController extends GetxController {
  var email = ''.obs; // 카카오톡에서 받아올 이메일
  var isLoggedIn = false.obs; // 로그인 여부
  DioClient dioClient = DioClient();
  final _storage = FlutterSecureStorage(); // 토큰 저장용

  // 카카오톡 로그인
  Future<void> loginWithKakao() async {
    try {
      // 기본 카카오 로그인
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      print('카카오톡으로 로그인 성공: ${token.accessToken}');
      // 토큰을 스토리지에 저장
      await _saveToken(token);
      // 사용자 정보 요청
      await requestUserInfo();
    } catch (error) {
      print('카카오톡 로그인 실패: $error');
      Get.snackbar('오류', '카카오톡 로그인에 실패했습니다.');
    }
  }

  // 토큰 저장
  Future<void> _saveToken(OAuthToken token) async {
    await _storage.write(key: 'ACCESS_TOKEN', value: token.accessToken);
    await _storage.write(key: 'REFRESH_TOKEN', value: token.refreshToken);
  }

  // 카카오 사용자 정보 가져오기
  Future<void> requestUserInfo() async {
    try {
      User user = await UserApi.instance.me();

      // 이메일 제공 동의 여부 확인
      if (user.kakaoAccount?.emailNeedsAgreement == true) {
        // 이메일 제공 동의가 필요한 경우
        log('이메일 제공 동의 필요');

        // 추가 동의 요청
        List<String> scopes = ['account_email'];
        OAuthToken token = await UserApi.instance.loginWithNewScopes(scopes);

        // 새로운 동의를 받고 사용자 정보 다시 요청
        user = await UserApi.instance.me();
      }

      // 이메일 출력
      log('사용자 정보 요청 성공: ${user.kakaoAccount?.email}');
      email.value = user.kakaoAccount?.email ?? "Unknown";
      checkUserEmailOnServer(email.value);
    } catch (error) {
      print('사용자 정보 요청 실패: $error');
      Get.snackbar('오류', '사용자 정보를 가져오지 못했습니다.');
    }
  }

// 서버로 이메일을 보내 회원 여부 확인
  Future<void> checkUserEmailOnServer(String userEmail) async {
    try {
      // 서버에 이메일 전송하여 회원 여부 확인
      final response = await dioClient.sendEmailForVerification(userEmail);
      log('${response['email']}');
      if (response['email'] == null) {
        // 메인페이지로 이동
        print('이미 존재하는 회원입니다. 로그인 처리');
      } else {
        print('새로운 회원입니다. 회원가입 페이지로 이동');
        // 여기서 회원가입 프로세스 시작 가능
      }
    } catch (e) {
      print('회원 여부 확인 중 오류 발생: $e');
    }
  }

  // Future<void> signUpUser(
  //     String email, String nickname, String birthDate, String gender) async {
  //   try {
  //     final response = await _dio.post(
  //       '/sign-up',
  //       data: {
  //         'email': email,
  //         'nickname': nickname,
  //         'birthDate': birthDate,
  //         'gender': gender,
  //       },
  //     );
  //
  //     if (response.statusCode == 201) {
  //       print('회원가입 성공!');
  //     } else {
  //       print('회원가입 실패: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('회원가입 중 오류 발생: $e');
  //   }
  // }
}
