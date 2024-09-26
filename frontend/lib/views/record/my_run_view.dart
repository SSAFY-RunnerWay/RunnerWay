import 'package:flutter/material.dart';

import '../../widgets/line.dart';

class RecordView extends StatelessWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          '런 기록',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              '30.2',
              style: TextStyle(
                  color: Color(0xFF1C1516),
                  fontSize: 26,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 3),
            Text(
              '이번 달 러닝 km',
              style: TextStyle(
                  color: Color(0xFFA0A0A0),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '08’47”',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '평균 페이스',
                        style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '12:06:56',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '러닝 시간',
                        style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '2358',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '칼로리',
                        style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Line(),
            SizedBox(height: 10),
            // 달력 들어갈 곳
            // Calendar(),
            Line(),
          ],
        ),
      ),
    );
  }
}
