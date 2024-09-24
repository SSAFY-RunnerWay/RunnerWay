import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/utils/dio_client.dart';

class SearchProvider {
  var dio = Dio();
  final dioClient = DioClient();

  // 검색어 자동완성 리스트 요청
  Future<List<dynamic>> fetchWords(
    String query,
  ) async {
    try {
      final response = await dio.get(
        'https://j11b304.p.ssafy.io/api/search/candidate',
        queryParameters: {
          'searchWord': query,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsImVtYWlsIjoidGVzMnQyM3cyNEBleGFtcGxlLmNvbTIiLCJuaWNrbmFtZSI6InJ1bm4ydzMyNDIiLCJpYXQiOjE3MjU5NTc2ODMsImV4cCI6MTcyOTU1NzY4M30.64u_30Q6t3lXGYyNwLhSxfilMRtYgWKWSnqGP4XGG6k', // 개별 요청에 헤더 추가
          },
        ),
      );

      // 응답 성공 시 데이터 반환
      if (response.statusCode == 200) {
        log('$response');
        return response.data;
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // 에러 처리
      print('검색어 자동완성 리스트를 가져오는 중 문제 발생 : ${e.message}');
      throw Exception('검색어 자동완성 리스트 가져오기 실패: ${e.message}');
    }
  }

  // 공식 코스 검색 결과 요청
  Future<List<dynamic>> fetchSearchResults(
    String query,
    int page,
  ) async {
    try {
      // dioClient 요청
      final response = await dioClient.dio.get(
        '/search',
        queryParameters: {
          'searchWord': query,
          'page': page - 1,
        },
      );

      // 요청 성공 시 데이터 반환
      if (response.statusCode == 200) {
        log('검색 결과 provider : ${response}');
        return response.data['searchCourseList'];
      } else {
        throw Exception('검색 결과 조회 실패');
      }
    } on DioException catch (e) {
      log('공식 코스 검색 요청 중 오류 발생 : ${e.message}');
      throw Exception(('공식 코스 검색 요청 중 오류 발생 : ${e.message}'));
    }
  }
}
