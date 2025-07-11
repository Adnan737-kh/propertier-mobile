import 'package:get/get.dart';
import '../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class NavBarViewModel extends GetxController {
  final RxInt _selectedTabIndex = 0.obs;
  int get selectedTabIndex => _selectedTabIndex.value;

  UserPreference userPreference = UserPreference();
  RxnString accessToken = RxnString();

  void setInitialIndex(dynamic index) {
    if (index != null) {
      if (index is int) {
        _selectedTabIndex.value = index;
      } else if (index is String) {
        _selectedTabIndex.value = int.tryParse(index) ?? 0;
      }
    }
  }


  @override
  void onInit() {
    super.onInit();
    getAccessToken();
  }

  void changeSelectedTab(int index) {
    _selectedTabIndex.value = index;
  }

  void getAccessToken() async {
    var user = await userPreference.getUserAccessToken();
    if (user.accessToken != null) {
      accessToken.value = user.accessToken;
    }
  }
}
