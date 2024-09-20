import 'dart:developer';

import 'package:frontend/repositories/course_repository.dart';
import 'package:geolocator/geolocator.dart';
import '../models/course.dart';

class CourseService {
  final CourseRepository _repository = CourseRepository();

  // 현재 위치와 각 코스의 거리를 계산하고 반환
  Future<List<Course>> getCoursesWithDistance(Position currentPosition) async {
    final courses = await _repository.getOfficialCourses(
        currentPosition.latitude, currentPosition.longitude);

    // 거리 계산
    return courses.map(
      (course) {
        double distance = _calculateDistance(
          currentPosition.latitude,
          currentPosition.longitude,
          course.lat,
          course.lng,
        );

        log('courseName : ${course.name}, distance : $distance');

        return course.copyWith(distance: distance);
      },
    ).toList();
  }

  // 두 지점 간의 거리 계산 (단위: 미터)
  double _calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
}
