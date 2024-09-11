import 'dart:developer';
import 'package:flutter/material.dart';
import '../common/MyFlutterApp.dart';

class UnderBar extends StatefulWidget {
  const UnderBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnderBarState();
}

class _UnderBarState extends State<UnderBar> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스

  void _onItemTapped(int index) {
    log('$index');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 기기 가로길이 가져와 가로 길이를 설정
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 110,
      child: Stack(
        children: [
          // 네비게이션 바의 배경과 그림자
          Positioned(
            left: 0,
            top: 30,
            child: Container(
              width: screenWidth, // 화면 너비에 맞추어 설정
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14141414),
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // 탭 아이템들의 배치
                  Positioned(
                    left: 5,
                    top: 7,
                    child: _buildNavItem(0, '메인', Icons.home, screenWidth / 4, isLargeIcon: true),
                  ),
                  Positioned(
                    left: screenWidth / 5,
                    top: 7,
                    child: _buildNavItem(1, '러너픽', MyFlutterApp.road_1, screenWidth / 4, hasSizedBox: true),
                  ),
                  Positioned(
                    left: 3 * screenWidth / 5 - 10,
                    top: 7,
                    child: _buildNavItem(2, '기록', MyFlutterApp.calendar_empty, screenWidth / 4, hasSizedBox: true),
                  ),
                  Positioned(
                    left: 4 * screenWidth / 5 - 15,
                    top: 7,
                    child: _buildNavItem(3, '마이', Icons.person, screenWidth / 4, isLargeIcon: true),
                  ),
                ],
              ),
            ),
          ),
          // 플로팅 액션 버튼(가운데 강조된 버튼)
          Positioned(
            left: (screenWidth / 2) - 30, // 화면의 가운데에 배치
            top: 0,
            child: Container(
              width: 60,
              height: 60,
              decoration: ShapeDecoration(
                color: Color(0xFF1EA6FC),
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x961EA6FC),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 29,
                ),
              ),
            ),

          ),
          // 선택된 탭의 상단 바
          Positioned(
            top: 30, // 바의 고정된 상단 위치
            left: _getBarPosition(screenWidth), // 선택된 탭에 따라 위치를 동적으로 설정
            child: Container(
              width: screenWidth / 5 - 5, // 각 탭의 너비에 맞추어 바의 폭 설정
              height: 3,
              color: Color(0xFF1EA6FC), // 바의 색상
            ),
          ),
        ],
      ),
    );
  }

  // 선택된 탭에 따라 상단 바의 위치를 반환하는 함수
  double _getBarPosition(double screenWidth) {
    switch (_selectedIndex) {
      case 0:
        return 17; // '메인' 탭의 바 위치
      case 1:
        return 12 + screenWidth / 5; // '러너픽' 탭의 바 위치
      case 2:
        return 3 * screenWidth / 5 + 2; // '기록' 탭의 바 위치
      case 3:
        return 4 * screenWidth / 5 - 3; // '마이' 탭의 바 위치
      default:
        return 0;
    }
  }

  // 내비게이션 아이템을 생성하는 함수
  Widget _buildNavItem(int index, String label, IconData iconData, double itemWidth, {bool isLargeIcon = false, bool hasSizedBox = false}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: itemWidth,
        height: 56,
        color: Colors.white, // 아이템 배경색
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: isLargeIcon ? 32 : 22, // 메인과 마이의 아이콘은 크게, 나머지는 기본 크기
              color: _selectedIndex == index
                  ? Color(0xFF1EA6FC)
                  : Color(0xFF6C7072),
            ),
            if (hasSizedBox) SizedBox(height: 6), // 러너픽과 기록에만 추가되는 간격
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index
                    ? Color(0xFF1EA6FC)
                    : Color(0xFF6C7072),
                fontSize: 10,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
