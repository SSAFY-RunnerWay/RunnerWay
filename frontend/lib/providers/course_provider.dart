// providers/course_provider.dart
import 'dart:developer';

import 'package:dio/dio.dart';

class CourseProvider {
  var dio = Dio();

  // 공식 코스 리스트 가져오기
  Future<List<dynamic>> fetchOfficialCourses(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await dio.get(
        'https://j11b304.p.ssafy.io/api/officialCourse/list',
        queryParameters: {
          'lat': latitude,
          'lng': longitude,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsImVtYWlsIjoidGVzMnQyM3cyNEBleGFtcGxlLmNvbTIiLCJuaWNrbmFtZSI6InJ1bm4ydzMyNDIiLCJpYXQiOjE3MjU5NTc2ODMsImV4cCI6MTcyOTU1NzY4M30.64u_30Q6t3lXGYyNwLhSxfilMRtYgWKWSnqGP4XGG6k', // 개별 요청에 헤더 추가
          },
        ),
      );
      log('$response');

      // 응답이 성공적이면 데이터 반환
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // 에러 처리
      print('코스를 가져오는 중 문제 발생 : ${e.message}');
      throw Exception('코스 가져오기 실패: ${e.message}');
    }
  }
}
