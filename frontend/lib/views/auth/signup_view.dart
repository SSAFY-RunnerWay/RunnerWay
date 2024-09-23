import 'package:flutter/material.dart';
import 'package:frontend/widgets/button/wide_button.dart';
import 'package:frontend/widgets/modal/birth_modal.dart';
import 'package:frontend/views/auth/signup_input.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _nicknameController = TextEditingController();
    final TextEditingController _dateController =
        TextEditingController(); // 생년월일 입력을 위한 컨트롤러
    final double screenWidth = MediaQuery.of(context).size.width; // 화면 전체 크기

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // 화면 전체 margin 20
        child: Column(
          children: [
            SizedBox(height: 50),
            // 회원가입 유저 이미지
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/auth/default_profile.png',
                    width: 90,
                    height: 90,
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            // 회원가입 폼 시작
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '닉네임',
                  style: TextStyle(
                    color: Color(0xFF1C1516),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    // controller: _nicknameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      filled: true,
                      hintText: '  닉네임 (2~8자)',
                      hintStyle: TextStyle(
                        color: Color(0xFF72777A),
                      ),
                      fillColor: Color(0xFFE3E5E5).withOpacity(0.4),
                    ),
                    cursorColor: Colors.blueAccent,
                    cursorErrorColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Text(
                  '생년월일',
                  style: TextStyle(
                    color: Color(0xFF1C1516),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // 생년월일 달력 modal
            BirthModal(birthController: _dateController),
            // 키 몸무게 input
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: screenWidth / 6),
                  child: SignupInput(inputType: 'height'),
                ),
                SignupInput(inputType: 'weight'),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Text(
                  '성별',
                  style: TextStyle(
                    color: Color(0xFF1C1516),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFE3E5E5).withOpacity(0.3),
                    border: Border.all(
                      color: Color(0xFFE3E5E5).withOpacity(0.8),
                    ),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/auth/woman_no.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFE3E5E5).withOpacity(0.3),
                    border: Border.all(
                      color: Color(0xFFE3E5E5).withOpacity(0.8),
                    ),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/auth/man_no.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: WideButton(
          text: '가입하러가자',
          isActive: true,
        ),
      ),
    );
  }
}
