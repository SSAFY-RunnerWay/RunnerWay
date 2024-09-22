import 'package:flutter/material.dart';
import 'package:frontend/controllers/course_controller.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/views/course/widget/course_main_info.dart';
import 'package:frontend/views/course/widget/course_sub_info.dart';
import 'package:frontend/widgets/line.dart';
import 'package:frontend/widgets/ranking_card.dart';
import 'package:get/get.dart';

import '../../widgets/button/back_button.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.put(CourseController());

    return BaseView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Padding(
            padding: EdgeInsets.all(10),
            child: CustomBackButton(),
          ),

          // 코스 메인 정보 위젯
          CourseMainInfo(),

          // 구분선
          Line(),

          // 코스 랭킹 위젯
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '코스 랭킹 TOP 5',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          RankingCard(
              name: 'name',
              time: 'time',
              imageUrl: 'imageUrl',
              rank: 2,
              isActive: true),

          // 코스 상세 정보 위젯
          CourseSubInfo(),
        ],
      ),
    );
  }
}
