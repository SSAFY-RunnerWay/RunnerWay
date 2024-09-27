import 'package:intl/intl.dart';

class RunningRecord {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  RunningRecord({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(timestamp.toUtc()),
    };
  }
}
