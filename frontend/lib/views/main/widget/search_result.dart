import 'package:flutter/material.dart';
import 'package:frontend/controllers/filter_controller.dart';
import 'package:frontend/controllers/search_controller.dart';
import 'package:get/get.dart';

import '../../../widgets/course/course_card.dart';
import '../../../widgets/filter_condition.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<SearchBarController>();
    final filterController = Get.find<FilterController>();

    // 검색 페이지로 들어왔을 때 타겟을 'search'로 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterController.resetFilters();
      filterController.setFilterTarget('search');
    });

    final result = searchController.searchResults;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilterCondition(),
          SizedBox(
            height: 15,
          ),

          // 공식 코스 검색 결과
          Row(
            children: [
              Text(
                '\'${searchController.searchText}\'으로 검색된',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                ' 코스 결과',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),

          Obx(
            () {
              if (searchController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (result.isEmpty) {
                return Center(
                  child: Text('검색 결과가 없습니다.'),
                );
              }

              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: result[index]);
                    },
                  ),
                  SizedBox(height: 20),

                  // 페이지네이션 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 이전 페이지 버튼
                      if (searchController.currentPage.value > 1)
                        IconButton(
                          onPressed: () {
                            searchController.fetchPreviousPage(
                                searchController.searchText.value);
                          },
                          icon: Icon(Icons.navigate_before_rounded),
                        ),
                      SizedBox(width: 10),

                      // 페이지 번호 표시
                      Text(
                        '${searchController.currentPage.value} / ${searchController.totalPages.value}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 10),

                      // 다음 페이지 버튼
                      if (searchController.currentPage.value <
                          searchController.totalPages.value)
                        IconButton(
                          onPressed: () {
                            searchController.fetchNextPage(
                                searchController.searchText.value);
                          },
                          icon: Icon(Icons.navigate_next_rounded),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
