import 'package:flutter/material.dart';
import 'package:get/get.dart';
// 페이지 이동 임의로 설정
import '../widgets/map/running_map.dart';

class RankingCard extends StatelessWidget {
  final String name;
  final String time;
  final String? imageUrl;
  final int rank;
  final bool isActive;

  RankingCard({
    Key? key,
    required this.name,
    required this.time,
    required this.imageUrl,
    required this.rank,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffE4E4E4), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          imageUrl ?? 'assets/images/auth/defaultProfile.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffE4E4E4), width: 2),
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/images/auth/defaultProfile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (rank <= 3) // 상위 3명만 뱃지 표시, 뱃지로 바꿀 시 변경 위치
                    Positioned(
                      right: -5,
                      bottom: -5,
                      child: _buildBadge(rank),
                    ),
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      time,
                      style: TextStyle(
                          color: Color(0xff6C7072),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ],
          ),
          // isActive가 true일 때만 ElevatedButton 표시
          if (isActive)
            ElevatedButton(
              onPressed: () {
                Get.to(() => RunningMap());
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'VS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBadge(int rank) {
    Color badgeColor;
    switch (rank) {
      case 1:
        return Image.asset(
          'assets/images/medals/goldmedal.png',
          width: 38,
          height: 30,
          fit: BoxFit.cover,
        );
        break;
      case 2:
        return Image.asset(
          'assets/images/medals/silvermedal.png',
          width: 38,
          height: 30,
          fit: BoxFit.cover,
        );
        break;
      case 3:
        return Image.asset(
          'assets/images/medals/bronzemedal.png',
          width: 38,
          height: 30,
          fit: BoxFit.cover,
        );
        break;
      default:
        badgeColor = Colors.transparent;
    }
    return CircleAvatar(
      backgroundColor: badgeColor,
      radius: 15,
      child: Text(
        '$rank',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
