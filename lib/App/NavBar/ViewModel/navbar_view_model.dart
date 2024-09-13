import 'package:get/get.dart';

class NavBarViewModel extends GetxController {
  final RxInt _selectedTabIndex = 0.obs;
  int get selectedTabIndex => _selectedTabIndex.value;
  changeSelectedTab(int index) {
    _selectedTabIndex.value = index;
  }
}
