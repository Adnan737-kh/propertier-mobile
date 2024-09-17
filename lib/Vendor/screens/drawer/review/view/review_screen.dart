import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/review/Controller/review_controller.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ReviewController reviewController = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.size.width,
            height: Get.height * .11,
            padding: const EdgeInsets.only(top: 32, left: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.05),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Review',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 26),
                  child: SvgPicture.asset('assets/wallet.svg'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),
          Expanded(
            child: Obx(() {
              if (reviewController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (reviewController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(reviewController.errorMessage.value),
                );
              } else {
                return ListView.builder(
                  itemCount: reviewController.feedbacks.length,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final feedback = reviewController.feedbacks[index];
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Color(0xFFF0F0F0)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: Get.size.width,
                                height: Get.height * .028,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFF0F0F0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Customer ID: ',
                                            style: TextStyle(
                                              color: Color(0xFF109B0E),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                feedback.customer.id.toString(),
                                            style: const TextStyle(
                                              color: Color(0xB2131A22),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      feedback.createdAt
                                          .toString(), // Format this as needed
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xB2131A22),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 44,
                                              height: 44,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(feedback
                                                          .customer
                                                          .profilePictureUrl ??
                                                      "https://example.com/default-profile-pic.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  feedback.customer.name,
                                                  style: const TextStyle(
                                                    color: Color(0xE5131A22),
                                                    fontSize: 11.23,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                RatingBar.builder(
                                                  initialRating: feedback.rating
                                                      .toDouble(),
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 4,
                                                  itemSize: 14,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate:
                                                      (rating) async {},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          height: 24,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF109B0E),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(34),
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      feedback.message,
                                      style: const TextStyle(
                                        color: Color(0x66131A22),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
