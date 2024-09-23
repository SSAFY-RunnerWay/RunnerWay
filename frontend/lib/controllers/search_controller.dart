import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/search_service.dart';

class SearchBarController extends GetxController {
  var isFocus = false.obs;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  var suggestions = <String>[].obs;

  final SearchService _searchService = SearchService();

  @override
  void onInit() {
    super.onInit();

    // 현재 라우트 감지
    setFocus(true);
  }

  // 검색바 focus 상태 전환
  void setFocus(bool value) {
    isFocus.value = value;

    if (value) {
      // focus 요청
      focusNode.requestFocus();
    } else {
      // focus 해제
      focusNode.unfocus();
    }
  }

  // 검색어 초기화
  void clearSearch() {
    textEditingController.clear();
    setFocus(false);
    suggestions.clear();
  }

  // 포커스 다시 클릭 시 FocusNode 재생성
  void recreateFocusNode() {
    focusNode = FocusNode();
  }

  // 검색 자동완성 데이터 요청
  void fetchSuggestions(String query) async {
    log(query);
    if (query.isNotEmpty) {
      final results = await _searchService.getSuggestions(query);

      suggestions.assignAll(results);
    } else {
      suggestions.clear();
    }
  }

  @override
  void onClose() {
    // 페이지를 떠날 때 검색어 초기화
    focusNode.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}
