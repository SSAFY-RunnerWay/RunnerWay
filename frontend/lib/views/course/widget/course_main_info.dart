import 'package:flutter/material.dart';

import '../../../widgets/button/course_running_button.dart';

class CourseMainInfo extends StatelessWidget {
  const CourseMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 코스 제목
          Text(
            '유성천 옆 산책로',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),

          // 코스 설명
          SizedBox(
            height: 8,
          ),
          Text(
            '노래 들으면서 유성천을 걸어보세요 !',
            style: TextStyle(
              fontSize: 18,
            ),
          ),

          // 코스 시작 주소
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/icons/picker.png',
                width: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '대전광역시 문화원로 80',
                style: TextStyle(fontSize: 14, color: Color(0xffA0A0A0)),
              ),
            ],
          ),

          SizedBox(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //참여자수
              Text(
                '12명 참여 중',
                style: TextStyle(
                  color: Color(0xff1EA6FC),
                ),
              ),

              // 러닝 버튼
              JoinRunningButton(
                onItemTapped: (p0) {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
