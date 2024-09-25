// providers/course_provider.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/utils/dio_client.dart';

class CourseProvider {
  final dioClient = DioClient();
  var dio = Dio();

  // 공식 코스 리스트 가져오기
  Future<List<dynamic>> fetchOfficialCourses(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await dioClient.dio.get(
        'official-course/list',
        queryParameters: {
          'lat': latitude,
          'lng': longitude,
        },
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

  // 공식 코스 상세 조회 가져오기
  Future<Map<String, dynamic>> fetchOfficialCourseDetail(int id) async {
    try {
      final response = await dioClient.dio.get(
        '/official-course/detail/${id}',
      );

      log('$response');

      // 응답이 성공적이면 데이터 반환
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // 에러 처리
      print('코스 상세 정보를 가져오는 중 문제 발생 : ${e.message}');
      throw Exception('코스 가져오기 실패: ${e.message}');
    }
  }

  // 코스 랭킹 정보 요청
  Future<List<dynamic>> fetchCourseRanking(int id) async {
    try {
      final response = await dioClient.dio.get(
        '/ranking/${id}',
      );
      log('$response');

      // 응답이 성공적이면 데이터 반환
      if (response.statusCode == 200) {
        return List<dynamic>.from(response.data);
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // 에러 처리
      log('코스 랭킹 정보 가져오는 중 문제 발생 : ${e.message}');
      throw Exception('코스 랭킹 가져오기 실패 : ${e.message}');
    }
  }
}
