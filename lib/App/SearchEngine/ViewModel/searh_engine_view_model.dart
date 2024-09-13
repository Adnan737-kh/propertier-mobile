import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEngineViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<String> searchEngineData = <String>[
    "Al Maida Hotel",
    "Macdonale Pakistan",
    "Islamabad 20 Marla Plot",
    "Lahore is a Big City",
    "Pakistan Zindabad",
    "Islamabad is very beautiful"
  ].obs;
  final RxList<String> _searchedList = <String>[].obs;
  List<String> get searchedList => _searchedList;

  searchData(String val) {
    _searchedList.clear();
    searchedList.clear();
    for (var element in searchEngineData) {
      if (element.toLowerCase().contains(val.toLowerCase())) {
        _searchedList.add(element);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
}
