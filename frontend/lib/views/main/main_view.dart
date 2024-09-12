import 'package:flutter/material.dart';
import 'package:frontend/widgets/under_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xff1EA6FC),
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
