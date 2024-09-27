import 'dart:developer';

import 'package:frontend/controllers/filter_controller.dart';
import 'package:frontend/services/course_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/course.dart';
import 'location_controller.dart';

class RunnerController extends GetxController {
  var isLoading = false.obs;
  var runnerCourses = <Course>[].obs;

  var allCourses = <Course>[].obs;
  var filteredCourses = <Course>[].obs;
  var page = 1.obs;
  final int pageSize = 15;

  final CourseService _courseService = CourseService();
  final LocationController locationController = Get.find<LocationController>();
  final FilterController filterController = Get.find<FilterController>();

  @override
  void onInit() {
    super.onInit();

    fetchRunnerCourse();

    // 필터가 변경되었을 때 필터링을 적용하는 콜백 설정
    filterController.onSearchFilterUpdated = _applyFiltersToCourses;
  }

  // 유저 러너 코스 전체 가져오기
  Future<void> fetchRunnerCourse() async {
    isLoading.value = true;

    try {
      // 유저 코스 API 통신
      final course = await _courseService
          .getRunnerCourse(locationController.currentPosition.value!);
      log('$course');
      // 전체 코스 저장
      allCourses.value = course;
      _applyFiltersToCourses();
    } catch (e) {
      log('유저 코스 가져오던 중 문제 발생: ${e}');
    } finally {
      isLoading.value = false;
    }
  }

  // 현재 페이지 데이터만 가져오는 함수
  Future<void> _loadPageData() async {
    final int startIndex = (page.value - 1) * pageSize;
    final int endIndex = startIndex + pageSize;

    log('$startIndex 부터 $endIndex까지 데이터 로딩');

    // 전체 코스 중 일부만 보여줌
    if (startIndex < filteredCourses.length) {
      log('startIndex < filteredCourses.lenth');
      log('데이터 더 가져옴');

      runnerCourses.addAll(
        filteredCourses.sublist(
          startIndex,
          endIndex > filteredCourses.length ? filteredCourses.length : endIndex,
        ),
      );
      // 다음 페이지로 이동
      page.value += 1;
    }
  }

  // 추가 데이터를 로드하는 함수 (스크롤 끝에서 호출)
  Future<void> loadMoreData() async {
    // 이미 로딩 중인 경우 더 많은 데이터를 불러오지 않음
    if (isLoading.value || runnerCourses.length >= filteredCourses.length)
      return;

    isLoading.value = true;
    await _loadPageData();
    isLoading.value = false; // 데이터 로드 완료 후 로딩 상태 해제
  }

  // 현재 필터 조건을 적용하여 필터링된 코스 목록을 업데이트하는 함수
  void _applyFiltersToCourses() {
    var filteredList = allCourses.toList();
    log('filteredList: $filteredList');

    // 난이도 필터링
    filteredList = filteredList.where((course) {
      return filterController.selectedDifficulty.contains(course.level);
    }).toList();
    log('난이도 필터링 적용: $filteredList');

    // 거리 필터링
    filteredList = filteredList.where((course) {
      final selectedLength = filterController.selectedLength;

      // 선택된 거리 정보 중 하나라도 해당하는지 확인
      return selectedLength.any((length) {
        if (length == 3) {
          return course.courseLength <= 3;
        } else if (length == 5) {
          return course.courseLength > 3 && course.courseLength <= 5;
        } else if (length == 10) {
          return course.courseLength > 5 && course.courseLength <= 10;
        } else if (length == 'over') {
          return course.courseLength > 10;
        }

        return false;
      });
    }).toList();
    log('${filterController.selectedLength}');
    log('거리 필터링 적용: $filteredList');

    // 정렬 기준에 따른 정렬
    switch (filterController.sortCondition.value) {
      case '인기순':
        filteredList.sort((a, b) => b.count.compareTo(a.count));
        break;
      case '거리순':
        filteredList.sort((a, b) {
          if (a.distance == null && b.distance == null) return 0;
          if (a.distance == null) return 1;
          if (b.distance == null) return -1;
          return a.distance!.compareTo(b.distance!);
        });
        break;
      default:
        break;
    }

    filteredCourses.assignAll(filteredList); // 필터링된 데이터를 저장
    runnerCourses.clear(); // 페이지네이션을 위해 현재 페이지의 데이터를 초기화
    page.value = 1; // 페이지를 처음부터 다시 시작
    _loadPageData(); // 첫 페이지 데이터 로드
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

      locationController.currentPosition.value = position;
      log('장소 업데이트, position : $position');
      log('장소 업데이트, currentPosition : ${locationController.currentPosition.value!}');

      // 위치 정보 기반으로 공식 코스 데이터 가져오기
      await fetchRunnerCourse();
    } catch (e) {
      print('위치 정보 갱신 중 문제 발생 : $e');
    }
  }
}
