import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchReadOnly extends StatelessWidget {
  SearchReadOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        cursorColor: Color(0xff1EA6FC),
        onTap: () {
          Get.toNamed('/search');
        },
        readOnly: true,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xff000000).withOpacity(0.2),
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
            borderSide: const BorderSide(
              color: Color(0xffE8E8E8),
            ),
          ),
        ),
      ),
    );
  }
}
