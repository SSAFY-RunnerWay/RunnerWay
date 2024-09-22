import 'package:frontend/views/course/course_detail_view.dart';
import 'package:frontend/views/main/search_view.dart';
import 'package:frontend/views/mypage/mypage_view.dart';
import 'package:frontend/views/record/record_view.dart';
import 'package:get/get.dart';
import 'package:frontend/views/main/main_view.dart';
import 'package:frontend/views/runnerPick/runner_pick_view.dart';
import 'package:frontend/views/auth/signup_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
        name: '/main',
        page: () => MainView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/course/:type/:id',
        page: () => CourseDetailView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/search',
        page: () => SearchView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/runner-pick',
        page: () => RunnerPickView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/record',
        page: () => RecordView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/mypage',
        page: () => MypageView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/signup',
        page: () => SignUpView(),
        transition: Transition.noTransition),
  ];
}
