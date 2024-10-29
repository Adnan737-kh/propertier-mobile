import 'package:get/get.dart';

import '../../../../App/Auth/Login/Model/user_login_model/user_login_model.dart';
import '../../../../App/Auth/Service/auth_service.dart';

class VendorProfileController extends GetxController{



  Rx<User> user = User().obs;


  Future<User?> getProfile()async{
    UserLoginModel? currentUser = await AuthService().getCurrentUser();
    for(User u in currentUser?.users??[]){
      if(u.type == "vendor"){
        user.value = u;
        return u;
      }
    }
    return null;
  }

}