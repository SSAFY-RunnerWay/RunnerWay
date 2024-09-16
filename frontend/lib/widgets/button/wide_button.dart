import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String text;
  final bool isActive; // active, inactive 구분

  WideButton({
    super.key,
    required this.text,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 화면 전체 너비
      height: 58,
      child: ElevatedButton(
          onPressed: isActive
              ? () {
                  print("버튼눌렷당");
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? Color(0xFF1C1516) : Color(0xFFE8E8E8),
            foregroundColor: isActive ? Colors.white : Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'notosans',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}

// class WideButton extends StatelessWidget {
//   final String text;
//   final Color bgColor; // background color
//   final Color? bdColor; // borderLine은 nullable로 둠
//   final Color textColor;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final double width;
//   final double height;
//   final Function(int) onItemTapped;
//
//   WideButton({
//     super.key,
//     required this.text,
//     required this.bgColor,
//     required this.textColor,
//     required this.onItemTapped,
//     this.bdColor,
//     this.width = 200, // 추후 모달 창에 맞춰 변경 예정
//     this.height = 50,
//     this.fontSize = 14,
//     this.fontWeight = FontWeight.w500, // 기본 값은 medium으로 둠
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         color: bgColor,
//         border: bdColor != null
//             ? Border.all(color: bdColor!) // bdColor가 null이 아닐 때만 적용,
//             : null,
//         borderRadius: BorderRadius.circular(48),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: 11,
//           horizontal: 65,
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: textColor,
//             fontSize: fontSize,
//             fontWeight: fontWeight,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
