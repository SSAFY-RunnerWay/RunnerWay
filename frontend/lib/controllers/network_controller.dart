import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart'; // app_settings 패키지 추가

class NetworkController {
  static final Connectivity _connectivity = Connectivity();

  // 네트워크 상태를 처음에 한 번만 확인하는 함수
  static Future<void> checkInitialConnectivity(BuildContext context) async {
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    _handleConnectionStatus(result, context);
  }

  // log 출력
  static void _handleConnectionStatus(
      List<ConnectivityResult> result, BuildContext context) {
    if (result.contains(ConnectivityResult.wifi)) {
      log('Wi-Fi에 연결되었습니다.');
    } else if (result.contains(ConnectivityResult.mobile)) {
      log('모바일 네트워크에 연결되었습니다.');
    } else {
      log('연결 없어요~~');
      _openNetworkSettings();
    }
  }

  // 네트워크 설정 열기
  static void _openNetworkSettings() {
    // app_settings 패키지를 사용해 네트워크 설정 열기
    AppSettings.openAppSettings(type: AppSettingsType.wireless);
    log('네트워크 설정 화면으로 이동했습니다.');
  }

  // 네트워크 연결이 없는 경우 모달 표시 이거 추후 수정
  // static void _showNoConnectionModal(BuildContext context) {
  //   // Navigator가 있는 context인지 확인
  //   final navigator = Navigator.maybeOf(context);
  //   if (navigator != null &&
  //       Localizations.of<MaterialLocalizations>(
  //               context, MaterialLocalizations) !=
  //           null) {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('네트워크 연결 없음'),
  //           content: const Text('네트워크 연결을 확인하세요.'),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('확인'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     log('Navigator 또는 MaterialLocalizations가 없습니다. 적절한 context인지 확인하세요.');
  //   }
  // }
}
