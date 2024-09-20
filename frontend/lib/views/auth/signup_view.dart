import 'package:flutter/material.dart';
import 'package:frontend/widgets/button/wide_button.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nicknameController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20), // 화면 전체 margin 20
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '회원가입',
                  style: TextStyle(
                    color: Color(0xFF1C1516),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            // 회원가입 유저 이미지
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/auth/default_profile.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
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
            // 텍스트필드가 보이도록 Expanded 사용
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nicknameController,
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
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
