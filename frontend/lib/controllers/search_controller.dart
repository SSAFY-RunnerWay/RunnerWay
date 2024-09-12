import 'package:get/get.dart';

class SearchBarController extends GetxController {
  var searchQuery = ''.obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
