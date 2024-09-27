import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:frontend/controllers/network_controller.dart';
import 'package:frontend/widgets/modal/custom_modal.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.find<NetworkController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          // 네트워크 상태 확인 중
          if (networkController.isConnected.value == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  '네트워크 상태를 확인하는 중...',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            );
          }
          // 네트워크 연결이 없을 때
          else if (networkController.isConnected.value == false) {
            log('연결 안됨');
            Future.delayed(Duration.zero, () => _showNoNetworkModal(context));
            return const Text('네트워크 연결 없음');
          }
          // 네트워크 연결이 있을 때
          else {
            Future.delayed(Duration.zero, () => _navigateToMain());
            return const SizedBox.shrink(); // 빈 화면 처리
          }
        }),
      ),
    );
  }

  void _showNoNetworkModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomModal(
          title: '네크워크 연결 없음',
          content: '네트워크 연결을 확인하세요',
          confirmText: '설정 열기',
          onConfirm: () {
            // 네트워크 설정 열기
            Get.find<NetworkController>().openNetworkSettings();
          },
        );
      },
    );
  }

  void _navigateToMain() {
    Get.offNamed('/main'); // 네트워크 연결 시 메인 화면으로 이동
  }
}
