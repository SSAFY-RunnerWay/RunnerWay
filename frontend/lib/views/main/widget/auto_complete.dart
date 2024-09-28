import 'package:flutter/material.dart';
import 'package:frontend/controllers/search_controller.dart';
import 'package:get/get.dart';

class AutoCompleteList extends StatelessWidget {
  const AutoCompleteList({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<SearchBarController>();

    return Obx(() {
      // 자동 완성 리스트가 있는 경우
      return Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchController.suggestions.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(searchController.suggestions[index]),
                    onTap: () {
                      searchController.setFocus(false);
                      searchController.textEditingController.text =
                          searchController.suggestions[index];

                      // 키보드 숨기기
                      FocusScope.of(context).unfocus();
                      searchController.searchResults.clear();

                      // 검색 아이콘 클릭 시 검색 결과 페이지로 이동
                      if (searchController.suggestions[index].isNotEmpty) {
                        Get.toNamed(
                            '/search?query=${searchController.suggestions[index]}');
                      }
                    },
                  ),
                ),

                // 마지막 항목이 아닌 경우 구분선 추가
                if (index != searchController.suggestions.length - 1)
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Color(0xffF1F1F1),
                  ),
              ],
            );
          },
        ),
      );
    });
  }
}
