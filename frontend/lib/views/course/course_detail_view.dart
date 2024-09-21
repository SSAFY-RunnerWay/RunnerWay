import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/views/course/widget/course_main_info.dart';

import '../../widgets/button/back_button.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
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

          // 코스 랭킹 위젯

          // 코스 상세 정보 위젯
        ],
      ),
    );
  }
}
