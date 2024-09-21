import 'package:flutter/material.dart';
import 'package:frontend/models/course.dart';
import 'package:frontend/widgets/course/level_badge.dart';
import 'package:get/get.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/course/${course.courseId}');
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        color: Colors.white,
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 코스 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // TODO: 이미지 테스트
              // child: Image.network(src),
              child: Image.asset(
                'assets/images/temp/course4.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            // 코스 이미지와 내용 사이 여백
            SizedBox(
              width: 15,
            ),

            // 코스 내용
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 코스 제목과 거리 정보
                  Row(
                    children: [
                      // 코스 제목
                      Text(
                        course.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      // 거리 정보
                      Text(
                        '${(course.courseLength * 10).round() / 10} km',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xffA0A0A0),
                        ),
                      ),
                    ],
                  ),

                  // level 뱃지
                  LevelBadge(level: course.level),

                  // 위치 정보 및 참여자수 정보
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Image.asset(
                          'assets/icons/picker.png',
                          width: 14,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${course.address}',
                          style: TextStyle(
                            color: Color(0xffA0A0A0),
                            fontSize: 14,
                          ),
                        )
                      ]),

                      // 1명 이상 참여 중인 경우에만 참여자 수 보이도록 조건 처리
                      if (course.count > 0)
                        Text(
                          '${course.count}명 참여 중',
                          style: TextStyle(
                            color: Color(0xff1EA6FC),
                            fontSize: 14,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
