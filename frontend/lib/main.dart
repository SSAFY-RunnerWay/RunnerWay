import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/under_bar.dart';
import 'routes/app_routes.dart';
import 'controllers/under_bar_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'notosans',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1EA6FC)),
        useMaterial3: true,
      ),
      // 여기서 Home을 직접 렌더링
      home: const Home(),
      getPages: AppRoutes.routes,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // UnderBarController 인스턴스 생성
    final UnderBarController controller = Get.put(UnderBarController());

    return Scaffold(
      body: Obx(() => controller.getCurrentPage()), // 현재 페이지 표시
      bottomNavigationBar: UnderBar(), // UnderBar 추가
    );
  }
}
