import 'dart:developer';

import 'package:frontend/providers/search_provider.dart';

import '../models/course.dart';

class SearchRepository {
  final SearchProvider _provider = SearchProvider();

  // 검색어 매칭 단어 가져오기
  Future<List<String>> getWords(String query) async {
    final response = await _provider.fetchWords(query);

    return List<String>.from(response.map((item) => item['word'] as String));
  }

  // 키워드로 공식 코스 검색 결과 리스트 가져오기
  Future<Map<String, dynamic>> getCourseResults(
    String query,
    int page,
  ) async {
    final response = await _provider.fetchSearchResults(
      query,
      page,
    );
    log('공식 코스 검색 결과 repository :  $response');

    return {
      'courses': response['courses']
          .map<Course>((course) => Course.fromJson(course))
          .toList(),
      'totalPages': response['totalPages'],
      'totalElements': response['totalElements'],
    };
  }
}