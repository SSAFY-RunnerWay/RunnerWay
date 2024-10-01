import 'package:flutter/material.dart';

class SearchPrompt extends StatelessWidget {
  const SearchPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/active_search.png',
                height: 22,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '원하는 코스를 검색해보세요',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '예) 대전 산책로와 같이 입력해보세요 !',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff000000).withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
