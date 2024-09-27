import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  // 현재 위치 정보를 관리
  var currentPosition = Rxn<Position>();
}
