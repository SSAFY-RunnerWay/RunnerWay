import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/search_condition_controller.dart';

class SearchCondition extends StatelessWidget {
  final SearchConditionController controller =
      Get.put(SearchConditionController());

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // 정렬 기준 버튼
      Obx(
        () => DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xff1C1516),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButton<String>(
              padding: EdgeInsets.symmetric(horizontal: 10),
              value: controller.sortCondition.value,
              items: <String>['인기순', '거리순'].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Color(0xffE8E8E8), fontSize: 16),
                    ),
                  );
                },
              ).toList(),
              onChanged: (String? newCondition) {
                controller.updateSortCondition(newCondition!);
              },
              dropdownColor: Color(0xff1C1516),
              underline: Container(),
              focusColor: Color(0xff1C1516),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),

      SizedBox(
        width: 10,
      ),

      // 난이도 필터 버튼
      Obx(
        () => DropdownButton<String>(
          value: controller.selectedDifficulty.value, // 현재 선택된 값
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.transparent, // 밑줄 제거
          ),
          onChanged: (String? newValue) {
            controller.updateDifficulty(newValue!); // 선택한 난이도로 상태 업데이트
          },
          items: <String>['Lv. 1', 'Lv. 2', 'Lv. 3'] // 난이도 옵션 목록
              .map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    ]);
  }
}
