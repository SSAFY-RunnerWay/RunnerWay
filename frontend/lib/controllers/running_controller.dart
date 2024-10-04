import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/course_controller.dart';
import 'package:frontend/models/ranking_upload_model.dart';
import 'package:frontend/services/course_service.dart';
import 'package:frontend/utils/s3_image_upload.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/models/running_map_model.dart';
import 'package:frontend/models/running_record_model.dart';
import 'package:frontend/services/running_service.dart';
import 'package:frontend/services/file_service.dart';
import 'package:path_provider/path_provider.dart';

class RunningController extends GetxController {
  late final RunningService _runningService;
  late final CourseService _courseService = CourseService();
  late final FileService _fileService;
  StreamSubscription<Position>? _positionSubscription;
  Timer? _timer;
  DateTime? startTime;
  var isLoading = true.obs;
  final value = RunningMapModel().obs;
  GoogleMapController? _mapController;

  var isOfficialRun = false.obs;
  var isCompetitionMode = false.obs;
  var isRun = true.obs;
  List<RunningRecord> competitionRecords = [];
  int competitionRecordIndex = 0;
  Timer? competitionTimer;

  RunningRecord? _lastCompetitionRecord;

  RunningRecord? _currentRecord;
  RunningRecord? _nextRecord;
  int _currentRecordIndex = 0;

  String? type;
  String? courseid;
  String? varid; // type이 free이고 대결 시 recordid이고 나머지 경우 rankid
  final typeKorean = ''.obs;

  LatLng? _departurePoint; // 시작지점 좌표를 저장하는 변수
  LatLng? _destinationPoint; // 도착지점 좌표를 저장하는 변수

  RunningController() {
    _runningService = RunningService();
    _fileService = FileService();
  }

  @override
  void onInit() {
    super.onInit();

    // route에서 파라미터 가져오기
    type = Get.parameters['type'];
    courseid = Get.parameters['courseid'];
    varid = Get.parameters['varid'];

    initialize();
  }

  Future<void> initialize() async {
    dev.log('초기화 시작');
    await _fileService.resetJson();
    if (varid != '0') {
      isCompetitionMode.value = true;
      dev.log('대결 상대: $varid');
    }

    if (type == 'free') {
      dev.log('Free running mode initialized.');
    } else if (type == 'official') {
      isOfficialRun.value = true;
      await loadSavedPath();
      await _checkIfStartLocationIsValid(); // 경로의 시작 위치 확인
      dev.log('Official running mode initialized with courseid: $courseid');
    } else if (type == 'user') {
      await loadSavedPath();
      await _checkIfStartLocationIsValid(); // 경로의 시작 위치 확인
      dev.log('User running mode initialized with courseid: $courseid');
    }

    dev.log('type: ${type}, courseid: ${courseid}, varid: ${varid}');

    isLoading(true);
    await _setInitialLocation();
    getRunTypeText();
    isLoading(false);
  }

  // TODO
  // main인 running_view에서 사용하지 않고 예전 코드임
  Future<void> startRun(
      {bool isOfficial = false, bool isCompetition = false}) async {
    isOfficialRun.value = isOfficial;
    isCompetitionMode.value = isCompetition;
    if (isCompetitionMode.value) {
      await loadCompetitionRecords();
      startCompetitionMode();
    }
    _startLocationUpdates();
    _startTimer();
  }

  Future<void> startRun2() async {
    if (isOfficialRun.value) {
      await loadSavedPath();
    }
    if (isCompetitionMode.value) {
      if (type == 'official' || type == 'user') {
        await loadCompetitionRecords();
      } else {
        await loadCompetitionRecordsFromLocal();
      }
      startCompetitionMode();
    }
    _startLocationUpdates();
    _startTimer();
  }

  void getRunTypeText() {
    if (type == 'free') {
      typeKorean.value = '자유';
    } else if (type == 'official') {
      typeKorean.value = '공식';
    } else if (type == 'user') {
      typeKorean.value = '유저';
    } else {
      typeKorean.value = '자유';
    }
  }

