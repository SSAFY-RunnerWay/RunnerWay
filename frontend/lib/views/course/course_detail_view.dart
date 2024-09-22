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

          // Course 상태에 따른 렌더링
          Obx(
            () {
              if (courseController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff1C1516),
                  ),
                );
              } else {
                // API 데이터를 받아 위젯에 정보 표시
                final course = courseController.course.value!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 코스 메인 정보 위젯
                    CourseMainInfo(
                      name: course.name,
                      content: course.content ?? '설명이 없는 코스입니다.',
                      address: course.address,
                      count: course.count,
                    ),

                    // 구분선
                    Line(),

                    // 코스 랭킹 위젯
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '코스 랭킹 TOP 5',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
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
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
