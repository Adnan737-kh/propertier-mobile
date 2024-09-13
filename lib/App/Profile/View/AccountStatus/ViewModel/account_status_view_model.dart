import 'package:get/get.dart';
import 'package:propertier/App/Profile/View/AccountStatus/Model/account_status_model.dart';

class AccountStatusViewModel extends GetxController {
  RxList<AccountStatusModel> accountStatusList = <AccountStatusModel>[
    AccountStatusModel(
      onTap: () {},
      title: 'Verified/ Non Verified',
    ),
    AccountStatusModel(
      onTap: () {},
      title: 'Monetize/ Non Monetize',
    ),
    AccountStatusModel(
      onTap: () {},
      title: 'Any Restrictions',
    ),
  ].obs;
}
