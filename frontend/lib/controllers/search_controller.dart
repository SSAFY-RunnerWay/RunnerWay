import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/filter_controller.dart';
import 'package:get/get.dart';

import '../models/course.dart';
import '../models/search_result.dart';
import '../services/search_service.dart';

class SearchBarController extends GetxController {
  var isLoading = false.obs;

  // 검색 상태관리
  var searchText = ''.obs;
  var suggestions = <String>[].obs;
  var isFocus = false.obs;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  // 검색 결과 상태관리
  var searchResults = <Course>[].obs;
  var currentPage = 1.obs; // 현재 페이지
  var totalPages = 1.obs; // 전체 페이지 수

  final SearchService _searchService = SearchService();
  final FilterController filterController = Get.find<FilterController>();

  @override
  void onInit() {
    super.onInit();

    // 현재 라우트 감지
    textEditingController.addListener(() {
      searchText.value = textEditingController.text;
      fetchSuggestions(textEditingController.text);
    });

    setFocus(true);

    // SearchBarController에만 필터가 적용되도록 콜백 설정
    filterController.onSearchFilterUpdated = () {
      fetchSearchResults(searchText.value);
    };
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
    searchText.value = '';
    searchResults.clear();
    setFocus(false);
    suggestions.clear();
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

  // 공식 및 유저 검색 결과 가져오기
  void fetchSearchResults(String query, {int page = 1, int size = 10}) async {
    // 데이터를 가져오기 전까지 로딩 상태
    isLoading.value = true;

    try {
      if (query.isNotEmpty) {
        // 서비스로 검색 결과 리스트 요청
        final results = await _searchService.getCourseResults(
          query,
          page: page,
        );
        log('검색 결과 controller : $results');
        // 총 페이지수 계산
        totalPages.value = (results.length / size).ceil();
        currentPage.value = page;

        // 검색 결과 가져오기
        // 필터링 적용
        var filteredResults = _applyFilters(results);
        searchResults.assignAll(filteredResults);
      } else {
        searchResults.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  // 검색 결과 다음 페이지로 이동
  void fetchNextPage(String query) {
    if (currentPage.value < totalPages.value) {
      fetchSearchResults(
        query,
        page: currentPage.value + 1,
      );
    }
  }

  // 검색 결과 이전 페이지로 이동
  void fetchPreviousPage(String query) {
    if (currentPage.value > 1) {
      fetchSearchResults(
        query,
        page: currentPage.value - 1,
      );
    }
  }

  List<Course> _applyFilters(List<Course> results) {
    var filteredList = results;

    // 난이도 필터 적용
    filteredList = filteredList.where((course) {
      return filterController.selectedDifficulty.contains(course.level);
    }).toList();

    // 거리 필터 적용
    filteredList = filteredList.where((course) {
      final selectedLength = filterController.selectedLength;

      if (selectedLength.contains(3)) {
        return course.courseLength <= 3;
      } else if (selectedLength.contains(5)) {
        return course.courseLength >= 3 && course.courseLength <= 5;
      } else if (selectedLength.contains(10)) {
        return course.courseLength >= 5 && course.courseLength <= 10;
      } else {
        return course.courseLength >= 10;
      }
    }).toList();

    // 정렬 조건 적용
    switch (filterController.sortCondition.value) {
      case '인기순':
        filteredList.sort((a, b) => b.count.compareTo(a.count));
        break;
      case '거리순':
        filteredList.sort((a, b) => a.courseLength.compareTo(b.courseLength));
        break;
      default:
        break;
    }

    return filteredList;
  }

  @override
  void onClose() {
    // 페이지를 떠날 때 검색어 초기화
    focusNode.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}
