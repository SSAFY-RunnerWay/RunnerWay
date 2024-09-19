import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  final String name;
  final String time;
  final String imagePath;
  final int rank;

  const RankingCard({
    Key? key,
    required this.name,
    required this.time,
    required this.imagePath,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imagePath),
              ),
              if (rank <= 3) // 상위 3명만 뱃지 표시
                Positioned(
                  right: 0,
                  bottom: 0, // 뱃지 위치 조정
                  child: _buildBadge(rank),
                ),
            ],
          ),
          SizedBox(width: 10), // 이미지와 텍스트 사이 간격
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(time),
            ],
          ),
        ],
      ),
    );
  }

  // 순위에 따라 뱃지를 만듭니다.
  Widget _buildBadge(int rank) {
    Color badgeColor;
    switch (rank) {
      case 1:
        badgeColor = Colors.amber; // 1등 금메달
        break;
      case 2:
        badgeColor = Colors.grey; // 2등 은메달
        break;
      case 3:
        badgeColor = Color(0xffbf8970); // 3등 동메달
        break;
      default:
        badgeColor = Colors.transparent; // 4등 이후는 뱃지 없음
    }
    return CircleAvatar(
      backgroundColor: badgeColor,
      radius: 15, // 뱃지 크기
      child: Text(
        '$rank',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
