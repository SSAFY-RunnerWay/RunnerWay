import 'package:flutter/material.dart';
import 'package:frontend/widgets/under_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Main Page'),
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
