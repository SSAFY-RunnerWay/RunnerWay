import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/search_condition_controller.dart';

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
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xffE8E8E8),
              ),
              onChanged: (String? newCondition) {
                controller.updateSortCondition(newCondition!);
                // TODO: 검색 기준 바뀌는 경우, 다시 정렬
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
        width: 14,
      ),

      // 난이도 필터 버튼
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConditionDialog(
                controller: controller,
                conditionType: 'difficulty',
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Color(0xffe8e8e8).withOpacity(0.5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Text(
                '난이도',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
            ],
          ),
        ),
      ),

      SizedBox(
        width: 14,
      ),

      // 코스 거리 필터 버튼
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConditionDialog(
                controller: controller,
                conditionType: 'distance',
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Color(0xffe8e8e8).withOpacity(0.5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Text(
                '코스 거리',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
            ],
          ),
        ),
      ),

      // 남은 공간 차지
      Spacer(),

      // 현위치 불러오기 버튼
      IconButton(
        onPressed: () {
          // TODO : 현위치로 정렬하기
        },
        icon: Image.asset(
          'assets/images/gps.png',
          width: 30,
        ),
      ),
    ]);
  }
}

class ConditionDialog extends StatelessWidget {
  final SearchConditionController controller;
  final String conditionType;

  ConditionDialog({required this.controller, required this.conditionType});

  @override
  Widget build(BuildContext context) {
    List<String> items = conditionType == 'difficulty'
        ? ['Lv. 1', 'Lv. 2', 'Lv. 3']
        : ['~ 3km', '3 ~ 5km', '5 ~ 10km', '10km ~'];

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        conditionType == 'difficulty' ? "난이도 선택" : " 코스 거리 선택",
        style: TextStyle(fontSize: 16),
      ),
      content: Container(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            return Obx(() {
              return CheckboxListTile(
                activeColor: Color(0xff1EA6FC),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                title: Text(item),
                // 정렬 기준에 따라서 현재 value 설정
                value: conditionType == 'difficulty'
                    ? controller.selectedDifficulty.contains(item)
                    : controller.selectedDistance.contains(item), // 상태 변화 감지
                onChanged: (bool? isChecked) {
                  if (isChecked == true) {
                    // 리스트에 값이 없는 경우 선택 추가
                    if (conditionType == 'difficulty') {
                      if (!controller.selectedDifficulty.contains(item)) {
                        controller.selectedDifficulty.add(item);
                      }
                    } else {
                      if (!controller.selectedDistance.contains(item)) {
                        controller.selectedDistance.add(item);
                      }
                    }
                  } else {
                    // 선택되어 있는 경우 선택 해제
                    if (conditionType == 'difficulty') {
                      controller.selectedDifficulty.remove(item);
                    } else {
                      controller.selectedDistance.remove(item);
                    }
                  }
                },
              );
            });
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            '확인',
            style: TextStyle(color: Color(0xff1C1516)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
