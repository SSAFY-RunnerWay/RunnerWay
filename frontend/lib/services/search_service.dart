import 'dart:developer';

import '../models/course.dart';
import '../repositories/search_repository.dart';

class SearchService {
  final SearchRepository _repository = SearchRepository();

  // 검색어 자동완성 리스트 가져오기
  Future<List<String>> getSuggestions(String query) async {
    final words = await _repository.getWords(query);

    return List<String>.from(words);
  }

  // 키워드로 코스 검색 결과 리스트 가져오기
  Future<Map<String, dynamic>> getCourseResults(String query,
      {int page = 0}) async {
    final results = await _repository.getCourseResults(
      query,
      page,
    );
    log('검색 결과 service: $results');

    return results;
  }
}
