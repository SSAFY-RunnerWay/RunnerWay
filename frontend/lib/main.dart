import 'package:flutter/material.dart';
import 'package:frontend/screens/runner_pick_screen.dart';
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
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeWithUnderBarState createState() => _HomeWithUnderBarState();
}

class _HomeWithUnderBarState extends State<Home> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스

  // 각 탭에 해당하는 화면들
  final List<Widget> _pages = [
    const MainScreen(),
    const RunnerPickScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages, // 탭에 따라 표시되는 페이지
      ),
      bottomNavigationBar: UnderBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // 탭 선택 시 인덱스 변경
      ),
    );
  }
}