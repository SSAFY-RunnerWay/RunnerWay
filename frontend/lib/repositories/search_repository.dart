import 'dart:developer';

import 'package:frontend/providers/search_provider.dart';

class SearchRepository {
  final SearchProvider _provider = SearchProvider();

  // 검색어 매칭 단어 가져오기
  Future<List<String>> getWords(String query) async {
    final response = await _provider.fetchWords(query);

    return List<String>.from(response.map((item) => item['word'] as String));
  }
}
