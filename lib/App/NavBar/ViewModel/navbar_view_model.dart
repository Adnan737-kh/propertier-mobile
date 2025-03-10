import 'package:get/get.dart';
import '../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class NavBarViewModel extends GetxController {

  UserPreference userPreference = UserPreference();
  final RxInt _selectedTabIndex = 0.obs;
  int get selectedTabIndex => _selectedTabIndex.value;

  // Make accessToken observable
  RxnString accessToken = RxnString();
  @override
  void onInit() {
    super.onInit();
    getAccessToken();  // Load token on initialization

    // userPreference.getUserAccessToken().then((value){
    //   print('acces tkn !!! ${value.accessToken}');
    //   if(value.accessToken!.isEmpty || value.accessToken.toString() == 'null'){
    //
    //   }
    // });
  }

  changeSelectedTab(int index) {
    _selectedTabIndex.value = index;
  }

  void getAccessToken() async {
    var user = await userPreference.getUserAccessToken();
    print("@@@@@@ ${user.accessToken}");
    if (user.accessToken != null) {
      accessToken.value = user.accessToken;  // Updating observable variable
    }
  }
}
