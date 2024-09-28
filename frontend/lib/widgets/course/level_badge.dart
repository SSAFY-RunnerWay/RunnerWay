import 'package:flutter/material.dart';

class LevelBadge extends StatelessWidget {
  final int level;

  const LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: level == 1
            ? Color(0xff0AC800).withOpacity(0.05)
            : level == 2
                ? Color(0xff1EA6FC).withOpacity(0.05)
                : Color(0xffFFF7F7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Lv. ${level}',
        style: TextStyle(
          color: level == 1
              ? Color(0xff0AC800)
              : level == 2
                  ? Color(0xff1EA6FC)
                  : Color(0xffF44237),
          fontSize: 12,
        ),
      ),
    );
  }
}
