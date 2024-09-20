import 'dart:developer';
import 'package:frontend/controllers/main_controller.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  // 정렬 기준
  var sortCondition = '추천순'.obs;

  // 필터 상태 : 난이도와 거리 필터
  var selectedDifficulty = <String>['Lv. 1', 'Lv. 2', 'Lv. 3'].obs;
  var selectedDistance = <String>['~ 3km', '3 ~ 5km', '5 ~ 10km', '10km ~'].obs;

  // 정렬 기준 업데이트
  void updateSortCondition(String newCondition) {
    log('$newCondition');

    // controller의 value 변경
    sortCondition.value = newCondition;
    // main controller로 변경된 정렬 기준 전달
    Get.find<MainController>().updateCourseList();
  }
}
