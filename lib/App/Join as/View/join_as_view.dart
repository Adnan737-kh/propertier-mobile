import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/colors.dart';
import 'Components/join_as_btn.dart';
import 'Components/service_tile.dart';

class JoinView extends StatelessWidget {
  const JoinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/logo/logo.png",
                width: 200,
              ),
              const Gap(43),
              customJoinAsButton(
                  title: "Join as",
                  onTap: () {
                    Get.toNamed(AppRoutes.servicesProviderView);
                  },
                  buttonColor: AppColor.joinasbtnColor),
              const Gap(15),
              Wrap(
                runSpacing: 10,
                spacing: 10.0,
                direction: Axis.horizontal,
                children: [
                  ServiceTile(
                      context: context,
                      title: "Guest",
                      AssetimageString: "assets/icons/Guest.png",
                      content:
                          "Lorem ipsum dolor sit amet amet consectetur. Neque posuere tortor purus non id dignissim malesuada."),
                  ServiceTile(
                      context: context,
                      title: "Seller",
                      AssetimageString: "assets/icons/Seller.png",
                      content:
                          "Lorem ipsum dolor sit amet amet consectetur. Neque posuere tortor purus non id dignissim malesuada."),
                  ServiceTile(
                      context: context,
                      title: "Supplier",
                      AssetimageString: "assets/icons/Supplier.png",
                      content:
                          "Lorem ipsum dolor sit amet amet consectetur. Neque posuere tortor purus non id dignissim malesuada."),
                  ServiceTile(
                      context: context,
                      title: "Service Provider",
                      AssetimageString: "assets/icons/Service provider.png",
                      content:
                          "Lorem ipsum dolor sit amet amet consectetur. Neque posuere tortor purus non id dignissim malesuada."),
                  ServiceTile(
                      context: context,
                      title: "Corporate Service",
                      AssetimageString: "assets/icons/Corporate Services.png",
                      content:
                          "Lorem ipsum dolor sit amet amet consectetur. Neque posuere tortor purus non id dignissim malesuada."),
                  ServiceTile(
                      context: context,
                      title: "Rental",
                      AssetimageString: "assets/icons/Rental.png",
                      content:
                          "Lorem ipsum dolor sit amet amet consectetur. Neque posuere tortor purus non id dignissim malesuada."),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/facebook.png",
                    width: 27,
                  ),
                  const Gap(15),
                  Image.asset(
                    "assets/icons/twitter.png",
                    width: 27,
                  ),
                  const Gap(15),
                  Image.asset(
                    "assets/icons/insta.png",
                    width: 27,
                  ),
                  const Gap(15),
                  Image.asset(
                    "assets/icons/youtube.png",
                    width: 27,
                  ),
                  const Gap(15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
