class Course {
  final String name;
  final String imageUrl;
  final double distance;
  final String level;
  final String location;
  final int participants;

  Course({
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.level,
    required this.location,
    required this.participants,
  });

  // JSON 데이터를 파싱하여 Course 객체 생성
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      imageUrl: json['imageUrl'],
      distance: json['distance'].toDouble(),
      level: json['level'],
      location: json['location'],
      participants: json['participants'],
    );
  }
}
