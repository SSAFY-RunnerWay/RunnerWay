import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/search_controller.dart';

class CourseSearchBar extends StatelessWidget {
  CourseSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<SearchBarController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        controller: searchController.textEditingController,
        cursorColor: Color(0xff1EA6FC),
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          // TODO: enter키 입력 시 결과 페이지로 이동
        },
        onTap: () {
          if (Get.currentRoute != '/search') {
            Get.toNamed('/search');
          }
          searchController.setFocus(true);
        },
        onChanged: (value) {
          searchController.fetchSuggestions(value);
        },
        focusNode: searchController.focusNode, // '/search'일 때만 포커스 활성화
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              // TODO : 검색 아이콘 클릭 시 검색 결과 페이지로 이동
            },
            icon: Icon(
              Icons.search,
              color: searchController.isFocus.value
                  ? Color(0xff1EA6FC)
                  : Color(0xff000000).withOpacity(0.2),
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintText: '코스명, 지역명, 러너명으로 검색',
          hintStyle: TextStyle(
            fontSize: 16,
            color: const Color(0xff000000).withOpacity(0.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Color(0xffE8E8E8),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: Color(0xff1EA6FC), width: 2),
          ),
        ),
      ),
    );
  }
}
