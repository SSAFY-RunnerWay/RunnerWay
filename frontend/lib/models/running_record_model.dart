class RunningRecord {
  final double latitude;
  final double longitude;
  final Duration elapsedTime;

  RunningRecord({
    required this.latitude,
    required this.longitude,
    required this.elapsedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'elapsedTime': elapsedTime.inSeconds, // 초 단위로 저장
    };
  }

  factory RunningRecord.fromJson(Map<String, dynamic> json) {
    return RunningRecord(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elapsedTime: Duration(seconds: json['elapsedTime']),
    );
  }
}
