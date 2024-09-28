import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 1,
      width: MediaQuery.of(context).size.width - 40,
      color: Color(0xffF1F1F1),
    );
  }
}
