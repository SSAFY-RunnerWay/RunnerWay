import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseSearchBar extends StatelessWidget {
  final FocusNode _focusNode = FocusNode(); // FocusNode를 클래스 내부에서 관리

  CourseSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        onTap: () {
          if (Get.currentRoute != '/search') {
            Get.toNamed('/search');
          }
        },
        readOnly: Get.currentRoute != '/search', // '/search'가 아닐 때는 입력 비활성화
        focusNode: Get.currentRoute == '/search'
            ? _focusNode
            : null, // '/search'일 때만 포커스 활성화
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: '코스명, 지역명, 러너명으로 검색',
          hintStyle: TextStyle(
            fontSize: 14,
            color: const Color(0xff000000).withOpacity(0.2),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: Color(0xffE8E8E8))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: Color(0xffE8E8E8)),
          ),
        ),
      ),
    );
  }
}
