import 'package:flutter/material.dart';
import 'package:frontend/views/main/widget/auto_complete.dart';
import 'package:frontend/views/main/widget/search_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            // 검색바
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/back2.png',
                    width: 14,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CourseSearchBar(),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            // 검색어 자동 완성 리스트
            AutoCompleteList(),
          ],
        ),
      ),
    );
  }
}
