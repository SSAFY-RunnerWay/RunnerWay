import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          SizedBox(height: 106), // 회원가입 페이지 유저 이미지 위치
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '걷고, 달리고',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '기록하는',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 90,
                child: Image.asset('assets/images/auth/logo.png'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 380,
                height: 450,
                child: Image.asset('assets/images/auth/login_image.png'),
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '3초만에 시작하기!',
                style: TextStyle(
                  color: Color(0xFFA0A0A0),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // 카카오 로그인
                  print('카카오 로그인 클릭');
                },
                child: Container(
                  width: 45,
                  height: 45,
                  child: Image.asset('assets/images/auth/kakao.png'),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
