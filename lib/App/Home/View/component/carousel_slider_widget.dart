// import 'package:carousel_slider/carousel_slider.dart' as cs;
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({super.key});
  final viewModel = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: context.getSize.height * 0.2,
          width: context.getSize.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              viewModel.homeModel.value.data != null
                  ? viewModel.homeModel.value.data!.sliders.isEmpty
                      ? const CircularProgressIndicator(
                          color: AppColor.buttonColor,
                        )
                      : CarouselView(
                          itemExtent: context.width - 50,

                          // controller: CarouselController(),
                          children: List.generate(
                              viewModel.homeModel.value.data!.sliders.length,
                              (index) => viewModel.homeModel.value.data!
                                          .sliders[index].image !=
                                      null
                                  ? InstaImageViewer(
                                      imageUrl: viewModel.homeModel.value.data!
                                          .sliders[index].image!,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          viewModel.homeModel.value.data!
                                              .sliders[index].image!,
                                          fit: BoxFit.cover,
                                          width: context.getSize.width,
                                        ),
                                      ),
                                    )
                                  : const Gap(0)),
                        )
                  : const CircularProgressIndicator(
                      color: AppColor.buttonColor,
                    ),
              viewModel.homeModel.value.data != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.getSize.height * 0.01,
                          horizontal: context.getSize.width * 0.060),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                viewModel.homeModel.value.data!.sliders.length,
                                (index) => Obx(
                                      () => AnimatedContainer(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        height: 4,
                                        width: index ==
                                                viewModel.selectedCarouseIndex
                                            ? 7
                                            : 4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                index ==
                                                        viewModel
                                                            .selectedCarouseIndex
                                                    ? 11
                                                    : 50),
                                            color: AppColor.white),
                                      ),
                                    )),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
