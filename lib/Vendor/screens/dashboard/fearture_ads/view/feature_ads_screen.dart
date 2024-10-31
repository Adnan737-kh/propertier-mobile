import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/screens/dashboard/home/view/filter_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';

import 'feature_ads_detail_screen.dart';

class FeatureAdsScreen extends StatefulWidget {
  const FeatureAdsScreen({super.key});

  @override
  State<FeatureAdsScreen> createState() => _FeatureAdsScreenState();
}

class _FeatureAdsScreenState extends State<FeatureAdsScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    final vendorUserId = GetStorage().read('vendorUserId');
    if (vendorUserId != null) {
      profileController.getFeaturedServices(vendorUserId, forceRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A22),
        iconTheme: const IconThemeData(color: Colors.white, size: 29),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const FilterScreen());
            },
            child: SvgPicture.asset(
              'assets/vendor_assets/filter.svg',
              height: 34,
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: Get.height * .066,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const ShapeDecoration(
              color: Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .048,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: const BorderSide(color: Colors.black12)),
                      hintText: 'Search here',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFF828A89),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      isDense: true,
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (profileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (profileController.allFeaturedServices.isEmpty) {
                return const Center(
                    child: Text('No Featured Service Available'));
              }
              return ListView.builder(
                itemCount: profileController.allFeaturedServices.length,
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 75),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final featureAd =
                      profileController.allFeaturedServices[index];
                  final serviceTitle = featureAd.vendorService.service.title;
                  final fixedPrice = featureAd.vendorService.fixedPrice;
                  final coverImageUrl = featureAd.coverImageUrl;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    color: Colors.white60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 138,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                child: coverImageUrl != null &&
                                        coverImageUrl.isNotEmpty
                                    ? FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/icons/placeholder.png',
                                        image: coverImageUrl,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/icons/placeholder.png',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        'assets/icons/placeholder.png',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 102,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7.43,
                                  vertical: 2.97,
                                ),
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFFFCE58),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(14.85),
                                      bottomRight: Radius.circular(14.85),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Featured',
                                  style: TextStyle(
                                    color: Color(0xFF131A22),
                                    fontSize: 11.88,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Service Title and Price
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 8),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    serviceTitle,
                                    style: const TextStyle(
                                      color: Color(0xB2131A22),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'PKR $fixedPrice',
                                    style: const TextStyle(
                                      color: Color(0xFF109B0E),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'Lorem ipsum dolor sit amet',
                                    style: TextStyle(
                                      color: Color(0xCC131A22),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              // Action buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showDeleteFeatureDialog(
                                          context, 
                                          featureAd.id.toInt());
                                    },
                                    child: Container(
                                      width: Get.width * .44,
                                      height: 24,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            width: 1,
                                            color: Color(0xFF109B0E),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Color(0xFF109B0E),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => FeatureAdsDetailScreen(
                                          featureAd: featureAd));
                                    },
                                    child: Container(
                                      height: 24,
                                      width: Get.width * .44,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF9C852),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Detail',
                                          style: TextStyle(
                                            color: Color(0xE5131A22),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showDeleteFeatureDialog(BuildContext context, int serviceId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this service?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog when canceled
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await profileController.deleteFeaturedService(serviceId);
                final box = GetStorage();
                String? vendorUserId = box.read('vendorUserId');
                if (vendorUserId != null) {
                  await profileController.getFeaturedServices(vendorUserId);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
