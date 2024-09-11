import 'package:flutter/material.dart';
import 'widgets/under_bar.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug 표시 제거
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1EA6FC)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: MainScreen(), // main screen을 홈으로 지정
        bottomNavigationBar: const UnderBar(),
      )
    );
  }
}

