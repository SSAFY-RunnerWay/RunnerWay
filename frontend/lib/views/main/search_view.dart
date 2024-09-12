import 'package:flutter/material.dart';
import 'package:frontend/views/main/widget/search_bar.dart';
import 'package:frontend/widgets/under_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            CourseSearchBar(),
            Text('search'),
          ],
        ),
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