  // TODO
  // 시작 위치 판단해서 시작 못하게 하지만 3이라는 숫자 보고 뒤로가게 해 둠
  Future<void> _checkIfStartLocationIsValid() async {
    Position currentPosition = await _runningService.getCurrentPosition();
    LatLng currentLocation =
        LatLng(currentPosition.latitude, currentPosition.longitude);

    dev.log('현재 위치: ${currentLocation}');
    dev.log('시작 위치: ${_departurePoint}');

    if (_departurePoint != null) {
      LatLng startLocation = _departurePoint!;

      // 현재 위치와 경로 시작점의 거리 계산
      double distanceToStart =
          _runningService.calculateDistance(currentLocation, startLocation);
      if (distanceToStart > 50.0) {
        // 50m 이내가 아닌 경우 사용자에게 알림 처리
        Get.back();

        // TODO
        // snackbar 안 떠서 어케 하지
        Get.snackbar(
          '알림',
          '현재 위치가 경로의 시작점과 너무 멉니다. 경로 시작점에 가까워지세요.',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        Get.back();
      } else {
        isRun.value = true; // 10m 이내면 러닝을 시작할 수 있음
      }
    }
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
    startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateElapsedTime();
    });
  }

  void _updateLocation(LatLng newLocation, double speed) {
    value.update((val) {
      if (val != null && val.pointOnMap.isNotEmpty) {
        double distance = (_runningService.calculateDistance(
                val.pointOnMap.last, newLocation)) /
            1000;

        dev.log('거리 차 : ${distance}');
        val.totalDistance += distance;
        dev.log('현재 간 거리: ${val.totalDistance}');
      }

      val?.currentSpeed = speed;
      val?.currentPace = _runningService.calculatePace(speed);

      val?.pointOnMap.add(newLocation);
      val?.mapCenter = newLocation;

      _updateRealTimePolyline();
    });

    _checkIfArrivedAtDestination(newLocation);
    _saveRunningRecord(newLocation);
  }

  void _updateElapsedTime() {
    if (startTime != null) {
      value.update((val) {
        val?.elapsedTime = _runningService.calculateElapsedTime(startTime!);
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
      dev.log(logs);
    });
  }

  void _updateRealTimePolyline() {
    value.update((val) {
      Polyline realTimePolyline =
          _runningService.createRealTimePolyline(val?.pointOnMap ?? []);
      val?.polyline.removeWhere(
          (polyline) => polyline.polylineId.value == 'realTimePath');
      val?.polyline.add(realTimePolyline);
    });
  }

  // TODO
  // view 시작 시 method 순서 변경해서 load하게 해야 함
  Future<void> loadSavedPath() async {
    // TODO
    // 서비스로 이동 시켜야 함
    if (isOfficialRun.value) {
      // if (type == 'official') {
      List<LatLng> savedPath = await _courseService
          .getCoursePoints(int.tryParse(courseid ?? '') ?? 0);

      if (savedPath.isNotEmpty) {
        _departurePoint = savedPath.first; // 시작지점 설정
        _destinationPoint = savedPath.last; // 도착지점 설정
      }

      Polyline savedPathPolyline = Polyline(
        polylineId: PolylineId('savedPath'),
        color: Colors.red, // 저장된 경로는 빨간색으로 표시
        width: 5,
        points: savedPath,
      );
      value.update((val) {
        val?.polyline.add(savedPathPolyline);
      });
    }
    // if (isOfficialRun.value) {
    //   Polyline savedPathPolyline = await _runningService
    //       .createSavedPathPolyline('walking_log_noeun_yuseong_3_seconds');
    //   value.update((val) {
    //     val?.polyline.add(savedPathPolyline);
    //   });
    // }
  }

  Future<void> loadCompetitionRecords() async {
    // TODO
    // 자유 코스에서 대결일 경우 내 로그에서 데이터 가져오게 해야 함

    competitionRecords = await _runningService
        .readSavedRunningRecordLog(int.parse(varid ?? '0'));

    dev.log('competitionrecords 결과값: ${competitionRecords}');

    competitionRecordIndex = 0;
  }

  Future<void> loadCompetitionRecordsFromLocal() async {
    competitionRecords =
        await _runningService.readSavedRunningLocalLog(int.parse(varid ?? '0'));

    dev.log('competitionrecords 결과값: ${competitionRecords}');

    competitionRecordIndex = 0;
  }

  void _checkIfArrivedAtDestination(LatLng currentLocation) {
    if (_destinationPoint != null) {
      // 도착지점과 현재 위치의 거리를 계산 (미터 단위)
      double distanceToDestination = _runningService.calculateDistance(
          currentLocation, _destinationPoint!);

      if (distanceToDestination <= 10.0) {
        // 10m 이내 도착 시 러닝 종료
        dev.log('도착지점에 도착했습니다. 러닝을 종료합니다.');
        endRunning2();
        isRun.value = false;
      }
    }
  }

  void startCompetitionMode() {
    competitionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentRecordIndex < competitionRecords.length - 1) {
        updateCompetitionMarker();
      } else {
        competitionTimer?.cancel();
      }
    });
  }

  void updateCompetitionMarker() {
    if (competitionRecords.isEmpty ||
        value.value.elapsedTime == Duration.zero) {
      return;
    }

    int currentTimeSeconds = value.value.elapsedTime.inSeconds;

    // 현재 시간에 해당하는 기록과 다음 기록을 찾음
    while (_currentRecordIndex < competitionRecords.length - 1 &&
        competitionRecords[_currentRecordIndex + 1].elapsedTime.inSeconds <=
            currentTimeSeconds) {
      _currentRecordIndex++;
    }

    _currentRecord = competitionRecords[_currentRecordIndex];
    _nextRecord = _currentRecordIndex < competitionRecords.length - 1
        ? competitionRecords[_currentRecordIndex + 1]
        : null;

    if (_nextRecord == null) {
      // 마지막 지점에 도달했으면 현재 위치로 설정
      return;
    }

    // 현재 시간과 다음 기록 시간 사이의 경과 시간 계산 (예: 3초)
    int segmentTime = _nextRecord!.elapsedTime.inSeconds -
        _currentRecord!.elapsedTime.inSeconds;
    int elapsedInSegment =
        currentTimeSeconds - _currentRecord!.elapsedTime.inSeconds;

    // 이동할 위치 계산
    double progress = elapsedInSegment / segmentTime; // 매 1초마다 비율을 계산
    progress = min(1.0, max(0.0, progress)); // progress가 0~1 사이로 보정

    // 보정된 위치 계산 (두 위치 사이를 progress 비율로 보정)
    LatLng interpolatedPosition = LatLng(
      _currentRecord!.latitude +
          (_nextRecord!.latitude - _currentRecord!.latitude) * progress,
      _currentRecord!.longitude +
          (_nextRecord!.longitude - _currentRecord!.longitude) * progress,
    );

    // 보정된 위치로 마커 업데이트
    value.update((val) {
      val?.markers
          .removeWhere((marker) => marker.markerId.value == 'competition');
      val?.markers.add(
        Marker(
          markerId: MarkerId('competition'),
          position: interpolatedPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        ),
      );
    });
  }

  void _saveRunningRecord(LatLng location) {
    if (startTime == null) return; // 시작 시간이 없으면 저장하지 않음

    RunningRecord record = RunningRecord(
      latitude: location.latitude,
      longitude: location.longitude,
      elapsedTime: DateTime.now().difference(startTime!),
    );
    _fileService.appendRunningRecord(record, 'tmp');
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> endRunning() async {
    _positionSubscription?.cancel();
    _timer?.cancel();
    competitionTimer?.cancel();

    try {
      final recordId = await _runningService.endRunningSession();
      Get.toNamed('/running-result', arguments: recordId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to end running session');
    }
  }

  Future<void> endRunning2() async {
    _positionSubscription?.cancel();
    _timer?.cancel();
    competitionTimer?.cancel();

    final score =
        value.value.elapsedTime.toString().split('.').first.padLeft(8, "0");

    // 대결 여부 확인 후
    if (varid != '0') {
      //대결에 따른 결과 페이지로 이동 시켜야 해
    }
    dev.log('최종 시간: ${score}');
    // 랭킹 등록 가능여부 판단 해야 함
    final response = await _runningService.getRegistRanking(
        int.parse(courseid ?? '0'), score);
    dev.log('랭커 등록 여부: ${response}');

    if (response) {
      // s3에 업로드
      final directory = await getApplicationDocumentsDirectory();
      final File tmpFile = File('${directory.path}/tmp.json');
      final url = await S3ImageUpload().uploadRankingLog(tmpFile);
      dev.log('url: ${url}');
      RankingUploadModel model = RankingUploadModel(
          courseId: int.parse(courseid ?? '0'), score: score, logPath: url);
      // 랭킹 등록
      final response = await _runningService.registRanking(model);
      dev.log('랭킹 등록 결과값: ${response}');
    }
  }

  Future<void> endRunningByButton() async {
    _positionSubscription?.cancel();
    _timer?.cancel();
    competitionTimer?.cancel();

    dev.log('버튼으로 중지');
    try {
      // 자유코스로 변경 및 코스, 상대방 초기화
      type = '자유';
      typeKorean.value = '자유';
      courseid = '0';
      varid = '0';
    } catch (e) {
      dev.log('Error ending running session: $e');
      Get.snackbar(
        'Error',
        'Failed to save running record',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  Duration get currentCompetitionTime {
    return _lastCompetitionRecord?.elapsedTime ?? Duration.zero;
  }

  @override
  void onClose() {
    _positionSubscription?.cancel();
    _timer?.cancel();
    competitionTimer?.cancel();
    _mapController?.dispose();
    super.onClose();
  }
}