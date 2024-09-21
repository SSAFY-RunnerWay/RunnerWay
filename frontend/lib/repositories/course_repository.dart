import 'package:frontend/models/course.dart';
import 'package:frontend/providers/course_provider.dart';

class CourseRepository {
  final CourseProvider _provider = CourseProvider();

  // 위치 정보를 받아 코스 목록을 반환
  Future<List<Course>> getOfficialCourses(
      double latitude, double longitude) async {
    final response = await _provider.fetchOfficialCourses(latitude, longitude);
    return response.map((courseData) => Course.fromJson(courseData)).toList();
  }
}
