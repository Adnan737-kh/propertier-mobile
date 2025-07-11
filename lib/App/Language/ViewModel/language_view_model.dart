import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();
  final _box = GetStorage();
  final _key = "langaugeCode";
  final _languageName = 'languageName';
  List<LanguageModel> languagesList = <LanguageModel>[
    LanguageModel(countryName: "US", language: "English", code: 'en'),
    LanguageModel(countryName: "Pakistan", language: "Urdu", code: 'ur'),
    LanguageModel(
        countryName: "Indonesia", language: "Bahasa Indonesia", code: 'indo'),
    LanguageModel(countryName: "Iran", language: "Persian", code: 'per'),
    LanguageModel(
        countryName: "Bahrain", language: "Arabic,Berber", code: 'arabic'),
  ];

  final RxInt _selectedLanguageIndex = (0).obs;
  final RxString _selectedLanguageCode = ''.obs;
  final RxString _selectedLanguage = ''.obs;
  String get selectedLanguage => _selectedLanguage.value;
  String get selectedLanguageCode => _selectedLanguageCode.value;
  int get selectedLanguageIndex => _selectedLanguageIndex.value;
  switchLanguage(
      {required String languageCode,
      required int index,
      required String languageName}) async {
    await _box.write(_key, languageCode);
    await _box.write(_languageName, languageName);
    await _box.write('langaugeIndex', index);
    Get.updateLocale(Locale(languageCode));
    _selectedLanguageIndex.value = _box.read('langaugeIndex') ?? (0);
    _selectedLanguageCode.value = _box.read(_key) ?? 'en';
    _selectedLanguage.value = _box.read(_languageName) ?? "English";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _selectedLanguageIndex.value = _box.read('langaugeIndex') ?? (0);
    _selectedLanguageCode.value = _box.read(_key) ?? 'en';
    _selectedLanguage.value = _box.read(_languageName) ?? "English";
  }

  final RxList<LanguageModel> _searchList = <LanguageModel>[].obs;
  List<LanguageModel> get searchList => _searchList.value;
  getLanguageBySearch({required String query}) {
    _searchList.value = languagesList
        .where((element) =>
            element.countryName.toLowerCase().contains(query.toLowerCase()) ||
            element.language.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class LanguageModel {
  final String language;
  final String code;
  final String countryName;
  LanguageModel(
      {required this.countryName, required this.language, required this.code});
}
