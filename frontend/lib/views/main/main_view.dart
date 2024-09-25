import 'package:flutter/material.dart';
import 'package:frontend/widgets/course/course_card.dart';
import 'package:frontend/widgets/filter_condition.dart';
import 'package:frontend/widgets/search/search_read_only.dart';
import 'package:get/get.dart';
import '../../controllers/filter_controller.dart';
import '../../controllers/main_controller.dart';
import '../base_view.dart';

class MainView extends StatelessWidget {
  // filtercontroller 먼저 등록
  final FilterController filterController = Get.put(FilterController());
  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    // 메인 view에서 필터 타겟을 main으로 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterController.setFilterTarget('main');
    });

    return BaseView(
      child: Column(
        children: [
          // SearchBar
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SearchReadOnly(),
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
                            width: 20,
                          ),
                          Text(
                            '러너들의 ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Pick ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'playball',
                              fontSize: 30,
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
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '인기있는 코스를 즐겨보세요 !',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
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
                  FilterCondition(),

                  // 메인 화면 추천 코스 리스트
                  SizedBox(height: 25),
                  Expanded(
                    child: Obx(
                      () {
                        if (mainController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (mainController.courses.isEmpty) {
                          return Center(
                            child: Text('추천 코스가 없습니다.'),
                          );
                        }

                        return ListView.builder(
                          itemCount: mainController.filteredCourses.length,
                          itemBuilder: (context, index) {
                            return CourseCard(
                                course: mainController.filteredCourses[index]);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 80),
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
