import 'dart:developer';

import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/models/course.dart';
import 'package:frontend/services/course_service.dart';
import 'package:get/get.dart';

class RunnerPickController extends GetxController {
  // 가장 인기 많은 코스 상태관리
  var mostPickCourses = <Course>[].obs;
  // 최근 인기 많은 코스 상태관리
  var recentPickCourses = <Course>[].obs;

  // 로딩 상태관리
  var isMostPickLoading = false.obs;
  var isRecentPickLoading = false.obs;

  final LocationController locationController = Get.find<LocationController>();
  // course sevice
  final CourseService _courseService = CourseService();

  @override
  void onInit() {
    super.onInit();

    // 위치 정보 기반으로 전체 인기 코스 & 최근 인기 코스 데이터 가져오기
    _fetchMostPickCourses();
    _fetchRecentPickCourses();
  }

  Future<void> _fetchMostPickCourses() async {
    // 요청 들어오면, 로딩 상태 시작
    isMostPickLoading.value = true;

    try {
      // 전체 인기 코스 API 통신
      final courses = await _courseService
          .getMostPickCourse(locationController.currentPosition.value!);
      log('전체 인기 코스 controller : $courses');

      // 전체 인기 코스 저장
      mostPickCourses.value = courses;
    } catch (e) {
      log('_fetchMostPickCourses 문제 발생 : $e');
    } finally {
      // 로딩 종료
      isMostPickLoading.value = false;
    }
  }

  Future<void> _fetchRecentPickCourses() async {
    // 요청 들어오면 로딩 상태 시작
    isRecentPickLoading.value = true;

    try {
      // 전체 인기 코스 API 통신
      final courses = await _courseService
          .getRecentPickCourse(locationController.currentPosition.value!);
      log('최근 인기 코스 controller : $courses');

      // 전체 인기 코스 저장
      recentPickCourses.value = courses;
    } catch (e) {
      log('_fetchRecentPickCourses 문제 발생 : $e');
    } finally {
      // 로딩 종료
      isRecentPickLoading.value = false;
    }
  }
}
