import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/view/feature_ads_detail_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/award_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/profile_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/view/Services_details.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/view/about.dart';
import 'package:propertier/constant/colors.dart';

class ProfileScreen extends StatefulWidget {
   
    final VoidCallback onViewAllTap;

  const ProfileScreen({Key? key, required this.onViewAllTap}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final ProfileController profileController = Get.put(ProfileController());
  final ProfileModel profileModel =
      Get.put(ProfileModel()); // This should be populated with actual data

  late TabController tabController;
  bool isImageAdded = false;
  late String vendorUserId;

  bool showAboutInput = false; // Control visibility of the About section

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

    final box = GetStorage();
    vendorUserId = box.read('vendorUserId') ?? '';

    _initializeData();
  }

  void _openAboutDialog(BuildContext context, String vendorUserId,
      ProfileModel profileModel, ProfileController profileController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AboutContent(
          vendorUserId: vendorUserId,
          profileModel: profileModel,
          aboutText: profileController.profile.value.about ?? '',
          updateUserProfile: (String id, ProfileModel model,
              ProfileController controller, BuildContext ctx) async {
            await controller.updateUserProfile(id, model, controller, ctx);
          },
        );
      },
    );
  }

  Future<void> _initializeData() async {
    final box = GetStorage();
    String? vendorUserId = box.read('vendorUserId');
    print(vendorUserId);

    if (vendorUserId != null) {
      profileController.loadProfile();
      profileController.getServices(vendorUserId);
      profileController.getFeaturedServices(vendorUserId);
      profileController.getAwards(vendorUserId);
    } else {
      profileController.errorMessage.value =
          'Vendor ID is not available or login form vednor side';
    }
  }

  String getElapsedTime(DateTime createdAt) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  ImageProvider _getImageProvider(String? url) {
    if (url == null || url.isEmpty) {
      return const NetworkImage(
          "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D");
    } else if (url.startsWith('http') || url.startsWith('https')) {
      return NetworkImage(url);
    } else {
      return FileImage(File(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileController.errorMessage.isNotEmpty) {
          return Center(
              child: Text('Error: ${profileController.errorMessage}'));
        } else {
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 130,
                          width: Get.size.width,
                          decoration: ShapeDecoration(
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
                            image: DecorationImage(
                              image: _getImageProvider(
                                profileController.profile.value.coverPhotoUrl,
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Positioned(
                          top: Get.height * 0.10,
                          child: Container(
                            width: 106,
                            height: 106,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width:
                                    4, // White border to blend with the background
                              ),
                              image: DecorationImage(
                                image: NetworkImage(profileController
                                        .profile.value.profilePictureUrl ??
                                    "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                profileController.profile.value.followers
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFFFDCD54),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Followers',
                                style: TextStyle(
                                  color: Color(0x99131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 145),
                          Column(
                            children: [
                              Text(
                                profileController.profile.value.likes
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFFFDCD54),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Likes',
                                style: TextStyle(
                                  color: Color(0x99131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Name and Designation
                    Text(
                      profileController.profile.value.name.toString(),
                      style: const TextStyle(
                        color: Color(0xFF131A22),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if(profileController.profile.value.professionTypes != null && profileController.profile.value.professionTypes!.length == 2)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.work_history_rounded,color: Color(0xFFFDCD54),),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                profileController.profile.value.professionTypes![1].toString(),
                                style: const TextStyle(
                                  color: Color(0xFF131A22),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                              ),
                              alignment: Alignment.center,
                              child: Text("License Card",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${profileController.profile.value.name}"),
                              Text(
                                '${profileController.profile.value.designation??""}',
                                style: const TextStyle(
                                  color: Color(0xFFB8B8B8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          RatingBar.builder(
                            initialRating:
                            profileController.profile.value.rating?.toDouble() ??
                                0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 26,
                            ),
                            onRatingUpdate: (rating) async {},
                          ),
                          SizedBox(height: 50,),
                          Obx(() {
                            // Use Obx to listen to changes in expirationDate
                            if (profileController.isLicenseExpired()) {
                              return ElevatedButton(
                                onPressed: profileController.renewLicense,
                                child: Text("Renew License Card"),
                              );
                            } else {
                              return Text(
                                "License valid until: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(profileController.expirationDate.value!)}",
                                style: TextStyle(fontSize: 16),
                              );
                            }
                          }),
                          // ElevatedButton(onPressed: (){
                          //   profileController.renewLicense();
                          // }, child: Text("Proceed")),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    // TabBar
                    TabBar(
                      controller: tabController,
                      labelPadding: EdgeInsets.zero,
                      tabs: const [
                        Text(
                          'About',
                          style: TextStyle(
                            color: Color(0xE5131A22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Award',
                          style: TextStyle(
                            color: Color(0xE5131A22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Appreciations',
                          style: TextStyle(
                            color: Color(0xE5131A22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.5,
                child: TabBarView(controller: tabController, children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),

                          // About Section (TextField with + Button inside)
                          Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: profileController.profile.value.about
                                            ?.toString() ??
                                        '',
                                  ),
                                  enabled: false,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Color(0xFF131A22),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  minLines: 2,
                                  maxLines: 3,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFDCD54),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () => _openAboutDialog(
                                      context,
                                      vendorUserId,
                                      profileModel,
                                      profileController, // Pass the ProfileController instance directly
                                    ),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Color(0xFF131A22),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Uploaded Posts',
                                  style: TextStyle(
                                    color: Color(0xFF131A22),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0.60,
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Color(0xFF109B0E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: profileController.allServices.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 6,
                                    mainAxisExtent: Get.height * .35,
                                    crossAxisSpacing: 6),
                            itemBuilder: (context, index) {
                              final service =
                                  profileController.allServices[index];
                              // Cretead function for days ago
                              final createdAt = service.createdAt;
                              final elapsedTime = getElapsedTime(createdAt!);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 6),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 118,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          service.service?.coverImageUrl
                                                  ?.toString() ??
                                              '', // Use the actual URL from the service or an empty string if null
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            // Display a placeholder or error image if the URL is invalid or null
                                            return Image.asset(
                                              'assets/icons/placeholder.png', // Ensure this asset is added to your project
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              elapsedTime,
                                              style: const TextStyle(
                                                color: Color(0xB2131A22),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.favorite,
                                                  size: 16,
                                                  color: Colors.green,
                                                ),
                                                Text(
                                                  service.likes.toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xB2131A22),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                service.service!.title
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Color(0xFF131A22),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              service.fixedPrice.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xFF109B0E),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_pin,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 3),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Text(
                                                service.service!.description
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Color(0xCC131A22),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _showDeleteDialog(
                                                    context,
                                                    service.id?.toInt() ?? 0,
                                                  );
                                                },
                                                child: Container(
                                                  height: 22,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  decoration: ShapeDecoration(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xFF109B0E)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF109B0E),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (service != null) {
                                                    Get.to(() =>
                                                        ServiceAdsDetailScreen(
                                                            service: service));
                                                    print('Detail tapped');
                                                  } else {
                                                    print('Service is null');
                                                    // Optionally show a message to the user if service is null
                                                  }
                                                },
                                                child: Container(
                                                  height: 22,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  decoration: ShapeDecoration(
                                                    color: const Color(
                                                        0xFFFFCE58), // Background color
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Detail',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xE5131A22),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          profileController.isLoading.value
                              ? const CircularProgressIndicator()
                              : Container(
                                  height: Get.height * .3,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        profileController.allAwards.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 12,
                                            mainAxisExtent: Get.height * .29,
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      final award =
                                          profileController.allAwards[index];

                                      return Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Container(
                                                        height: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                award.imageUrl
                                                                    .toString()),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 8,
                                                      top: 8,
                                                      child: InkWell(
                                                        onTap: () {
                                                          _showAwardDeleteDialog(
                                                              context,
                                                              award.id!
                                                                  .toInt());
                                                        },
                                                        child: Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.red,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          profileController.image == null
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    if (profileController.image != null &&
                                        !profileController.isImageAdded)
                                      Stack(
                                        children: [
                                          Image.file(
                                            File(profileController.image!.path),
                                            height: Get.height * .24,
                                            width: Get.width * .8,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            right: 8,
                                            top: 8,
                                            child: InkWell(
                                              onTap: () {
                                                profileController
                                                    .setImage(null);
                                                profileController.isImageAdded =
                                                    false;
                                                setState(
                                                    () {}); // Rebuild the UI after resetting
                                                // Get.back(); // Close the current screen
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (profileController.image == null &&
                                        !profileController.isImageAdded)
                                      const Text('No image selected'),
                                    if (!profileController.isImageAdded)
                                      ElevatedButton(
                                        onPressed: () async {
                                          final box = GetStorage();
                                          String? vendorUserId =
                                              box.read('vendorUserId');

                                          if (profileController.image != null &&
                                              vendorUserId != null &&
                                              vendorUserId.isNotEmpty) {
                                            AwardModel awardModel = AwardModel(
                                              imagePath:
                                                  profileController.image!.path,
                                              vendorId: vendorUserId,
                                            );

                                            try {
                                              await profileController
                                                  .addService(awardModel);
                                              // Reset the UI after adding the award
                                              profileController.setImage(
                                                  null); // Reset the image
                                              profileController.isImageAdded =
                                                  true; // Set flag to true after adding
                                              setState(
                                                  () {}); // Rebuild the UI to reflect changes
                                            } catch (error) {
                                              Get.snackbar('Error',
                                                  'Failed to add service: $error');
                                            }
                                          } else {
                                            Get.snackbar('Error',
                                                'Please select an image first');
                                          }
                                        },
                                        child: const Text('Add'),
                                      ),
                                  ],
                                ),
                          const SizedBox(height: 18),
                          Container(
                            height: 34,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: ShapeDecoration(
                              color: const Color(0x0C109B0E),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF109B0E)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 9),
                                InkWell(
                                  onTap: () {
                                    profileController.pickImage();
                                  },
                                  child: const Text(
                                    'Add Award',
                                    style: TextStyle(
                                      color: Color(0xFF109B0E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Uploaded Posts',
                                style: TextStyle(
                                  color: Color(0xFF131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10),
                              Opacity(
                                opacity: 0.60,
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Color(0xFF109B0E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          profileController.allFeaturedServices.isEmpty
                              ? const Center(
                                  child: Text('No Featured Service Available'),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: profileController
                                      .allFeaturedServices.length,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 6,
                                          mainAxisExtent: Get.height * .35,
                                          crossAxisSpacing: 6),
                                  itemBuilder: (context, index) {
                                    final service = profileController
                                        .allFeaturedServices[index];
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 118,
                                                decoration:
                                                    const ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                    ),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                      service.coverImageUrl
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/placeholder.png',
                                                      fit: BoxFit.cover,
                                                    );
                                                  }),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                bottom: 12,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 7.43,
                                                      vertical: 2.97),
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Color(0xFFFFCE58),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                14.85),
                                                        bottomRight:
                                                            Radius.circular(
                                                                14.85),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Featured',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF131A22),
                                                          fontSize: 11.88,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    '6 Days Ago',
                                                    style: TextStyle(
                                                      color: Color(0xB2131A22),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.favorite,
                                                        size: 16,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        service.likes
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xB2131A22),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      service.vendorService
                                                          .service.title
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF131A22),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    service.vendorService
                                                        .fixedPrice
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Color(0xFF109B0E),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      service.vendorService
                                                          .service.description
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xCC131A22),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        _showDeleteDialog(
                                                            context,
                                                            service.id.toInt());
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2),
                                                        decoration:
                                                            ShapeDecoration(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFF109B0E)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            profileController
                                                                    .isLoading
                                                                    .value
                                                                ? const CircularProgressIndicator()
                                                                : const Text(
                                                                    'Delete',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF109B0E),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Container(
                                                      height: 22,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFFFFCE58),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                      ),
                                                      child: const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Detail',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xE5131A22),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          profileController.isLoading.value
                              ? const CircularProgressIndicator()
                              : Container(
                                  height: Get.height * .3,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        profileController.allAwards.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 12,
                                            mainAxisExtent: Get.height * .29,
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      final award =
                                          profileController.allAwards[index];

                                      return Container(
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                award.imageUrlss.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       height: Get.height * .3,
                          //       width: Get.width * .44,
                          //       decoration: ShapeDecoration(
                          //         image: const DecorationImage(
                          //           image: NetworkImage(
                          //             'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                          //           ),
                          //           fit: BoxFit.cover,
                          //         ),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5)),
                          //       ),
                          //     ),
                          //     Container(
                          //       height: Get.height * .3,
                          //       width: Get.width * .44,
                          //       decoration: ShapeDecoration(
                          //         image: const DecorationImage(
                          //           image: NetworkImage(
                          //             'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
                          //           ),
                          //           fit: BoxFit.cover,
                          //         ),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5)),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            height: 34,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: ShapeDecoration(
                              color: const Color(0x0C109B0E),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF109B0E)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 9),
                                const Text(
                                  'Add Award',
                                  style: TextStyle(
                                    color: Color(0xFF109B0E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Uploaded Posts',
                                style: TextStyle(
                                  color: Color(0xFF131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: widget.onViewAllTap,
                                child: const Opacity(
                                  opacity: 0.60,
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                      color: Color(0xFF109B0E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          profileController.allFeaturedServices.isEmpty
                              ? const Center(
                                  child: Text('No Featured Service Available'),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: profileController
                                      .allFeaturedServices.length,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 6,
                                          mainAxisExtent: Get.height * .35,
                                          crossAxisSpacing: 6),
                                  itemBuilder: (context, index) {
                                    final featuread = profileController
                                        .allFeaturedServices[index];
                                    final createdAt = featuread.createdAt;
                                    final elapsedTime =
                                        getElapsedTime(createdAt);

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 118,
                                                decoration:
                                                    const ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                    ),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child:
                                                      featuread.coverImageUrl !=
                                                                  null &&
                                                              featuread
                                                                  .coverImageUrl!
                                                                  .isNotEmpty
                                                          ? Image.network(
                                                              featuread
                                                                  .coverImageUrl
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  'assets/icons/placeholder.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                );
                                                              },
                                                            )
                                                          : Image.asset(
                                                              'assets/icons/placeholder.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                bottom: 12,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 7.43,
                                                      vertical: 2.97),
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Color(0xFFFFCE58),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                14.85),
                                                        bottomRight:
                                                            Radius.circular(
                                                                14.85),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Featured',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF131A22),
                                                          fontSize: 11.88,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    elapsedTime,
                                                    style: const TextStyle(
                                                      color: Color(0xB2131A22),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.favorite,
                                                        size: 16,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        featuread.likes
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xB2131A22),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      featuread.vendorService
                                                          .service.title
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF131A22),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    featuread.vendorService
                                                        .fixedPrice
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Color(0xFF109B0E),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      featuread.vendorService
                                                          .service.description
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xCC131A22),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        _showDeleteFeatureDialog(
                                                            context,
                                                            featuread.id
                                                                .toInt());
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2),
                                                        decoration:
                                                            ShapeDecoration(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFF109B0E)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        child: const Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF109B0E),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            FeatureAdsDetailScreen(
                                                                featureAd:
                                                                    featuread));
                                                        print('Detail tapped');
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFFFFCE58), // Background color
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        child: const Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Detail',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xE5131A22),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ));
        }
      }),
    );
  }

  void _showAwardDeleteDialog(BuildContext context, int awardId) {
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                profileController.deleteAward(awardId);
                // print("$serviceId");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, int serviceId) {
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                profileController.deleteService(serviceId);
                // print("$serviceId");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
              },
            ),
          ],
        );
      },
    );
  }
}
