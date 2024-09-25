import 'package:flutter/material.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/widgets/filter_condition.dart';
import 'package:frontend/widgets/search/search_read_only.dart';

class RunnerPickView extends StatelessWidget {
  const RunnerPickView({super.key});

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

            // 필터 불러오기
            FilterCondition(),
          ],
        ),
      ),
    );
  }
}
