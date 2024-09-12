import 'package:flutter/material.dart';

class JoinRunningButton extends StatelessWidget {
  const JoinRunningButton({super.key, required this.onItemTapped});

  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(0),
      child: Container(
        width: 145,
        height: 42,
        decoration: BoxDecoration(
          color: Color(0xFF1C1516),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Row 내 아이템을 중앙에 정렬
          children: [
            Image.asset(
              'assets/icons/runShoe.png', // 파일 경로
              width: 22, // 이미지 크기 조절
              height: 21,
            ),
            SizedBox(width: 9),
            Text(
              '이 코스로 러닝',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
