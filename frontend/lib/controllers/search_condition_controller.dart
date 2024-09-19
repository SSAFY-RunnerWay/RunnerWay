import 'dart:developer';
import 'package:get/get.dart';

class SearchConditionController extends GetxController {
  // 정렬 기준
  var sortCondition = '인기순'.obs;

  // 현재 선택된 난이도를 관리 (초기값 'Lv. 1')
  var selectedDifficulty = <String>['Lv. 1', 'Lv. 2', 'Lv. 3'].obs;

  // 거리 필터
  var selectedDistance = <String>['~ 3km', '3 ~ 5km', '5 ~ 10km', '10km ~'].obs;

  // 정렬 기준 변경
  void updateSortCondition(String newCondition) {
    log('$newCondition');
    sortCondition.value = newCondition;
  }
}
