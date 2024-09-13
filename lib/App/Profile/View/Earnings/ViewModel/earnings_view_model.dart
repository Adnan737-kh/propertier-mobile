import 'package:get/get.dart';
import 'package:propertier/App/Profile/View/Earnings/Model/earnings_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';

class EarningsViewModel extends GetxController {
  RxList<EarningsModel> earningsList = <EarningsModel>[
    EarningsModel(
        onTap: () {
          Get.toNamed(AppRoutes.monetizationView);
        },
        title: 'Monetization'),
    EarningsModel(
        onTap: () {
          Get.toNamed(AppRoutes.teamEarningView);
        },
        title: "Team Earning"),
    EarningsModel(
        onTap: () {
          Get.toNamed(AppRoutes.marketingTeamEarningView);
        },
        title: 'Marketing Team Earning'),
  ].obs;
}
