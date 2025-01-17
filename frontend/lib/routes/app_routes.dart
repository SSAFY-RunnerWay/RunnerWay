import 'package:frontend/utils/auth_middleware.dart';
import 'package:frontend/views/auth/splash_view.dart';
import 'package:frontend/views/course/course_detail_view.dart';
import 'package:frontend/views/course/user_course_register.dart';
import 'package:frontend/views/runnerPick/runner_pick_view.dart';
import 'package:frontend/views/running/record_detail_view.dart';
import 'package:frontend/views/running/free_course_running_view.dart';
import 'package:frontend/views/running/review_write_view.dart';
import 'package:frontend/views/running/running_things_view.dart';
import 'package:frontend/views/running/running_view.dart';
import 'package:frontend/views/search/search_view.dart';
import 'package:frontend/views/mypage/modify_info_view.dart';
import 'package:frontend/views/record/record_view.dart';
import 'package:frontend/views/auth/signup_view2.dart';
import 'package:frontend/views/auth/signup_view.dart';
import 'package:get/get.dart';
import 'package:frontend/views/main/main_view.dart';
import 'package:frontend/views/runner/runner_view.dart';

import '../views/auth/login_view.dart';
import '../views/mypage/mypage_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
        name: '/splash',
        page: () => SplashView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/main',
        page: () => MainView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/course/:type/:id',
        page: () => CourseDetailView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/search',
        page: () => SearchView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/search',
        page: () => SearchView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/runner',
        page: () => RunnerView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/runner-pick',
        page: () => RunnerPickView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/record',
        page: () => RecordView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/record/detail/:id',
        page: () => RecordDetailView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/mypage',
        page: () => MypageView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/signup',
        page: () => SignUpView(
              email: '',
            ),
        transition: Transition.noTransition),
    GetPage(
        name: '/signup2',
        page: () => SignUpView2(),
        transition: Transition.noTransition),
    GetPage(
        name: '/modify',
        page: () => ModifyInfoView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/login',
        page: () => LoginView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/register/:id',
        page: () => RegisterView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/runningthings',
        page: () => RunningThingsView(),
        transition: Transition.noTransition),
    GetPage(
        name: '/freecourserunning',
        page: () => FreeCourseRunningView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/writereview',
        page: () => ReviewWriteView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: '/running/:type/:courseid/:rankid',
        page: () => RunningView(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
  ];
}
