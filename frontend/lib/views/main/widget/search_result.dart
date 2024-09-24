import 'package:flutter/material.dart';
import 'package:frontend/models/course.dart';

class SearchResult extends StatelessWidget {
  final List<Course> results;

  const SearchResult({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
