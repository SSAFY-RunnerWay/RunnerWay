import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinRunningButton extends StatelessWidget {
  const JoinRunningButton({super.key, required this.onItemTapped});

  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C1516),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 65),
          child: Text(
            '이 코스로 러닝',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
