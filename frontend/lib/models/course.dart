class Course {
  final int courseId;
  final String name;
  final String address;
  final int count;
  final int level;
  final double courseLength;
  final CourseImage? courseImage; // courseImage nullable 설정

  Course({
    required this.courseId,
    required this.name,
    required this.address,
    required this.level,
    required this.count,
    required this.courseLength,
    this.courseImage,
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
      courseImage: json['courseImage'] != null
          ? CourseImage.fromJson(json['courseImage'])
          : null, // courseImage가 null일 경우 null 할당
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
