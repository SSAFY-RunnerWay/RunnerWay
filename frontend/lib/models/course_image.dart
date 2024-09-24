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
