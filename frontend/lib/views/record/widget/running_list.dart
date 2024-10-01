import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/widgets/line.dart';
import 'package:frontend/models/course.dart';
import 'package:frontend/widgets/course/level_badge.dart';

class RunningCard extends StatelessWidget {
  // final Course course;
  // RunningCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO 러닝 상세 기록 페이지 이동
        Get.toNamed('');
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 18),
        color: Colors.white,
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          // course.name,
                          '유성천 옆 산책로',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            // LevelBadge(level: course.level),
                            Text('level1'),
                            SizedBox(width: 10),
                            // if (course.courseType == 'user')
                            Row(
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.chevron_right_rounded)],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '01:06:56 / ',
                      style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '10km / ',
                          style:
                              TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '6.22',
                          style:
                              TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                Line(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
