import 'package:flutter/material.dart';
import 'package:frontend/controllers/runner_pick_controller.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/widgets/filter_condition.dart';
import 'package:frontend/widgets/search/search_read_only.dart';
import 'package:get/get.dart';

import '../../widgets/course/course_card.dart';

class RunnerPickView extends StatelessWidget {
  // 컨트롤러 인스턴스 생성
  final RunnerPickController runnerPickController =
      Get.put(RunnerPickController());

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // 검색바
            SearchReadOnly(),
            SizedBox(height: 20),

            // '러너들의 추천 코스' 제목
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  '러너들의 ',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Text(
                  '추천코스',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            // 필터
            FilterCondition(),
            SizedBox(height: 25),

            // 러너 코스 리스트
            Expanded(
              child: Obx(
                () {
                  if (runnerPickController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (runnerPickController.runnerCourses.isEmpty) {
                    return Center(
                      child: Text('추천 코스가 없습니다.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: runnerPickController.runnerCourses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                          course: runnerPickController.runnerCourses[index]);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
