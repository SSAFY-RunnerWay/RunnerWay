import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String text;
  final Color bgColor; // background color
  final Color? bdColor; // borderLine은 nullable로 둠
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double width;
  final double height;
  final Function(int) onItemTapped;

  WideButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.onItemTapped,
    this.bdColor,
    this.width = 200, // 추후 모달 창에 맞춰 변경 예정
    this.height = 50,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500, // 기본 값은 medium으로 둠
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        border: bdColor != null
            ? Border.all(color: bdColor!) // bdColor가 null이 아닐 때만 적용,
            : null,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 65,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
