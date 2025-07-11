import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({super.key});
  final HomeViewModel viewModel = Get.find<HomeViewModel>();
  final CarouselSliderController _carouselController = CarouselSliderController();

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
              ? const CircularProgressIndicator(color: AppColor.buttonColor)
              : CarouselSlider(
            items: List.generate(
              viewModel.homeModel.value.data!.sliders.length,
                  (index) {
                final slider = viewModel.homeModel.value.data!.sliders[index];
                final imageUrl = slider.image!;
                // Ensure link has a scheme:
                final rawLink = slider.link ?? '';
                final link = rawLink.startsWith('http') ? rawLink : 'https://$rawLink';

                return InstaImageViewer(
                  imageUrl: imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          // first, close any open keyboard/snackbar etc.
                          FocusScope.of(context).unfocus();

                          if (await canLaunchUrl(Uri.parse(link))) {
                            await launchUrl(
                              Uri.parse(link),
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Cannot open link")),
                            );
                          }
                        },
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          width: context.getSize.width,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            options: CarouselOptions(
              height: context.getSize.height * 0.2,
              autoPlay: true, // Enable auto-slide
              autoPlayInterval: const Duration(seconds: 3), // Slide every 3 seconds
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                viewModel.selectedCarouseIndex = index;
              },
            ),
            carouselController: _carouselController,
          )
              : const CircularProgressIndicator(color: AppColor.buttonColor),
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
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        duration: const Duration(milliseconds: 300),
                        height: 4,
                        width: index == viewModel.selectedCarouseIndex ? 7 : 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                index == viewModel.selectedCarouseIndex ? 11 : 50),
                            color: AppColor.white),
                      ),
                    ))),
        ],
      ),
    )
            : const SizedBox(),
    ],
    ),
    ));
  }
}
