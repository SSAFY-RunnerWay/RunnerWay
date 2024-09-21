import 'dart:developer';
import 'package:frontend/controllers/main_controller.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  // 정렬 기준
  var sortCondition = '추천순'.obs;

  // 필터 상태 : 난이도와 거리 필터
  var selectedDifficulty = <int>[1, 2, 3].obs;
  var selectedLength = <dynamic>[3, 5, 10, 'over'].obs;

  // 난이도 라벨과 실제 값 매핑
  final difficultyLabels = {
    1: 'Lv. 1',
    2: 'Lv. 2',
    3: 'Lv. 3',
  };

  // 거리 라벨과 실제 값 매핑
  final lengthLabels = {
    3: '~ 3km',
    5: '3 ~ 5km',
    10: '5 ~10km',
    'over': '10km ~',
  };

  // 정렬 기준 업데이트
  void updateSortCondition(String newCondition) {
    log('$newCondition');

    // controller의 value 변경
    sortCondition.value = newCondition;
    // main controller로 변경된 정렬 기준 전달
    Get.find<MainController>().updateCourseList();
  }

  void updateFilterCondition() {
    Get.find<MainController>().updateCourseList();
  }
}
