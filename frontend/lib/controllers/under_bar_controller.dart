import 'package:get/get.dart';

class UnderBarController extends GetxController {
  // Get.fine 대신 클래스명 사용 가능
  static UnderBarController get to => Get.find();

  // 현재 선택된 탭 인덱스를 관리할 변수
  var selectedIndex = 0.obs;

  // 탭 변경 메서드
  void changeTabIndex(int index) {
    if (index >= 0 && index < 4) {
      selectedIndex.value = index;
    }
  }
}
