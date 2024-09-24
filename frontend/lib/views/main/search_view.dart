import 'package:flutter/material.dart';
import 'package:frontend/views/main/widget/auto_complete.dart';
import 'package:frontend/views/main/widget/search_bar.dart';
import 'package:frontend/views/main/widget/search_prompt.dart';
import 'package:frontend/views/main/widget/search_result.dart';
import 'package:get/get.dart';

import '../../controllers/search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchBarController());

    // 쿼리 파라미터 가져오기
    final searchQuery = Get.parameters['query'];

    if (searchQuery != null && searchQuery.isNotEmpty) {
      // 빌드가 완료된 후에 검색 결과 API 요청
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchController.fetchSearchResults(searchQuery);
      });
    }

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
                    Get.toNamed('/main');
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

            // 검색 쿼리 인식 전 (사용자가 검색 중인 상태)
            searchQuery == null || searchQuery.isEmpty
                ? Obx(
                    () => searchController.searchText.isEmpty
                        // 검색어 입력 전
                        ? SearchPrompt()
                        // 검색어가 있는 경우, 검색어 자동 완성 리스트
                        : searchController.suggestions.isNotEmpty
                            ? AutoCompleteList()
                            : Container(),
                  )
                // 검색 결과 화면
                : SearchResult()
          ],
        ),
      ),
    );
  }
}
