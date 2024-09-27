import 'dart:developer';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:frontend/models/running_map_model.dart';
import 'package:frontend/models/running_record_model.dart';
import 'package:frontend/services/running_service.dart';
import 'package:frontend/services/file_service.dart';

class RunningController extends GetxController {
  late final RunningService _runningService;
  late final FileService _fileService;
  StreamSubscription<Position>? _positionSubscription;
  Timer? _timer;
  DateTime? _startTime;
  var isLoading = true.obs;
  final value = RunningMapModel().obs;
  GoogleMapController? _mapController;
  final Set<Polyline> _polylines = {};
  List<LatLng> _realTimePath = []; // 실시간 경로 추적용

  RunningController() {
    _runningService = RunningService();
    _fileService = FileService();
    _loadPresetPath();
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    log('초기화 시작');
    isLoading(true);
    await _setInitialLocation();
    // 추후 초기화
    // await _fileService.resetJson();
    _startTimer();
    isLoading(false);
  }

  Future<void> _setInitialLocation() async {
    Position position = await _runningService.getCurrentPosition();
    LatLng initialLocation = LatLng(position.latitude, position.longitude);
    value.update((val) {
      val?.myCurrentLocation = initialLocation;
      val?.mapCenter = initialLocation;
    });
  }

  void _startLocationUpdates() {
    _positionSubscription =
        _runningService.getPositionStream().listen((Position position) {
      _updateLocation(
          LatLng(position.latitude, position.longitude), position.speed);
      _moveCameraToPosition(position);
    });
  }

  void _moveCameraToPosition(Position position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        ),
      ),
    );
    _logLocation(LatLng(position.latitude, position.longitude));
  }

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateElapsedTime();
    });
  }

  void _updateLocation(LatLng newLocation, double speed) {
    value.update((val) {
      if (val != null && val.pointOnMap.isNotEmpty) {
        double distance =
            _runningService.calculateDistance(val.pointOnMap.last, newLocation);
        val.totalDistance += distance;
      }

      val?.currentSpeed = speed;
      val?.currentPace = _runningService.calculatePace(speed);

      val?.pointOnMap.add(newLocation);
      val?.mapCenter = newLocation;

      _updatePolyline();
    });

    _saveRunningRecord(newLocation);
  }

  void _updateElapsedTime() {
    if (_startTime != null) {
      value.update((val) {
        val?.elapsedTime = _runningService.calculateElapsedTime(_startTime!);
      });
    }
  }

  void _logLocation(LatLng location) {
    value.update((val) {
      String logs = '위도: ${location.latitude}, 경도: ${location.longitude}, '
          '시간: ${val?.elapsedTime.inSeconds}초, '
          '총 거리: ${val?.totalDistance.toStringAsFixed(2)} m, '
          '페이스: ${val?.currentPace} '
          '속도: ${val?.currentSpeed}';
      log(logs);
    });
  }

  void _updatePolyline() {
    value.update((val) {
      val?.polyline.clear();
      val?.polyline
          .add(_runningService.createRealTimePolyline(val.pointOnMap ?? []));
    });
  }

  void _saveRunningRecord(LatLng location) {
    RunningRecord record = RunningRecord(
      latitude: location.latitude,
      longitude: location.longitude,
      timestamp: DateTime.now(),
    );
    _fileService.appendRunningRecord(record);
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _startLocationUpdates();
  }

  Future<void> endRunning() async {
    _positionSubscription?.cancel();
    _timer?.cancel();

    try {
      // Service layer handles the main logic
      final recordId = await _runningService.endRunningSession();
      // Transition to result screen with recordId
      Get.toNamed('/running-result', arguments: recordId);
    } catch (e) {
      // Error handling (showing snackbar)
      Get.snackbar('Error', 'Failed to end running session');
    }
  }

  Future<void> _loadPresetPath() async {
    final presetPolyline = await _runningService.loadPresetPath();
    if (presetPolyline != null) {
      _polylines.add(presetPolyline);
      update(); // 상태 업데이트
    }
  }

  Future<void> endRunning2() async {
    _positionSubscription?.cancel();
    _timer?.cancel();

    try {
      // 임시 recordId 생성 (현재 시간을 사용)
      final tempRecordId = 'tmp_${DateTime.now().millisecondsSinceEpoch}';

      // tmp.json 파일을 tempRecordId.json으로 이름 변경
      await _fileService.renameFile2(tempRecordId);

      print('Running session ended. Data saved as: $tempRecordId.json');

      // 사용자에게 저장 완료 알림
      // Get.snackbar(
      //   'Success',
      //   'Running record saved locally',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 5),
      // );

      // 결과 화면으로 이동
      // Get.toNamed('/running-result', arguments: tempRecordId);
    } catch (e) {
      print('Error ending running session: $e');
      // 에러 발생 시 사용자에게 알림
      Get.snackbar(
        'Error',
        'Failed to save running record',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    _positionSubscription?.cancel();
    _timer?.cancel();
    _mapController?.dispose();
    super.onClose();
  }
}
