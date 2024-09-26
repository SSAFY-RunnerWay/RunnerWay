import 'package:flutter/material.dart';

class FavoriteTag extends StatefulWidget {
  final Function(String) onItemTapped;
  final String text;
  final String imagePath;

  const FavoriteTag({
    super.key,
    required this.text,
    required this.onItemTapped,
    required this.imagePath,
  });

  @override
  _FavoriteTagState createState() => _FavoriteTagState();
}

class _FavoriteTagState extends State<FavoriteTag> {
  // 선택 상태를 관리하는 변수 추가
  bool _isSelected = false;

  // 선택 상태에 따라 색상을 변경하는 함수
  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected; // 선택 상태를 반전
    });
  }

  @override
  Widget build(BuildContext context) {
    // 선택 상태에 따른 색상 설정
    Color _buttonColor = _isSelected
        ? Color(0xFF1EA6FC).withOpacity(0.1)
        : Color(0xFFE3E5E5).withOpacity(0.3);
    Color _borderColor = _isSelected ? Color(0xFF1EA6FC) : Color(0xFFE3E5E5);

    return GestureDetector(
      onTap: () {
        widget.onItemTapped(widget.text);
        _toggleSelection();
      },
      child: IntrinsicWidth(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: _buttonColor, // 상태에 따른 배경색 설정
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _borderColor, // 상태에 따른 테두리 색상 설정
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imagePath,
                  width: 22,
                  height: 22,
                ),
                SizedBox(width: 5),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Color(0xFF72777A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
