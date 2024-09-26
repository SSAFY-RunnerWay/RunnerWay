import 'dart:developer';
import 'package:frontend/utils/dio_client2.dart';

class AuthProvider {
  final dioClient = DioClient();
  // var dio = Dio();

  // 사용자 회원 여부 확인
  Future<String?> fetchOauthKakao(String email) async {
    try {
      // 이메일을 path 파라미터로 전달
      final response = await dioClient.dio.post(
        'oauth/kakao/${email}',
      );
      log('사용자 이메일 조회 provider: $response');
      // 서버의 응답이 200 OK인 경우 데이터 반환
      if (response.statusCode == 200) {
        return response.data['email']; // 서버에서 반환한 이메일 데이터
        // 회원가입 페이지로 이동
      } else if (response.statusCode == 303) {
        // TODO
        // 여기에 토큰 저장 코드

        return null;
      } else {
        // 이미 있는 회원이라 토큰 넘겨주고 메인페이지로 이동
        throw Exception('회원가입 실패: 서버 응답 오류 (${response.statusCode})');
      }
    } catch (e) {
      log('카카오 회원가입 중 오류 발생: $e');
      throw e;
    }
  }

  // 회원가입
}
