import 'package:flutter/material.dart';
import 'package:frontend/widgets/button/course_running_button.dart';
import 'package:frontend/widgets/button/wide_button.dart';

class RecordView extends StatelessWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙에 정렬
          children: [
            const Text('Record view goes here'),
            const SizedBox(height: 20),
            JoinRunningButton(
              onItemTapped: (index) {
                print("Running button tapped: $index");
              },
            ),
            const SizedBox(height: 20), // 간격 추가
            WideButton(
              text: "종료", // 버튼 텍스트
              bgColor: Color(0xFF1C1516), // 배경 색상: 검정
              textColor: Colors.white,
              width: 208,
              height: 40,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              onItemTapped: (index) {
                print("wide button click");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            WideButton(
                text: "취소",
                bgColor: Colors.white,
                bdColor: Color(0xFFE8E8E8),
                textColor: Color(0xFF1C1516),
                width: 208,
                height: 40,
                onItemTapped: (index) {
                  print("취소");
                })
          ],
        ),
      ),
    );
  }
}
