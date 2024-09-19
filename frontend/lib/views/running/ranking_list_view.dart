import 'package:flutter/material.dart';
import '../../widgets/ranking_card.dart';

class RankingListView extends StatelessWidget {
  // 사용자 데이터를 여기에 추가합니다.
  final List<Map<String, String>> users = [
    {
      'name': '백만불짜리 다리',
      'time': '4\' 00\'\'',
      'image': 'assets/profile1.png',
    },
    {
      'name': '엄마 나 2등했어 !!!',
      'time': '5\' 00\'\'',
      'image': 'assets/profile2.png',
    },
    {
      'name': '소연2',
      'time': '5\' 10\'\'',
      'image': 'assets/profile3.png',
    },
    {
      'name': '소연3',
      'time': '5\' 12\'\'',
      'image': 'assets/profile4.png',
    },
    {
      'name': '소연4',
      'time': '5\' 20\'\'',
      'image': 'assets/profile5.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ranking List')),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return RankingCard(
            name: user['name']!,
            time: user['time']!,
            imagePath: user['image']!,
            rank: index + 1,
          );
        },
      ),
    );
  }
}
