import 'package:flutter/material.dart';
import 'package:frontend/widgets/button/wide_button.dart';
import 'package:frontend/widgets/modal/birth_modal.dart';
import 'package:frontend/views/auth/widget/signup_input.dart';
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
    setState(() {
      isButtonActive = _nicknameController.text.trim().length > 1;
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
                      // 닉네임 글자 수 제한
                      onChanged: (text) {
                        if (text.characters.length > 8) {
                          _nicknameController.text =
                              text.characters.take(8).toString(); // 8자로 자르기
                          // 커서 뒤로 이동
                          _nicknameController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: _nicknameController.text.length));
                        } else if (text.characters.length < 2) {
                          isButtonActive = false;
                        }
                      },
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
                    child: SignupInput(
                        inputType: 'height', controller: _heightController),
                  ),
                  SignupInput(
                      inputType: 'weight', controller: _weightController),
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
                        selectedGender = 'woman'; //
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
              SizedBox(height: 2),
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
                  bool isNicknameCheck = await _authController
                      .checkNickname(_nicknameController.text);
                  if (isNicknameCheck) {
                    Get.snackbar('오류', '이미 사용중인 닉네임입니다');
                  } else {
                    int? height = _heightController.text.isNotEmpty
                        ? int.tryParse(_heightController.text)
                        : null;
                    int? weight = _weightController.text.isNotEmpty
                        ? int.tryParse(_weightController.text)
                        : null;
                    await _authController.signup(
                      Auth(
                        email: widget.email,
                        nickname: _nicknameController.text,
                        birth: DateTime.tryParse(_dateController.text),
                        height: height,
                        weight: weight,
                        gender: selectedGender == 'man' ? 1 : 0,
                        // 성별 설정
                        joinType: 'kakao',
                        memberImage: MemberImage(
                          memberId: null,
                          url: "",
                          path: "",
                        ),
                      ),
                    );

                    Get.toNamed('/signup2');
                  }
                }
              : null, // '다음' 버튼 클릭 시 동작
        ),
      ),
    );
  }
}
