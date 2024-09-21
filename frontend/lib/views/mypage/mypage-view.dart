import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';

class MypageView extends StatelessWidget {
  const MypageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Center(
        child: Text('My Page'),
      ),
    );
  }
}
