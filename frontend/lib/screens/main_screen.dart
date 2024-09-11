import 'package:flutter/material.dart';
import '/widgets/back_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Main screen goes here'), // 메인 콘텐츠
      )
    );
  }
}
