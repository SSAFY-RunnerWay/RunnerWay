import 'package:flutter/material.dart';
import 'package:frontend/widgets/under_bar.dart';
import 'widget/search_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            CourseSearchBar(),
            Text('main'),
          ],
        ),
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
