import 'package:frontend/views/mypage/mypage-view.dart';
import 'package:frontend/views/record/record_view.dart';
import 'package:get/get.dart';
import 'package:frontend/views/main/main_view.dart';
import 'package:frontend/views/runnerPick/runner_pick_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/main', page: () => MainView()),
    GetPage(name: '/runner-pick', page: () => RunnerPickView()),
    GetPage(name: '/record', page: () => RecordView()),
    GetPage(name: '/mypage', page: () => MypageView()),
  ];
}
