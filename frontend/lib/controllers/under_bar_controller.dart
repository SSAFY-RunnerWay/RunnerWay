import 'package:flutter/material.dart';
import 'package:frontend/views/main/main_view.dart';
import 'package:frontend/views/runnerPick/runner_pick_view.dart';
import 'package:get/get.dart';

class UnderBarController extends GetxController {
  // 현재 선택된 탭 인덱스를 관리할 변수
  var selectedIndex = 0.obs;

  // 탭 변경 메서드
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    // 페이지를 GetX 라우팅을 이용해 전환
    switch (index) {
      case 0:
        Get.offNamed('/main');
        break;
      case 1:
        Get.offNamed('/runner-pick');
        break;
      case 2:
        Get.offNamed('/record');
        break;
      case 3:
        Get.offNamed('/profile');
        break;
      default:
        Get.offNamed('/main');
        break;
    }
  }

  getCurrentPage() {
    switch (selectedIndex.value) {
      case 0:
        return MainView();
      case 1:
        return RunnerPickView();
    }
  }
}
