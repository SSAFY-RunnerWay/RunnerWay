import 'package:flutter/material.dart';
import 'package:frontend/widgets/course/course_card.dart';
import 'package:frontend/widgets/search_condition.dart';
import 'package:frontend/widgets/under_bar.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../base_view.dart';
import 'widget/search_bar.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Column(
        children: [
          // SearchBar
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CourseSearchBar(),
                SizedBox(height: 5),
              ],
            ),
          ),

          // Runner들의 Pick
          Container(
            child: Stack(
              children: [
                // Stack을 Expanded로 감싸 남은 공간을 차지하게 함
                Positioned(
                  child: Image.asset(
                    'assets/images/main/running.png',
                  ),
                ),
                Positioned(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '러너들의 ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'Pick ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'playball',
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '우리 동네 러너들에게',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '인기있는 코스를 즐겨보세요 !',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // 오늘의 추천 코스 container
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '오늘의 ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
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

                  // 검색 조건 위젯
                  SizedBox(height: 15),
                  SearchCondition(),

                  // 메인 화면 추천 코스 리스트
                  SizedBox(height: 20),
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (controller.courses.isEmpty) {
                          return Center(
                            child: Text('추천 코스가 없습니다.'),
                          );
                        }

                        return ListView.builder(
                          itemCount: controller.courses.length,
                          itemBuilder: (context, index) {
                            return CourseCard(
                                course: controller.courses[index]);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: UnderBar(),
    );
  }
}
