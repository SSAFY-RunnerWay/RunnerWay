import 'package:flutter/material.dart';

class CourseSubInfo extends StatelessWidget {
  const CourseSubInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 코스 상세 정보
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            '코스 상세 정보',
            style: TextStyle(fontSize: 16),
          ),
        )

        // TODO : 코스 보여주기

        // 기타 상세 코스 정보
      ],
    );
  }
}
