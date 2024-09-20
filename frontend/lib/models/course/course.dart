class Course {
  final String title;
  final String imageUrl;
  final double distance;
  final String level;
  final String location;
  final int participants;

  Course({
    required this.title,
    required this.imageUrl,
    required this.distance,
    required this.level,
    required this.location,
    required this.participants,
  });

  // JSON 데이터를 파싱하여 Course 객체 생성
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      imageUrl: json['imageUrl'],
      distance: json['distance'].toDouble(),
      level: json['level'],
      location: json['location'],
      participants: json['participants'],
    );
  }
}
