import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/course/course.dart';

class CourseProvider extends GetConnect {
  // 공식 코스 리스트 가져오기
  Future<List<Course>> getOfficialCourses() async {
    // TODO: API 연결
    final response = await http.get(Uri.parse('https://example.com'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
