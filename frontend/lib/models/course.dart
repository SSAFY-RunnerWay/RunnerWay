class Course {
  final int courseId;
  final String name;
  final String address;
  final int count;
  final int level;
  final double courseLength;
  final double lat;
  final double lng;
  final double? distance;
  final CourseImage? courseImage; // courseImage nullable 설정

  Course({
    required this.courseId,
    required this.name,
    required this.address,
    required this.level,
    required this.count,
    required this.courseLength,
    required this.lat,
    required this.lng,
    this.courseImage,
    this.distance,
  });

  // JSON 데이터를 파싱하여 Course 객체 생성
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'],
      name: json['name'],
      address: json['address'],
      level: json['level'],
      count: json['count'],
      courseLength: (json['courseLength'] as num).toDouble(), // double로 변환
      lat: (json['lat'] as num).toDouble(), // double로 변환
      lng: (json['lng'] as num).toDouble(), // double로 변환
      courseImage: json['courseImage'] != null
          ? CourseImage.fromJson(json['courseImage'])
          : null, // courseImage가 null일 경우 null 할당
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null, // distance도 json에서 변환 가능
    );
  }

  // copyWith 메서드
  Course copyWith({
    int? courseId,
    String? name,
    String? address,
    int? count,
    int? level,
    double? courseLength,
    double? lat,
    double? lng,
    double? distance, // distance도 수정 가능
    CourseImage? courseImage,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      address: address ?? this.address,
      count: count ?? this.count,
      level: level ?? this.level,
      courseLength: courseLength ?? this.courseLength,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance, // distance 복사
      courseImage: courseImage ?? this.courseImage,
    );
  }
}

class CourseImage {
  final int courseId;
  final String url;
  final String path;

  CourseImage({
    required this.courseId,
    required this.url,
    required this.path,
  });

  // JSON 데이터를 파싱하여 CourseImage 객체 생성
  factory CourseImage.fromJson(Map<String, dynamic> json) {
    return CourseImage(
      courseId: json['courseId'] as int,
      url: json['url'] as String,
      path: json['path'] as String,
    );
  }
}
