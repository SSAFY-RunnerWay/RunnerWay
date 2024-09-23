import 'dart:developer';

import '../repositories/search_repository.dart';

class SearchService {
  final SearchRepository _repository = SearchRepository();

  // 검색어 자동완성 리스트 가져오기
  Future<List<String>> getSuggestions(String query) async {
    final words = await _repository.getWords(query);

    return List<String>.from(words);
  }
}
