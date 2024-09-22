import 'package:flutter/material.dart';

import '../../../widgets/button/course_running_button.dart';

class CourseMainInfo extends StatelessWidget {
  final String name;
  final String content;
  final String address;
  final int count;

  const CourseMainInfo({
    required this.name,
    required this.content,
    required this.count,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 코스 제목
          Text(
            name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),

          // 코스 설명
          SizedBox(
            height: 8,
          ),
          Text(
            content,
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
                address,
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
                '${count}명 참여 중',
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
