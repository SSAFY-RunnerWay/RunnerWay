import 'dart:developer';

import 'package:get/get.dart';

class SearchConditionController extends GetxController {
  // 정렬 기준
  var sortCondition = '인기순'.obs;

  // 현재 선택된 난이도를 관리 (초기값 'Lv. 1')
  var selectedDifficulty = 'Lv. 1'.obs;

  // 거리 필터
  var distances = {
    '~ 3km': true,
    '3km ~ 5km': false,
    '5km ~ 10km': false,
    '10km ~': false,
  }.obs;

  // 정렬 기준 변경
  void updateSortCondition(String newCondition) {
    log('$newCondition');

    sortCondition.value = newCondition;
  }

  // 난이도 선택 업데이트
  void updateDifficulty(String newDifficulty) {
    selectedDifficulty.value = newDifficulty;
  }

  // 거리 업데이트
  void toggleDistance(String distance) {
    distances[distance] = !(distances[distance] ?? false);
  }
}
