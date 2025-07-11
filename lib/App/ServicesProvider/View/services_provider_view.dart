import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/App/ServicesProvider/ViewModel/services_provider_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServicesProviderView extends StatelessWidget {
  const ServicesProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ServicesProviderViewModel>(
          init: ServicesProviderViewModel(),
          builder: (viewModel) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.080),
              child: Column(
                children: [
                  SizedBox(
                    height: context.getSize.height * 0.04,
                  ),
                  customAppBar(
                      context: context,
                      title: '',
                      onTap: () {
                        Get.back();
                      }),
                  getHeight(context, 0.045),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    height: context.getSize.height * 0.18,
                    width: context.getSize.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff109B0E)),
                    child: Column(
                      children: [
                          CustomText(
                            title: context.local.select_services_you_want,
                            fontFamily: 'Rozha One',
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.normal),
                        getHeight(context, 0.05),
                        SearchTextField(
                          suFixIcon: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              Constant.mic,
                            ),
                          ),
                          searchController: viewModel.searchController,
                        ),
                      ],
                    ),
                  ),
                  getHeight(context, 0.010),
                  Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: viewModel.isExpanded == false ? 5 : 20,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 8,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(-1, 1),
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                        )
                                      ],
                                      border: Border.all(
                                        color: const Color(0xfff1f1f1),
                                        width: 1,
                                      ),
                                      color: Colors.white),
                                  child: const Row(
                                    children: [
                                      CustomText(
                                          title: '✓ ',
                                          fontSize: 23,
                                          color: AppColor.buttonColor),
                                      Expanded(
                                          child: CustomText(
                                              textAlign: TextAlign.start,
                                              title:
                                                  'Document verification by advocate,legal expert etc',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              colorOpecity: 0.6,
                                              color: AppColor.primaryColor))
                                    ],
                                  ),
                                ),
                                viewModel.isExpanded == false &&
                                        index == (5 - 1)
                                    ? Positioned(
                                        bottom: -3,
                                        child: GestureDetector(
                                            onTap: () {
                                              viewModel.isExpand(true);
                                            },
                                            child: Container(
                                              height: context.getSize.height *
                                                  0.050,
                                              width: context.getSize.width,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.25),
                                                      offset: Offset(-1, 1),
                                                      blurRadius: 4,
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: AppColor.primaryColor,
                                              ),
                                            )))
                                    : index == (20 - 1) &&
                                            viewModel.isExpanded == true
                                        ? Positioned(
                                            bottom: -3,
                                            child: GestureDetector(
                                              onTap: () {
                                                viewModel.isExpand(false);
                                              },
                                              child: Container(
                                                height: context.getSize.height *
                                                    0.050,
                                                width: context.getSize.width,
                                                decoration: const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.25),
                                                        offset: Offset(-1, 1),
                                                        blurRadius: 4,
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                            ))
                                        : const SizedBox.shrink()
                              ],
                            );
                          })),
                  viewModel.isExpanded == true
                      ? Column(
                          children: [
                            getHeight(context, 0.020),
                            textButton(
                                context: context,
                                title: 'Save',
                                onClick: () {
                                  Get.toNamed(AppRoutes.navBarView);
                                }),
                            getHeight(context, 0.020),
                          ],
                        )
                      : Column(
                          children: [
                            getHeight(context, 0.020),
                            textButton(
                                context: context,
                                title: 'Save',
                                onClick: () {
                                  Get.toNamed(AppRoutes.navBarView);
                                }),
                            getHeight(context, 0.069),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  viewModel.socialMediaButtonsList.length,
                                  (index) => GestureDetector(
                                        onTap: viewModel
                                            .socialMediaButtonsList[index]
                                            .onTap,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Image.asset(
                                            viewModel
                                                .socialMediaButtonsList[index]
                                                .icon,
                                            height: 27,
                                            width: 27,
                                          ),
                                        ),
                                      )),
                            ),
                            getHeight(context, 0.020),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Constant.flag,
                                  width: 12,
                                  height: 9,
                                ),
                                const CustomText(
                                    title: '+447848950763',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                          ],
                        )
                ],
              ),
            ));
          }),
    );
  }
}
