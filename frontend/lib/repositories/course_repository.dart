import 'package:frontend/models/course.dart';
import 'package:frontend/models/ranking.dart';
import 'package:frontend/providers/course_provider.dart';

class CourseRepository {
  final CourseProvider _provider = CourseProvider();

  // 위치 정보를 받아 코스 목록을 반환
  Future<List<Course>> getOfficialCourses(
      double latitude, double longitude) async {
    final response = await _provider.fetchOfficialCourses(latitude, longitude);
    return response.map((courseData) => Course.fromJson(courseData)).toList();
  }

  // 공식 코스 상세 정보 조회
  Future<Course> getOfficialCourseDetail(int id) async {
    final response = await _provider.fetchOfficialCourseDetail(id);

    // response가 JSON 문자열일 경우 파싱
    return Course.fromJson(response);
  }

  // 코스 랭킹 정보 조회
  Future<List<Ranking>> getCourseRanking(int id) async {
    final response = await _provider.fetchCourseRanking(id);

    return response
        .map((courseRanking) => Ranking.fromJson(courseRanking))
        .toList();
  }
}
