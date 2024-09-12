import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({super.key});

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
          readOnly: Get.currentRoute != '/search',
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: '코스명, 지역명, 러너명으로 검색',
              hintStyle: TextStyle(
                color: Color(0xff000000).withOpacity(0.2),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: BorderSide(color: Color(0xffE8E8E8)))),
        ));
  }
}
