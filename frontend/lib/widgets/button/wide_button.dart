import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String text;
  final bool isActive; // active, inactive 구분
  final VoidCallback? onTap;

  WideButton({
    super.key,
    required this.text,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 화면 전체 너비
      height: 58,
      child: ElevatedButton(
          onPressed: isActive ? onTap : null,
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
