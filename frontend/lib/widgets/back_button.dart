import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xff131214)),
      onPressed: () {
        // 뒤로가기 버튼 누르면 이전 화면으로 이동
        Navigator.pop(context);
      },
    );
  }
}