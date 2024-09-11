import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolyline extends StatefulWidget {
  const GoogleMapPolyline({super.key});

  @override
  State<GoogleMapPolyline> createState() => _GoogleMapPolylineState();
}

class _GoogleMapPolylineState extends State<GoogleMapPolyline> {
  LatLng myCurrentLocation = const LatLng(36.35665, 127.321678);

  Set<Marker> markers = {};

  final Set<Polyline> _polyline = {};

  List<LatLng> pointOnMap = [
    const LatLng(36.3550, 127.2983),
    const LatLng(36.358300, 127.345056),
    // const LatLng(28.591831, 81.616543),
    // const LatLng(28.600745, 81.613678),
    // const LatLng(28.591831, 81.616543),
    // const LatLng(28.600792, 81.596041)

    // double _originLatitude = 36.3550, _originLongitude = 127.2983;
    // double _destLatitude = 36.358300, _destLongitude = 127.345056;
  ];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < pointOnMap.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: pointOnMap[i],
          infoWindow: const InfoWindow(
            title: " Place around my Country",
            snippet: " So Beautiful ",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {
        _polyline.add(
          Polyline(
            polylineId: const PolylineId("Id"),
            points: pointOnMap,
            color: Colors.blue,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polylines: _polyline,
        myLocationButtonEnabled: false,
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: myCurrentLocation,
          zoom: 13,
        ),
      ),
    );
  }
}