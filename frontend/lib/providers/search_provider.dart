import 'dart:developer';

import 'package:dio/dio.dart';

class SearchProvider {
  var dio = Dio();

  // 검색어 자동완성
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
}
