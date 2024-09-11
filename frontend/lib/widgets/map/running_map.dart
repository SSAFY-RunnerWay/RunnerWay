import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RunningMap extends StatefulWidget {
  const RunningMap({super.key});

  @override
  State<RunningMap> createState() => _RunningMapState();
}

class _RunningMapState extends State<RunningMap> {
  // 현재 위치를 저장할 변수
  LatLng? myCurrentLocation;
  // 초기 지도 중심 좌표
  LatLng? mapCenter;

  Set<Marker> markers = {};
  final Set<Polyline> _polyline = {};

  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  bool isLocationEnabled = false;

  List<LatLng> pointOnMap = [];

  @override
  void initState() {
    super.initState();
    _locateMe(); // 페이지 진입 시 위치 권한 요청 및 위치 추적 시작
    // _setPolylineAndMarkers();
  }

  void _updatePolyline() {
    setState(() {
      _polyline.clear();
      _polyline.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: pointOnMap,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  // 위치 권한 요청 및 위치 추적 함수
  Future<void> _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isLocationEnabled = true;
    });

    // 위치가 변경될 때마다 현재 위치 저장 및 마커 업데이트
    location.onLocationChanged.listen((res) {
      setState(() {
        myCurrentLocation = LatLng(res.latitude!, res.longitude!);
        mapCenter = myCurrentLocation;

        // 현재 위치에 마커 추가
        // markers.add(
        //   Marker(
        //     markerId: const MarkerId("current"),
        //     position: myCurrentLocation!,
        //     infoWindow: const InfoWindow(
        //       title: "My Current Location",
        //     ),
        //     icon: BitmapDescriptor.defaultMarkerWithHue(
        //         BitmapDescriptor.hueGreen),
        //   ),
        // );
      });
    });

    location.onLocationChanged.listen((res) {
      setState(() {
        myCurrentLocation = LatLng(res.latitude!, res.longitude!);
        mapCenter = myCurrentLocation;

        // 새로운 위치를 경로 리스트에 추가
        pointOnMap.add(myCurrentLocation!);

        // 폴리라인 업데이트
        _updatePolyline();
      });
    });
  }

  // 지도에 마커 및 폴리라인 설정
  void _setPolylineAndMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId("start"),
        position: pointOnMap.first,
        infoWindow: const InfoWindow(
          title: "Start Point",
          snippet: "This is the start point.",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId("end"),
        position: pointOnMap.last,
        infoWindow: const InfoWindow(
          title: "End Point",
          snippet: "This is the end point.",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    setState(() {
      _polyline.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: pointOnMap,
          color: Colors.blue,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Running Map"),
      // ),
      body: GoogleMap(
        polylines: _polyline,
        myLocationEnabled: isLocationEnabled,
        initialCameraPosition: CameraPosition(
          target: mapCenter ?? const LatLng(36.35665, 127.321678),
          zoom: 13,
        ),
      ),
    );
  }
}
