import 'package:flutter/material.dart';
import 'package:frontend/controllers/search_controller.dart';
import 'package:frontend/models/course.dart';
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

    final officialResults = searchController.searchOfficialResults;
    final userResults = searchController.searchUserResults;

    return Container(
      child: Column(
        children: [
          FilterCondition(),
          SizedBox(
            height: 15,
          ),

          // 공식 코스 검색 결과
          Row(
            children: [
              Text(
                '러너웨이 공식',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                ' 코스',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          // 공식 코스 결과 리스트
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: officialResults.length,
          //     itemBuilder: (context, index) {
          //       return CourseCard(course: officialResults[index]);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
