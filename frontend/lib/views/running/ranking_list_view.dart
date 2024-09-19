import 'package:flutter/material.dart';
import '../../widgets/ranking_card.dart'; // RankingCard 위젯을 import

class RankingListView extends StatelessWidget {
  // API 데이터 예시
  final List<Map<String, dynamic>> apiData = [
    {
      "score": "00:41:00",
      "memberDto": {
        "memberId": 1,
        "nickname": "관리자",
        "memberImage": null,
      }
    },
    {
      "score": "00:41:30",
      "memberDto": {
        "memberId": 2,
        "nickname": "runner123",
        "memberImage": null,
      }
    },
    {
      "score": "00:42:00",
      "memberDto": {
        "memberId": 6,
        "nickname": "runner123234",
        "memberImage": {
          "memberId": 6,
          "url": "http://example.com/profile.jpg",
          "path": "/images/profile.jpg",
        }
      }
    },
    {
      "score": "00:43:00",
      "memberDto": {
        "memberId": 4,
        "nickname": "runner1232",
        "memberImage": null,
      }
    },
    {
      "score": "00:43:30",
      "memberDto": {
        "memberId": 13,
        "nickname": "runn2w322422",
        "memberImage": {
          "memberId": 13,
          "url": "http://example.com/profile.jpg",
          "path": "/images/profile.jpg",
        }
      }
    },
  ];

  // 전체 버튼 활성화 상태를 관리하는 단일 변수
  final bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ranking List')),
      body: ListView.builder(
        itemCount: apiData.length,
        itemBuilder: (context, index) {
          final user = apiData[index];
          final memberDto = user['memberDto'];
          final memberImage = memberDto['memberImage'];

          return RankingCard(
            name: memberDto['nickname'] ?? 'Unknown',
            time: user['score'] ?? '00:00:00',
            imageUrl: memberImage != null ? memberImage['url'] : null,
            rank: index + 1,
            isActive: isActive,
          );
        },
      ),
    );
  }
}
