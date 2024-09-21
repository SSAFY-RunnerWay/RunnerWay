import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';
import 'package:get/get.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Center(
        child: Text('couse detail : ${Get.parameters['id']}'),
      ),
    );
  }
}
