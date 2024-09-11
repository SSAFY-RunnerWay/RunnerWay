import 'package:flutter/material.dart';
import '../../widgets/map/location.dart'; // location.dart 파일을 import
import '../../widgets/map/geolocation.dart'; // geolocation.dart 파일을 import
import '../../widgets/map/map.dart'; // map.dart 파일을 import
import '../../widgets/map/line.dart'; // line.dart 파일을 import
import '../../widgets/map/google_map_polyline.dart'; // google_map_polyline.dart 파일을 import

class RunningView extends StatelessWidget {
  const RunningView({super.key});

  // location.dart 파일의 GeolocatorWidget 페이지로 이동하는 메소드
  void _navigateToLocation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const LocationPage()), // location.dart의 LocationPage 호출
    );
  }

  // geolocation.dart 파일의 GeolocatorWidget 페이지로 이동하는 메소드
  void _navigateToGeoLocation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const GeolocatorWidget()), // geolocation.dart의 GeolocatorWidget 호출
    );
  }

  // map.dart 파일의 MyMap 페이지로 이동하는 메소드
  void _navigateToMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyMap()), // map.dart의 MyMap 호출
    );
  }

  // line.dart 파일의 MyLine 페이지로 이동하는 메소드
  void _navigateToLine(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyLine()), // line.dart의 MyLine 호출
    );
  }

  void _navigateToGoogleMapPolyline(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const GoogleMapPolyline()), // Navigates to GoogleMapPolyline
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _navigateToLocation(context), // 위치 페이지로 이동
              child: const Text('Go to Location'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToGeoLocation(context), // 위치 페이지로 이동
              child: const Text('Go to GeoLocation'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToMap(context), // 맵 페이지로 이동
              child: const Text('Go to Map'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToLine(context), // 라인 페이지로 이동
              child: const Text('Go to Line'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToGoogleMapPolyline(context),
              // Navigates to the Polyline page
              child: const Text('Go to GoogleMapPolyline'),
            ),
          ],
        ),
      ),
    );
  }
}
