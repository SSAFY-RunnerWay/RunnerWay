import 'package:flutter/material.dart';
import 'package:frontend/views/main/main_view.dart';
import 'package:frontend/views/mypage/mypage-view.dart';
import 'package:frontend/views/record/record_view.dart';
import 'package:frontend/views/runnerPick/runner_pick_view.dart';
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
      home: Home(),
      getPages: AppRoutes.routes,
    );
  }
}

class Home extends StatelessWidget {
  // 탭별 화면
  static List<Widget> tabPages = <Widget>[
    MainView(),
    RunnerPickView(),
    RecordView(),
    MypageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
          child:
              // static 변수를 이용해 컨트롤러 접근
              tabPages[UnderBarController.to.selectedIndex.value])),
      bottomNavigationBar: UnderBar(),
    );
  }
}
