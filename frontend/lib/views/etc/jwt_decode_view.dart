import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/controllers/jwt_controller.dart';

class JwtDecodeView extends StatelessWidget {
  final JwtController jwtController = Get.put(JwtController());

  JwtDecodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JWT Decode View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text('ID: ${jwtController.id.value}',
                style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 8),
            Obx(() => Text('Email: ${jwtController.email.value}',
                style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 8),
            Obx(() => Text('Nickname: ${jwtController.nickname.value}',
                style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  jwtController.loadDecodedData();
                },
                child: const Text('Decode JWT and Display'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
