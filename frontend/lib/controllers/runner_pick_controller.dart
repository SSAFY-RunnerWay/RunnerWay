import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:frontend/models/course.dart';
import 'package:frontend/services/course_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class RunnerPickController extends GetxController {
  // 가장 인기 많은 코스 상태관리
  var mostPickCourses = <Course>[].obs;
  // 최근 인기 많은 코스 상태관리
  var recentPickCourses = <Course>[].obs;

  // 로딩 상태관리
  var isMostPickLoading = false.obs;
  var isRecentPickLoading = false.obs;

  // 현위치 상태관리
  var currentPosition = Rxn<Position>();

  // course sevice
  final CourseService _courseService = CourseService();

  @override
  void onInit() {
    super.onInit();

    // 뷰에 들어올 때마다 위치 정보 가져오기
    _getCurrentLocation();
  }

  // 위치 정보를 가져오고 코스를 불러오는 함수
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // 위치 서비스가 꺼져있는 경우 예외처리
      if (!serviceEnabled) {
        print('위치 정보를 가져올 수 없습니다');
        AppSettings.openAppSettings(type: AppSettingsType.location);
        return;
      }

      // 위치 정보 요청이 거절된 경우 예외 처리 (사용자가 위치 권한을 거부)
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }

      // 위치 정보 요청이 영구적으로 거절된 경우 예외 처리:
      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied.');
        return;
      }

      // 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentPosition.value = position;

      // 위치 정보 기반으로 전체 인기 코스 & 최근 인기 코스 데이터 가져오기
      _fetchMostPickCourses();
      _fetchRecentPickCourses();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _fetchMostPickCourses() async {
    // 요청 들어오면, 로딩 상태 시작
    isMostPickLoading.value = true;

    try {
      // 전체 인기 코스 API 통신
      final courses =
          await _courseService.getMostPickCourse(currentPosition.value!);
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
      final courses =
          await _courseService.getRecentPickCourse(currentPosition.value!);
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
