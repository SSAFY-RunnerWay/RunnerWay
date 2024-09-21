import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';
import 'package:get/get.dart';

import '../../widgets/button/back_button.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 뒤로가기

          CustomBackButton(),
        ],
      ),
    );
  }
}
