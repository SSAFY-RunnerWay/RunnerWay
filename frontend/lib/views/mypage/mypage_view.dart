import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/views/mypage/modify_info_view.dart';
import 'package:frontend/widgets/line.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MypageView extends StatelessWidget {
  MypageView({Key? key}) : super(key: key);
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    _authController.fetchUserInfo();

    return BaseView(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          '마이페이지',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              height: 119,
              width: 119,
              decoration: BoxDecoration(
                  color: Color(0xFFE4E4E4),
                  border: Border.all(color: Color(0xFFE4E4E4), width: 2),
                  borderRadius: BorderRadius.circular(16)),
            ),
            SizedBox(height: 30),
            // TODO 사용자 이름 불러오기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '백만불짜리 다리',
                  style: TextStyle(
                    color: Color(0xFF1C1516),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(
                    (0xFFA0A0A0),
                  ),
                ),
                onPressed: () {
                  _authController.logout();
                },
                child: Text("로그아웃")),
            Line(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '개인 상세 정보',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF1EA6FC)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifyInfoView()));
                      },
                      child: const Text(
                        '회원 정보 수정',
                        style: TextStyle(fontSize: 12),
                      )),
                ],
              ),
            ),

            SizedBox(height: 7),
          ],
        ),
      ),
    ));
  }
}
