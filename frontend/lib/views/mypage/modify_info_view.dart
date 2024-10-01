import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/views/auth/login_view.dart';
import 'package:frontend/views/base_view.dart';
import 'package:frontend/views/auth/signup_view.dart';
import 'package:get/get.dart';
import '../../widgets/line.dart';
import '../../widgets/modal/birth_modal.dart';
import '../auth/widget/signup_input.dart';

class ModifyInfoView extends StatelessWidget {
  ModifyInfoView({Key? key}) : super(key: key);
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
            '회원정보수정',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 56,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                // TODO 유저 이름
                Line(),
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
                SizedBox(
                  height: 7,
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _authController.nicknameController,
                          enabled: _authController.isEditable.value,

                          // 닉네임 글자 수 제한
                          onChanged: (text) {
                            if (text.characters.length > 8) {
                              _authController.nicknameController.text =
                                  text.characters.take(8).toString(); // 8자로 자르기
                              // 커서 뒤로 이동
                              _authController.nicknameController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _authController
                                          .nicknameController.text.length));
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
                      )
                    ],
                  ),
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
                Obx(() => BirthModal(
                    birthController: _authController.dateController,
                    enabled: _authController.isEditable.value)),
                // 키 몸무게 input
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth / 6),
                      child: SignupInput(
                          inputType: 'height',
                          controller: _authController.heightController,
                          enabled: _authController.isEditable.value),
                    ),
                    SignupInput(
                        inputType: 'weight',
                        controller: _authController.weightController,
                        enabled: _authController.isEditable.value),
                  ],
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    _authController.isEditable.value =
                        !_authController.isEditable.value;
                  },
                  child: Obx(() =>
                      Text(_authController.isEditable.value ? '저장' : '수정')),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpView(
                                email: '',
                              )),
                    );
                  },
                  child: const Text('Go to Signup Page'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  child: const Text('Go to Login Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}