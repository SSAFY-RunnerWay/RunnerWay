import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:frontend/services/course_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/course.dart';

class RunnerPickController extends GetxController {
  var isLoading = false.obs;
  var runnerCourses = <Course>[].obs;
  var currentPosition = Rxn<Position>();

  var allCourses = <Course>[].obs;
  var page = 1.obs;
  final int pageSize = 15;

  final CourseService _courseService = CourseService();

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation(); // 뷰가 다시 들어올 때마다 위치 정보 가져오기를 호출
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

      // 위치 정보 기반으로 유저 코스 데이터 가져오기
      _fetchRunnerCourse();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // 유저 러너 코스 가져오기
  Future<void> _fetchRunnerCourse() async {
    isLoading.value = true;

    try {
      // 유저 코스 API 통신
      final course =
          await _courseService.getRunnerCourse(currentPosition.value!);
      log('$course');

      runnerCourses.value = course;
    } catch (e) {
      log('유저 코스 가져오던 중 문제 발생: ${e}');
    } finally {
      isLoading.value = false;
    }
  }
}
