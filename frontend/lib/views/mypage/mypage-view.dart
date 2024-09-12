import 'package:flutter/material.dart';
import 'package:frontend/widgets/under_bar.dart';

class MypageView extends StatelessWidget {
  const MypageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My Page'),
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
