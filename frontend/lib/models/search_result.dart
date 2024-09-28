import 'course.dart';
import 'course_image.dart';

class SearchResult {
  final int courseId;
  final String name;
  final String address;
  final String? content;
  final int level;
  final String? courseType;
  final double lat;
  final double lng;
  final double? distance;
  final int? memberId;
  final String? memberNickname;
  final CourseImage? courseImage;

  SearchResult({
    required this.courseId,
    required this.name,
    required this.address,
    this.content,
    required this.level,
    this.courseType,
    required this.lat,
    required this.lng,
    this.distance,
    this.memberId,
    this.memberNickname,
    this.courseImage,
  });

  // Course 객체에서 필요한 필드만 추출하여 SearchResult로 변환
  factory SearchResult.fromCourse(Course course) {
    return SearchResult(
      courseId: course.courseId,
      name: course.name,
      address: course.address,
      content: course.content,
      level: course.level,
      courseType: course.courseType,
      lat: course.lat,
      lng: course.lng,
      distance: course.distance,
      memberId: course.memberId,
      memberNickname: course.memberNickname,
      courseImage: course.courseImage,
    );
  }

  @override
  String toString() {
    return 'CourseDTO(courseId: $courseId, name: $name, address: $address, '
        'content: $content, level: $level, courseType: $courseType, lat: $lat, '
        'lng: $lng, distance: $distance, memberId: $memberId, memberNickname: $memberNickname, '
        'courseImage: $courseImage)';
  }
}
