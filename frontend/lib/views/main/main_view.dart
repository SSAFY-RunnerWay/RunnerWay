import 'package:flutter/material.dart';
import 'package:frontend/widgets/under_bar.dart';
import 'widget/search_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SearchBar
          Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              CourseSearchBar(),
              SizedBox(height: 5),
            ]),
          ),

          // Runner들의 Pick
          Expanded(
            child: Stack(
              children: [
                // Stack을 Expanded로 감싸 남은 공간을 차지하게 함
                Positioned(
                  child: Image.asset(
                    'assets/images/running.png',
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
                        height: 10,
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

          // 오늘의 추천 코스
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('오늘의 추천 코스'),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: UnderBar(),
    );
  }
}
