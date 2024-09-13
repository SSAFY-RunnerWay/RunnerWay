import 'package:flutter/material.dart';

class SearchCondition extends StatelessWidget {
  const SearchCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 정렬 기준 버튼
        ElevatedButton.icon(
          onPressed: () {},
          icon: Image.asset(
            'assets/icons/condition.png',
            width: 22,
          ),
          label: Text(
            '인기순',
            style: TextStyle(color: Color(0xffE8E8E8), fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff1C1516),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),

        SizedBox(
          width: 10,
        ),

        // 난이도 선택 버튼
        DropdownButton(
          items: [],
          onChanged: (value) => {},
        ),
      ],
    );
  }
}
