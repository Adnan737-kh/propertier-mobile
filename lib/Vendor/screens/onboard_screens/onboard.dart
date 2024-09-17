import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:propertier/Vendor/screens/auth/view/signin_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboard_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.amber,
                    ),
                  ),

                  //Next Button
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: Get.height * .06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            pageController
                                .jumpToPage(controller.items.length - 1);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: const Color(0xFFF9C852))),
                            child: const Center(
                                child: Text(
                              'Skip',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xE5131A22)),
                            )),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: Get.height * .6,
                      width: Get.size.width,
                      decoration: const BoxDecoration(),
                      child: Image.asset(
                        controller.items[index].image,
                        // height: Get.height * .64,
                      ),
                    ),
                    InkWell(
                      // onTap: () {
                      //   if(index==3){
                      //     Get.to(()=>SigninScreen());
                      //   }else{
                      //       pageController.nextPage(
                      //       duration: const Duration(milliseconds: 600),
                      //       curve: Curves.easeIn);
                      //   }

                      // },
                      child: Container(
                        width: Get.width * .5,
                        height: Get.height * .056,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFDCD54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      controller.items[index].descriptions,
                      style: const TextStyle(
                        color: Color(0xB2131A22),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return const SizedBox();
  }
}
