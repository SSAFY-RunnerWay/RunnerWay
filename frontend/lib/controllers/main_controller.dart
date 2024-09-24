// controllers/main_controller.dart
import 'dart:developer';

import 'package:frontend/controllers/filter_controller.dart';
import 'package:frontend/services/course_service.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/models/course.dart';
import 'package:app_settings/app_settings.dart';

class MainController extends GetxController {
  var currentPosition = Rxn<Position>(); // 현재 위치 정보를 관리
  var courses = <Course>[].obs; // 코스 리스트
  var isLoading = true.obs; // 로딩 상태 관리
  var filteredCourses = <Course>[].obs; // 필터링 및 정렬된 코스 결과

  final CourseService _courseService = CourseService();
  final FilterController filterController = Get.find<FilterController>();

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();

    //초기에 filteredCourses를 courses로 세팅
    ever(courses, (_) {
      filteredCourses.assignAll(courses);
    });

    // currentPosition이 변경될 때마다 로그를 출력
    ever(currentPosition, (Position? pos) {
      if (pos != null) {
        log("Current Position: Latitude ${pos.latitude}, Longitude ${pos.longitude}");
      } else {
        log("Position not available");
      }
    });
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

      // 위치 정보 기반으로 공식 코스 데이터 가져오기
      _fetchOfficialCourses(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // 위치 정보 업데이트 시 코스 불러오고 필터 적용
  Future<void> updateCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // 위치 정보를 가져올 수 없는 경우 예외처리
      if (!serviceEnabled) {
        print('위치 정보를 가져올 수 없습니다');
        return;
      }

      // 위치 정보 요청이 거절된 경우 예외처리
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied.');
        return;
      }

      // 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentPosition.value = position;

      // 위치 정보 기반으로 공식 코스 데이터 가져오기
      await _fetchOfficialCourses(position.latitude, position.longitude);

      // 필터 및 정렬을 다시 적용
      updateCourseList();
    } catch (e) {
      print('위치 정보 갱신 중 문제 발생 : $e');
    }
  }

  // 코스를 불러오는 함수
  Future<void> _fetchOfficialCourses(double latitude, double longitude) async {
    isLoading(true);
    try {
      final fetchedCourses =
          await _courseService.getCoursesWithDistance(currentPosition.value!);

      courses.assignAll(fetchedCourses); // 코스 데이터 업데이트
    } catch (e) {
      print('Error fetching courses: $e');
    } finally {
      isLoading(false);
    }
  }

  // 코스 리스트 업데이트 함수
  void updateCourseList() {
    var filteredList = courses.toList();

    // 1. 난이도 필터링
    filteredList = filteredList.where((course) {
      return filterController.selectedDifficulty.contains(course.level);
    }).toList();

    // 2. 거리 필터링
    filteredList = filteredList.where((course) {
      final selectedLength = filterController.selectedLength;

      if (selectedLength.contains(3)) {
        return course.courseLength <= 3;
      } else if (selectedLength.contains(5)) {
        return course.courseLength >= 3 && course.courseLength <= 5;
      } else if (selectedLength.contains(10)) {
        return course.courseLength >= 5 && course.courseLength <= 10;
      } else {
        return course.courseLength >= 10;
      }
    }).toList();

    // 정렬 기준에 맞게 정렬
    switch (filterController.sortCondition.value) {
      case '인기순':
        // 인기순인 경우, count가 큰 순서로 정렬
        filteredList.sort((a, b) => b.count.compareTo(a.count));
        break;
      case '거리순':
        // 거리순인 경우, distance가 작은 순서로 정렬
        filteredList.sort((a, b) {
          if (a.distance == null && b.distance == null) return 0;
          if (a.distance == null) return 1; // distance가 null인 코스는 뒤로
          if (b.distance == null) return -1;
          return a.distance!.compareTo(b.distance!);
        });
        break;
      default:
        // 추천순인 경우 정렬 구현 x
        break;
    }

    // 필터링 및 정렬된 리스트 업데이트
    filteredCourses.assignAll(filteredList);
  }
}
