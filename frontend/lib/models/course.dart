class Course {
  final int courseId;
  final String name;
  final String address;
  final String? content; // content nullable 설정
  final int count;
  final int level;
  final double courseLength;
  final double lat;
  final double lng;
  final double? distance;
  final double? averageSlope; // averageSlope nullable 설정
  final String? averageTime; // averageTime nullable 설정
  final double? averageCalorie; // averageCalorie nullable 설정
  final String? courseType; // courseType nullable 설정
  final CourseImage? courseImage;

  Course({
    required this.courseId,
    required this.name,
    required this.address,
    this.content, // nullable 설정
    required this.level,
    required this.count,
    required this.courseLength,
    required this.lat,
    required this.lng,
    this.courseImage,
    this.distance,
    this.averageSlope, // nullable 설정
    this.averageTime, // nullable 설정
    this.averageCalorie, // nullable 설정
    this.courseType, // nullable 설정
  });

  // JSON 데이터를 파싱하여 Course 객체 생성
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'],
      name: json['name'],
      address: json['address'],
      content: json['content'], // nullable field
      level: json['level'],
      count: json['count'],
      courseLength: (json['courseLength'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      courseImage: json['courseImage'] != null
          ? CourseImage.fromJson(json['courseImage'])
          : null, // courseImage가 null일 경우 null 할당
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null, // distance도 json에서 변환 가능
      averageSlope: json['averageSlope'] != null
          ? (json['averageSlope'] as num).toDouble()
          : null, // averageSlope nullable 설정
      averageTime: json['averageTime'], // nullable 설정
      averageCalorie: json['averageCalorie'] != null
          ? (json['averageCalorie'] as num).toDouble()
          : null, // nullable 설정
      courseType: json['courseType'], // nullable 설정
    );
  }

  // copyWith 메서드
  Course copyWith({
    int? courseId,
    String? name,
    String? address,
    String? content,
    int? count,
    int? level,
    double? courseLength,
    double? lat,
    double? lng,
    double? distance,
    double? averageSlope,
    String? averageTime,
    double? averageCalorie,
    String? courseType,
    CourseImage? courseImage,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      address: address ?? this.address,
      content: content ?? this.content,
      count: count ?? this.count,
      level: level ?? this.level,
      courseLength: courseLength ?? this.courseLength,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      averageSlope: averageSlope ?? this.averageSlope,
      averageTime: averageTime ?? this.averageTime,
      averageCalorie: averageCalorie ?? this.averageCalorie,
      courseType: courseType ?? this.courseType,
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
