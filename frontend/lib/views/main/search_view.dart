import 'package:flutter/material.dart';
import 'package:frontend/views/main/widget/auto_complete.dart';
import 'package:frontend/views/main/widget/search_bar.dart';
import 'package:frontend/views/main/widget/search_prompt.dart';
import 'package:get/get.dart';

import '../../controllers/search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchBarController());

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            // 검색바
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    searchController.clearSearch();
                    Get.back();
                  },
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

            // 검색어 입력 전
            Obx(
              () => searchController.searchText.isEmpty
                  ? SearchPrompt()
                  // 검색어가 있는 경우, 검색어 자동 완성 리스트
                  : searchController.suggestions.isNotEmpty
                      ? AutoCompleteList()
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
