import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Payment%20Method/Views/Components/payment_methods.dart';
import 'package:propertier/App/Payment%20Method/Views/Components/payment_recommended_methods.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/extensions/size_extension.dart';

import 'Components/payment_other_methods.dart';

class SelectPaymentMethodView extends StatelessWidget {
  const SelectPaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            getHeight(context, 0.050),
            customAppBar(
              context: context,
              title: "Select Payment Method",
              onTap: () {
                Get.back();
              },
            ),
            getHeight(context, 0.045),
            recommendedMethod(
              context: context,
              onTap: () => Get.toNamed(AppRoutes.creditCardPaymentView),
            ),
            getHeight(context, 0.015),
            otherPaymentMethod(context: context),
            getHeight(context, 0.015),
            paymentMethod(
              context: context,
              onTap: () => Get.toNamed(AppRoutes.bankMethodView),
            )
          ],
        ),
      ),
    ));
  }
}
