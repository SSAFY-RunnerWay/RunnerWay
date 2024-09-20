import 'package:flutter/material.dart';
import 'package:frontend/models/course/course.dart';

class CourseCard extends StatelessWidget {
  // final Course course;
  //
  // CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 코스 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // TODO: API 데이터 연결
            // child: Image.network(src),
            child: Image.asset(
              'assets/images/temp/course1.png',
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
                      '유성천 옆 산책로',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    // 거리 정보
                    Text(
                      '2.8km',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA0A0A0),
                      ),
                    ),
                  ],
                ),

                // level 뱃지
                Container(
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      color: Color(0xffFFF7F7),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    'Lv. 3',
                    style: TextStyle(
                      color: Color(0xffF44237),
                      fontSize: 12,
                    ),
                  ),
                ),

                // 위치 정보 및 참여자수 정보
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Image.asset(
                        'assets/images/course/picker.png',
                        width: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '대전 광역시',
                        style: TextStyle(
                          color: Color(0xffA0A0A0),
                          fontSize: 14,
                        ),
                      )
                    ]),
                    Text(
                      '128명 참여 중',
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
    );
  }
}
