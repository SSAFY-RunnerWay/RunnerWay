import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:frontend/models/running_map_model.dart';

class RunningMapController extends GetxController {
  StreamSubscription<Position>? _positionSubscription;
  Timer? _timer;
  DateTime? _startTime;
  var isLoading = true.obs;
  final value = RunningMapModel().obs;
  late GoogleMapController _mapController; // Google Map 컨트롤러 추가

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    log('초기화 시작');
    isLoading(true);
    await _requestLocationPermission();
    await _setInitialLocation();
    _startLocationUpdates();
    _startTimer();
    isLoading(false);
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }
  }

  Future<void> _setInitialLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng initialLocation = LatLng(position.latitude, position.longitude);
    value.update((val) {
      val?.myCurrentLocation = initialLocation;
      val?.mapCenter = initialLocation;
    });
  }

  void _startLocationUpdates() {
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((Position position) {
      _updateLocation(
          LatLng(position.latitude, position.longitude), position.speed);
      _moveCameraToPosition(position);
    });
  }

  void _moveCameraToPosition(Position position) {
    // 사용자의 위치로 카메라 이동
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        ),
      ),
    );
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
        double distance = Geolocator.distanceBetween(
          val.pointOnMap.last.latitude,
          val.pointOnMap.last.longitude,
          newLocation.latitude,
          newLocation.longitude,
        );
        val.totalDistance += distance;
      }

      val?.currentSpeed = speed;
      _calculatePace();

      val?.pointOnMap.add(newLocation);
      val?.mapCenter = newLocation;

      _updatePolyline();
    });
  }

  void _calculatePace() {
    value.update((val) {
      if (val != null && val.currentSpeed > 0) {
        double speedKmh = val.currentSpeed * 3.6; // m/s를 km/h로 변환
        double pace = 60 / speedKmh; // km/h를 분/km로 변환
        int minutes = pace.floor();
        int seconds = ((pace - minutes) * 60).round();
        val.currentPace = "$minutes'${seconds.toString().padLeft(2, '0')}''";
      } else {
        val?.currentPace = "0'00''";
      }
    });
  }

  void _updateElapsedTime() {
    if (_startTime != null) {
      value.update((val) {
        val?.elapsedTime = DateTime.now().difference(_startTime!);
        _logLocation(val?.mapCenter ?? const LatLng(0, 0));
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
      val?.polyline.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: val?.pointOnMap ?? [],
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller; // Google Map 컨트롤러 초기화
  }

  @override
  void onClose() {
    _positionSubscription?.cancel();
    _timer?.cancel();
    super.onClose();
  }
}
