import 'package:flutter/material.dart';
import 'package:frontend/widgets/button/wide_button.dart';
import 'package:frontend/widgets/modal/birth_modal.dart';
import 'package:frontend/views/auth/widget/signup_input.dart';
import 'package:frontend/views/auth/signup_view2.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/models/auth.dart';

class SignUpView extends StatefulWidget {
  final String email;

  const SignUpView({super.key, required this.email});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  String selectedGender = ''; // "woman", "man"으로 구분
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_onNicknameChanged);
  }

  void _onNicknameChanged() {
    // 닉네임 입력하면 버튼 활성화
    setState(() {
      isButtonActive = _nicknameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _dateController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
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
              SizedBox(height: 20),
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
              SizedBox(height: 7),
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
              SizedBox(height: 25),
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
              SizedBox(height: 7),
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
              SizedBox(height: 25),
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
              SizedBox(height: 7),
              // 성별 선택 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'woman'; // "woman"을 선택하면 상태 변경
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: selectedGender == 'woman'
                            ? Color(0xFF1EA6FC).withOpacity(0.1)
                            : Color(0xFFE3E5E5).withOpacity(0.3),
                        border: Border.all(
                          color: selectedGender == 'woman'
                              ? Color(0xFF1EA6FC)
                              : Color(0xFFE3E5E5).withOpacity(0.8),
                          width: selectedGender == 'woman' ? 4.0 : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        selectedGender == 'woman'
                            ? 'assets/images/auth/woman_ok.png'
                            : 'assets/images/auth/woman_no.png',
                        width: 85,
                        height: 85,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'man'; // "man"을 선택하면 상태 변경
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: selectedGender == 'man'
                            ? Color(0xFF1EA6FC).withOpacity(0.1)
                            : Color(0xFFE3E5E5).withOpacity(0.3),
                        border: Border.all(
                          color: selectedGender == 'man'
                              ? Color(0xFF1EA6FC)
                              : Color(0xFFE3E5E5).withOpacity(0.8),
                          width: selectedGender == 'man' ? 4.0 : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        selectedGender == 'man'
                            ? 'assets/images/auth/man_ok.png'
                            : 'assets/images/auth/man_no.png',
                        width: 85,
                        height: 85,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2), // 간격을 위한 SizedBox 추가
              // "signup다음" 버튼 추가
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // 다른 페이지로 이동하는 로직 추가
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignUpView2()), // NextPage는 이동할 페이지
                    );
                  },
                  child: Text(
                    'signup다음',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: WideButton(
          text: '다음',
          isActive: isButtonActive,
          onTap: isButtonActive
              ? () async {
                  await _authController.signup(
                    Auth(
                      email: widget.email,
                      nickname: _nicknameController.text,
                      birth: DateTime.tryParse(_dateController.text),
                      height: int.tryParse(_heightController.text),
                      weight: int.tryParse(_weightController.text),
                      gender: selectedGender == 'man' ? 1 : 0, // 성별 설정
                      joinType: 'kakao',
                      memberImage: MemberImage(
                        memberId: null,
                        url: "",
                        path: "",
                      ),
                    ),
                  );

                  Get.to(SignUpView2());
                }
              : null, // '다음' 버튼 클릭 시 동작
        ),
      ),
    );
  }
}
