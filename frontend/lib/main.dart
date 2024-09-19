import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        // 여기서 Home을 직접 렌더링
        initialRoute: '/main',
        getPages: AppRoutes.routes,
      ),
    );
  }
}
