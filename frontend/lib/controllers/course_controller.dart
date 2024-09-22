import 'dart:developer';

import 'package:frontend/services/course_service.dart';
import 'package:get/get.dart';

import '../models/course.dart';

class CourseController extends GetxController {
  var isLoading = true.obs;
  var course = Rxn<Course>();

  final CourseService _courseService = CourseService();

  @override
  void onInit() {
    super.onInit();

    // Get.parameters에서 courseId와 type 가져옴
    final String? idString = Get.parameters['id']; // 'id'는 String으로 받아옴
    final String? type = Get.parameters['type'];

    // idString을 int로 변환
    if (idString != null && type != null) {
      final int? id = int.tryParse(idString); // String을 int로 변환 시도
      if (id != null && type == 'official') {
        _fetchOfficialCourseDetail(id);
      } else if (id != null && type == 'user') {
        // TODO: 유저 코스 상세 정보 가져오기
      } else {
        log('Invalid ID or type');
      }
    }
  }

  Future<void> _fetchOfficialCourseDetail(int courseId) async {
    // 로딩 상태 true
    isLoading(true);

    try {
      final fetchedOfficialCourseDetail =
          await _courseService.getOfficialCourseDetail(courseId);

      // 코스 상세 정보 업데이트
      course.value = fetchedOfficialCourseDetail;
    } catch (e) {
      log('코스 상세 조회 중 문제 발생 : $e');
    } finally {
      isLoading(false);
    }
  }
}
