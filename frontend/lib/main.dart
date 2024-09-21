import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'controllers/under_bar_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 앱 시작 시 전역 상태로 UnderBarController 등록
    Get.put(UnderBarController());
    return SafeArea(
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, // 모든 페이지의 배경색을 흰색으로 설정
          colorSchemeSeed: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/main',
        getPages: AppRoutes.routes,
        scrollBehavior: NoBounceScrollBehavior(), // 커스텀 스크롤 동작 적용
      ),
    );
  }
}

// 바운스 효과를 제거하는 커스텀 ScrollBehavior
class NoBounceScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // 바운스 효과를 제거
  }

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // 기본 Chrome 유지
  }
}
