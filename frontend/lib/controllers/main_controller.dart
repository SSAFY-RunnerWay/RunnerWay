// controllers/main_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/models/course.dart';
import 'package:frontend/repositories/course_repository.dart';

class MainController extends GetxController {
  var currentPosition = Rxn<Position>(); // 현재 위치 정보를 관리
  var courses = <Course>[].obs; // 코스 리스트
  var isLoading = true.obs; // 로딩 상태 관리

  final CourseRepository _repository = CourseRepository();

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();

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
      _fetchOfficialCourses(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // 코스를 불러오는 함수
  Future<void> _fetchOfficialCourses(double latitude, double longitude) async {
    isLoading(true);
    try {
      final fetchedCourses =
          await _repository.getOfficialCourses(latitude, longitude);

      courses.assignAll(fetchedCourses); // 코스 데이터 업데이트
    } catch (e) {
      print('Error fetching courses: $e');
    } finally {
      isLoading(false);
    }
  }
}
